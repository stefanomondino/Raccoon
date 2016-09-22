//
//  UIViewModel.swift
//  Pods
//
//  Created by Stefano Mondino on 31/03/16.
//
//

import Foundation
import UIKit
import ReactiveObjCBridge
import Result
import ObjectiveC


extension UICollectionView {
    
    
    
    override public func bindViewModel(_ viewModel:ViewModel?) {
        if (viewModel != nil) {
        self.dataSource = viewModel
        viewModel!.registerNibsForCollectionView(self)
        
        _ = viewModel!.sectionedDataSource.producer.startWithResult{[weak self] (_) in
            self?.reloadData()
        }
    }
    }
    public func receivedError(_ error:NSError) {}
    public func showLoader() {}
    public func hideLoader() {}
    
    
}

extension UICollectionReusableView {
    /** This should be override whenever collectionView autosizing is enabled to specify custom logic to resize a viewModel-driven cell
     An example: a list item with multiline title and fixed-size image downloaded from the Internet. Title should be set inside bindViewModelForResize method, but the image should be downloaded only inside bindViewModel: method. TODO explain better
    */
 
    public func bindViewModelForResize(_ viewModel: ViewModel?) {
            self.bindViewModel(viewModel)
    }
}

extension ViewModel: UICollectionViewDataSource {
    @objc public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSection(section)
    }
    @objc public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSections()
    }
    @objc public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.listIdentifierAtIndexPath(indexPath), for: indexPath)
        self.bindViewModelToCellAtIndexPath(cell, indexPath:indexPath, forResize: false)
        return cell
    }
    public func bindViewModelToCellAtIndexPath(_ cell:UICollectionReusableView, indexPath:IndexPath!, forResize:Bool!) {
        if (forResize == true) {
            cell.bindViewModelForResize(self.viewModelAtIndexPath(indexPath))
        }
        else {
            cell.bindViewModel(self.viewModelAtIndexPath(indexPath))
        }
    }
    
    public func registerNibsForCollectionView(_ collectionView:UICollectionView) {
        for id in self.listIdentifiers() {
            collectionView.register(UINib.init(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
        }
    }
    
    
    struct StaticCellParameters {
        var constraint:NSLayoutConstraint!
        var cell:UICollectionViewCell!
    }
    fileprivate struct AssociatedKeys {
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
   
    
    public func staticCellForSizeAtIndexPath (_ indexPath:IndexPath! ,width:CGFloat!) -> UICollectionViewCell?{
        guard let nib = self.listIdentifierAtIndexPath(indexPath) else {
            return nil
        }
        if (self.staticCells == nil) {
            self.staticCells = NSMutableDictionary()
        }
        var parameters = self.staticCells![nib] as? StaticCellParameters
        
        if (parameters == nil) {
            let cell = Bundle.main.loadNibNamed(nib, owner: self, options: [:])!.first as! UICollectionViewCell
            cell.contentView.translatesAutoresizingMaskIntoConstraints = false
            let constraint = NSLayoutConstraint(
                item: cell.contentView,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: width)
            cell.contentView.addConstraint(constraint)
            parameters = StaticCellParameters(constraint: nil, cell:cell)
            self.staticCells![nib] = parameters as? AnyObject
        }

        parameters!.constraint?.constant = width
        self.bindViewModelToCellAtIndexPath(parameters!.cell, indexPath: indexPath, forResize: true)
        return parameters?.cell
        
    }
    public func autoSizeForItemAtIndexPath(_ indexPath:IndexPath, width:CGFloat) -> CGSize {
        let cell = self.staticCellForSizeAtIndexPath(indexPath, width: width)
        cell?.contentView.setNeedsLayout()
        cell?.contentView.layoutIfNeeded()
        let size = cell?.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize) ?? CGSize.zero
        return size
    }
    
    
}
