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
import ObjectiveC


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
    
    
    struct StaticCellParameters {
        var constraint:NSLayoutConstraint!
        var cell:UICollectionViewCell!
    }
    private struct AssociatedKeys {
        static var StaticCellsID = "Raccoon_staticCellsID"
    }
    
    
    var staticCells:NSMutableDictionary? {
        
        get {
            return  objc_getAssociatedObject(self, &AssociatedKeys.StaticCellsID) as? NSMutableDictionary
        }
        set {
            if let v = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.StaticCellsID, v , objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
   
    
    public func staticCellForSizeAtIndexPath (indexPath:NSIndexPath! ,width:CGFloat!) -> UICollectionViewCell?{
        guard let nib = self.listIdentifierAtIndexPath(indexPath) else {
            return nil
        }
        if (self.staticCells == nil) {
            self.staticCells = NSMutableDictionary()
        }
        var parameters = self.staticCells![nib] as? StaticCellParameters
        if (parameters == nil) {
            let cell = NSBundle.mainBundle().loadNibNamed(nib, owner: self, options: [:]).first as! UICollectionViewCell
            let constraint = NSLayoutConstraint(
                item: cell.contentView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: width)
            cell.contentView.addConstraint(constraint)
            
            parameters = StaticCellParameters(constraint: constraint, cell:cell)
            self.staticCells![nib] = parameters as? AnyObject
        }
        
        parameters!.constraint?.constant = width
        self.bindViewModelToCellAtIndexPath(parameters!.cell, indexPath: indexPath)
        return parameters?.cell
        
    }
    public func autoSizeForItemAtIndexPath(indexPath:NSIndexPath, width:CGFloat) -> CGSize {
        let cell = self.staticCellForSizeAtIndexPath(indexPath, width: width)
        cell?.contentView.setNeedsLayout()
        cell?.contentView.layoutIfNeeded()
        let size = cell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize) ?? CGSizeZero
        return size
    }
    
    
}