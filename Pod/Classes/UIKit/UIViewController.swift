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
    
    public func bindViewModel(viewModel:ViewModel?) {
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