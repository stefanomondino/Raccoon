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

public struct SegueParameters<T> {
    public var segueIdentifier:String!
    public var viewModel:ViewModel<T>?
    
    public init(segueIdentifier:String!, viewModel:ViewModel<T>?) {
        self.segueIdentifier = segueIdentifier
        self.viewModel = viewModel
    }
}


extension UIView {
    public func bindViewModel<T>(viewModel:ViewModel<T>?) {
        if (self.respondsToSelector(Selector("setViewModel:"))) {
            self.setValue(viewModel, forKey: "viewModel")
        //self.performSelector(#selector(setViewModel(_:)), withObject: viewModel)
        }
    }
    
}




