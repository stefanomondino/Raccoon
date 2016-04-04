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

        self.title = "Raccoon"
        //self.bindViewModelToCollectionView(viewModel, collectionView: collectionView)
        self.collectionView.delegate = self
        self.bindViewModelToCollectionView(myViewModel, collectionView: self.collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 90)
    }
    override func setViewModel(viewModel: ViewModel?) {
        self.myViewModel = viewModel as DetailViewModel
        
    }
}
