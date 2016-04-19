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
import Result


extension UICollectionView {
    override public func bindViewModel(viewModel:ViewModel?) {
        if (viewModel != nil) {
        self.dataSource = viewModel
        viewModel!.registerNibsForCollectionView(self)
        
        viewModel!.sectionedDataSource.producer.startWithNext {[unowned self] (_) in
            self.reloadData()
        }
    }
    }
    public func receivedError(error:NSError) {}
    public func showLoader() {}
    public func hideLoader() {}
}

extension ViewModel: UICollectionViewDataSource {
    @objc public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSection(section)
    }
    @objc public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.numberOfSections()
    }
    @objc public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.listIdentifierAtIndexPath(indexPath), forIndexPath: indexPath)
        self.bindViewModelToCellAtIndexPath(cell, indexPath:indexPath)
        return cell
    }
    public func bindViewModelToCellAtIndexPath(cell:UICollectionReusableView, indexPath:NSIndexPath!) {
        cell.bindViewModel(self.viewModelAtIndexPath(indexPath))
    }
    
    public func registerNibsForCollectionView(collectionView:UICollectionView) {
        for id in self.listIdentifiers() {
            collectionView.registerNib(UINib.init(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
        }
    }
    
}