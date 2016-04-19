//
//  DetailViewController.swift
//  Raccoon
//
//  Created by Leongiovanni on 04/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon

class DetailViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var myViewModel:DetailViewModel?
//    let viewModel = DetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = myViewModel?.trackDetail.trackName
        self.collectionView.delegate = self
        //self.bindViewModelToCollectionView(myViewModel, collectionView: self.collectionView)
        self.collectionView.bindViewModel(myViewModel)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.indexAtPosition(0) == 0{
            return CGSizeMake(collectionView.frame.size.width, 100)
        }else if indexPath.indexAtPosition(0) == 5{
            return CGSizeMake(collectionView.frame.size.width, 60)
        }else{
            return CGSizeMake(collectionView.frame.size.width, 40)
        }
    }
    override func bindViewModel(viewModel: ViewModel?) {
        self.myViewModel = viewModel as? DetailViewModel
    }
    
}
