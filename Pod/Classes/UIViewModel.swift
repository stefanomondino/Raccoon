//
//  UIViewModel.swift
//  Pods
//
//  Created by Stefano Mondino on 31/03/16.
//
//

import Foundation
import UIKit
import ReactiveCocoa


public struct SegueParameters {
    public var segueIdentifier:String!
    public var viewModel:ViewModel?
    
    public init(segueIdentifier:String!, viewModel:ViewModel?) {
        self.segueIdentifier = segueIdentifier
        self.viewModel = viewModel
    }
}

extension UICollectionReusableView {
    
    public func setViewModel(viewModel:ViewModel?) {
        
    }
}

extension ViewModel: UICollectionViewDataSource {
    @objc public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSection(section)
    }
    @objc public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.numberOfSections()
    }
    @objc public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifierAtIndexPath(indexPath), forIndexPath: indexPath)
        self.bindViewModelToCellAtIndexPath(cell, indexPath:indexPath)
        return cell
    }
    public func bindViewModelToCellAtIndexPath(cell:UICollectionReusableView, indexPath:NSIndexPath!) {
        cell.setViewModel(self.viewModelAtIndexPath(indexPath))
    }
    public func registerCellsForCollectionView(collectionView:UICollectionView) {
        for id in self.cellIdentifiers() {
            collectionView.registerNib(UINib.init(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
        }
    }
    public func cellIdentifier() -> String! {
        return ""
    }
}




extension UIViewController {

    
    public func performSegueWithIdentifier(identifier:String!, viewModel:ViewModel?) {
        let signalProducer:SignalProducer<UIViewController,NSError>  = self.rac_signalForSelector(#selector(prepareForSegue))
            .toSignalProducer()
            .take(1)
            .map({
                let segue:UIStoryboardSegue = ($0! as! RACTuple).first as! UIStoryboardSegue
                return segue.destinationViewController as! UIViewController
                })
        
        signalProducer.startWithNext { (viewController) in
            viewController.setViewModel(viewModel)
        }
        
        
        
        
        
        self .performSegueWithIdentifier(identifier, sender: self)
    }
    
    public func bindViewModelToCollectionView(viewModel:ViewModel!, collectionView:UICollectionView!) {
        collectionView.dataSource = viewModel
        viewModel.registerCellsForCollectionView(collectionView)
        viewModel.reloadAction?.errors.observeNext({[unowned self] (error) in
            self.receivedError(error)
        })
        viewModel.reloadAction?.executing.producer.startWithNext({[unowned self] (show) in
            if (show) {
                self.showLoader()
            }
            else {
                self.hideLoader()
            }
        })
        viewModel.sectionedDataSource.producer.startWithNext { (_) in
            collectionView .reloadData()
        }
    }
    public func setViewModel(viewModel:ViewModel?){}
    public func receivedError(error:NSError) {}
    public func showLoader() {}
    public func hideLoader() {}
}