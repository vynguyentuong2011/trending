//
//  TrendingViewController.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/4/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var presenter: TrendingPresenterProtocol?
    var hotKeyWordResults : [Keyword]?
    var backgroundColors: [UIColor]?
    let kMinWidthItem = 112
    let kWidthSizePerImage = 96
    let kHeightSizePerImage = 96
    let kHeightSizePerDoubleContentBox = 60
    let kPadding = 16
    let kEmptyString = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.fetchHotKeyword()
        self.presenter?.fetchBackgroundColors()
        self.dispatchToMainQueue {
            self.setUpUI()
        }
    }

    @IBAction func dismissBtnTouchDown(_ sender: Any) {
         self.presenter?.dismiss()
    }
    
    func setUpUI() {
        collectionView.register(UINib(nibName: "HotKeywordCell", bundle: nil), forCellWithReuseIdentifier: "HotKeywordCollectionViewCell")
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        self.scrollView.isDirectionalLockEnabled = false
    }
    
    func reloadData() {
        self.dispatchToMainQueue {
            self.collectionView.reloadData()
        }
    }
}

extension TrendingViewController: UICollectionViewDataSource, UICollectionViewDelegate {

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

extension TrendingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let keyword = self.hotKeyWordResults?[indexPath.row] {
            if keyword.content.range(of: kEmptyString) == nil {
                let widthItem = kMinWidthItem
                let heightItem = kHeightSizePerImage + kHeightSizePerDoubleContentBox
                return CGSize(width: widthItem, height: heightItem)
            } else {
                let heightItem = kHeightSizePerImage + kHeightSizePerDoubleContentBox
                let widthContent = self.hotKeyWordResults?[indexPath.row].content.size(withAttributes: nil).width
                let widthItem = max(kMinWidthItem, Int(widthContent! + CGFloat(kPadding * 2)))
                return CGSize(width: Int(widthItem), height: heightItem)
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
}
