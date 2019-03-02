//
//  TrendingViewController.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: TrendingPresenterProtocol?
    var hotKeyWordResults : [Keyword]?
    var backgroundColors: [UIColor]?
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: 112, height: 150)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.fetchHotKeyword()
        self.presenter?.fetchBackgroundColors()
        self.dispatchToMainQueue {
            self.setUpUI()
        }
    }
    
    func setUpUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(UINib(nibName: "HotKeywordCell", bundle: nil), forCellWithReuseIdentifier: "HotKeywordCollectionViewCell")
    }

    func reloadData() {
        self.dispatchToMainQueue {
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func dismissBtnTouchDown(_ sender: Any) {
        self.presenter?.dismiss()
    }
    
}

extension TrendingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let item = self.hotKeyWordResults?[indexPath.row] {
            if (item.content.range(of: " ") != nil) {
                return CGSize(width: 112, height: 180)
            } else {
                return CGSize(width: 112, height: 150)
            }
        }
        
        return CGSize(width: 0, height: 0)
    }
}

extension TrendingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let results = self.hotKeyWordResults {
            return results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotKeywordCollectionViewCell", for: indexPath) as! HotKeywordCollectionViewCell
        if let keyword = self.hotKeyWordResults?[indexPath.row],
            let bgColor = self.backgroundColors?.first {
            self.backgroundColors = self.backgroundColors?.rearrange(array: self.backgroundColors!, fromIndex: 0, toIndex: (self.backgroundColors?.count)! - 1)
            cell.fillData(item: keyword, backgroundColor: bgColor)
        }
        return cell
    }
}

extension TrendingViewController: TrendingViewProtocol {
    func didRetrivedBackgroundColors(_ result: [UIColor]) {
        self.backgroundColors = result
        self.reloadData()
    }
    
    func didRetrivedHotKeywords(_ result: [Keyword]) {
        self.hotKeyWordResults = result
        self.reloadData()
    }
    
}
