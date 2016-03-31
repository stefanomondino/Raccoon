//
//  ViewController.swift
//  Raccoon
//
//  Created by Stefano Mondino on 03/31/2016.
//  Copyright (c) 2016 Stefano Mondino. All rights reserved.
//

import UIKit
import Raccoon


class ListViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    let viewModel = ListViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModelToCollectionView(viewModel, collectionView: collectionView)
        self.collectionView.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 80)
    }
}

