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

public struct SegueParameters {
    public var segueIdentifier:String!
    public var viewModel:ViewModel?
    
    public init(segueIdentifier:String!, viewModel:ViewModel?) {
        self.segueIdentifier = segueIdentifier
        self.viewModel = viewModel
    }
}


extension UIView {
    @objc open func bindViewModel(_ viewModel:ViewModel?) {
        if (self.responds(to: Selector("setViewModel:"))) {
            self.setValue(viewModel, forKey: "viewModel")
        //self.performSelector(#selector(setViewModel(_:)), withObject: viewModel)
        }
    }
    
}




