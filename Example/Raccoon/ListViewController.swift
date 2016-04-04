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
        
        //self.navigationController?.navigationBarHidden = true
        self.title = "Raccoon"
        self.bindViewModelToCollectionView(viewModel, collectionView: collectionView)
        self.collectionView.delegate = self
        
        self.viewModel.nextAction.values.observeNext{[unowned self] (segueParameters:SegueParameters!) in
            //print("tuple: " + String(tuple))
            //      if tuple != nil {
            self.performSegueWithIdentifier(segueParameters.segueIdentifier, viewModel:segueParameters.viewModel )
            //      }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 90)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print("click")
        self.viewModel.nextAction.apply(indexPath).start()
        
    }
}

