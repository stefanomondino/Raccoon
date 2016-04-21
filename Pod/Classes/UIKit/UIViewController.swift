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





@objc protocol UIViewControllerRaccoon {
    @objc func setViewModel(viewModel:ViewModel!)
}


extension UIViewController {
    
    public func performSegueWithIdentifier(identifier:String!, viewModel:ViewModel?) {
        let signalProducer:SignalProducer<UIViewController,NSError>  = self.rac_signalForSelector(#selector(prepareForSegue))
            .toSignalProducer()
            .take(1)
            .map({
                let segue:UIStoryboardSegue = ($0! as! RACTuple).first as! UIStoryboardSegue
                return segue.destinationViewController 
            }).flatMap(FlattenStrategy.Latest) { (viewController:UIViewController) -> SignalProducer<UIViewController, NSError> in
            if (viewController is UINavigationController) {
                let vc = (viewController as! UINavigationController).topViewController
                return SignalProducer<UIViewController, NSError>(value:vc!)
            }
            return SignalProducer<UIViewController, NSError>(value:viewController)
        }
        
        signalProducer.startWithNext { (viewController) in
            viewController.bindViewModel(viewModel)
        }
        self .performSegueWithIdentifier(identifier, sender: self)
    }
    
    public func viewWillAppearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signalForSelector(#selector(UIViewController.viewWillAppear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })

        return signalProducer
    }
    public func viewDidAppearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signalForSelector(#selector(UIViewController.viewDidAppear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })
        
        return signalProducer
    }
    public func viewWillDisappearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signalForSelector(#selector(UIViewController.viewWillDisappear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })
        
        return signalProducer
    }
    public func viewDidDisappearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signalForSelector(#selector(UIViewController.viewDidDisappear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })
        
        return signalProducer
    }
    
    public func bindViewModel(viewModel:ViewModel?) {
        if (self.respondsToSelector(#selector(UIViewControllerRaccoon.setViewModel(_:)))) {
            //self.setValue(viewModel, forKey: "viewModel")
            self.performSelector(#selector(UIViewControllerRaccoon.setViewModel(_:)), withObject: viewModel)
        }
        viewModel!.reloadAction?.errors.observeNext({[unowned self] (error) in
            self.receivedError(error)
            })
        viewModel!.reloadAction?.executing.producer.startWithNext({[unowned self] (show) in
            if (show) {
                self.showLoader()
            }
            else {
                self.hideLoader()
            }
            })
    }
    
   
    
    
//    public func setViewModel(viewModel:ViewModel?){}
    public func receivedError(error:NSError) {}
    public func showLoader() {}
    public func hideLoader() {}
}