//
//  APIClient.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class APIClient {
    
    static var shared = APIClient()
    
    func requestAPI(url: URL, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Task<(DataResponse<Any>)> {
        return Task.init(resolver: { (seal) in
            Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (responseData) in
                if responseData.response?.statusCode == 200 {
                    if responseData.result.isSuccess  {
                        seal.resolve(responseData)
                    } else {
                        if let error = responseData.result.error {
                            seal.reject(error)
                        }
                    }
                } else {
                    let error = NSError.init(domain: "", code: responseData.response?.statusCode ?? 0, userInfo: nil)
                    seal.reject(error)
                }
            })
        })
    }
    
    func requestImage(url: URL) -> Task<UIImage> {
        return Task<UIImage>.init(resolver: { (seal) in
            Alamofire.request(url, method: .get).responseImage(completionHandler: { (dataResponse) in
                if let error = dataResponse.error {
                    seal.reject(error)
                }
                if let image = dataResponse.result.value {
                    seal.resolve(image)
                }
            })
        })
    }
}

