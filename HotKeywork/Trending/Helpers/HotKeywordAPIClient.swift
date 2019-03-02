//
//  HotKeywordAPIClient.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import SwiftyJSON

enum EndpointURL: String {
    case hotKeyword = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json"
}

class HotKeywordAPIClient: APIClient {
    static var sharedInstance = HotKeywordAPIClient()
    
    func loadAllHotKeywordFromServer() -> Task<[Keyword]> {
        return Task<[Keyword]>.init(resolver: { (seal) in
            _ = self.requestAPI(url: URL(string: EndpointURL.hotKeyword.rawValue)!, method: .get, parameters: nil, headers: nil).onSuccess { (dataResponse) in
                var results : [Keyword] = []
                let myGroup = DispatchGroup()

                if let value = dataResponse.result.value as? Dictionary<String,Any> {
                    let jsonData = value["keywords"] as? [[String:Any]]
                    let jsonArray = JSON(jsonData!)
                    for (_, subJson): (String, JSON) in jsonArray {
                        myGroup.enter()
                        let keyword = subJson["keyword"].stringValue
                        let iconURL = subJson["icon"].stringValue
                        self.loadIconImageFromURL(urlString: iconURL).onSuccess(action: { (iconImage) in
                            results.append(Keyword(content: keyword, image: iconImage))
                            myGroup.leave()
                        }).onError(action: { (error) in
                            seal.reject(error)
                        })
                    }
                    
                    myGroup.notify(queue: .main, execute: {
                        seal.resolve(results)
                    })
                }
                }.onError { (error) in
                    seal.reject(error)
            }
        })
    }
    
    func loadIconImageFromURL(urlString: String) -> Task<UIImage> {
        return Task<UIImage>.init(resolver: { (seal) in
            _ = self.requestImage(url: URL(string: urlString)!).onSuccess(action: { (image) in
                seal.resolve(image)
            }).onError(action: { (error) in
                seal.reject(error)
            })
        })
    }
}
