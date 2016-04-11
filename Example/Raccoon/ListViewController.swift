//
//  ViewController.swift
//  Raccoon
//
//  Created by Stefano Mondino on 03/31/2016.
//  Copyright (c) 2016 Stefano Mondino. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa
import Result

class ListViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    let viewModel = ListViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBarHidden = true
        self.title = "Raccoon"
        self.bindViewModelToCollectionView(viewModel, collectionView: collectionView)
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        
        self.viewModel.searchString.producer
            .skipRepeats{$0 == $1}
            .startWithNext{[unowned self] in self.searchBar!.text = $0}
        
        self.viewModel.searchString <~ self.searchBar!.rac_textSignal()
            .toSignalProducer()
            .flatMapError({ (error) -> SignalProducer<AnyObject?, NoError> in return .empty })
            .map{$0 as? String}
            .skipRepeats{$0 == $1}
       
        
        self.viewModel.nextAction.values.observeNext{[unowned self] (segueParameters:SegueParameters!) in
            self.performSegueWithIdentifier(segueParameters.segueIdentifier, viewModel:segueParameters.viewModel )
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

