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
import ReactiveSwift
import ReactiveObjC
import Result





@objc protocol UIViewControllerRaccoon {
    @objc func setViewModel(_ viewModel:ViewModel!)
}


extension UIViewController {
    
    open func performSegueWithIdentifier(_ identifier:String!, viewModel:ViewModel?) {
        let signalProducer:SignalProducer<UIViewController,NSError>  = self.rac_signal(for: #selector(prepare(`for`:sender:)))
            .toSignalProducer()
            .take(first:1)
            .map({
                let segue:UIStoryboardSegue = ($0! as! RACTuple).first as! UIStoryboardSegue
                return segue.destination 
            }).flatMap(FlattenStrategy.latest) { (viewController:UIViewController) -> SignalProducer<UIViewController, NSError> in
            if (viewController is UINavigationController) {
                let vc = (viewController as! UINavigationController).topViewController
                return SignalProducer<UIViewController, NSError>(value:vc!)
            }
            return SignalProducer<UIViewController, NSError>(value:viewController)
        }
        signalProducer.startWithResult { (result) in
            result.value?.bindViewModel(viewModel)
        }
        
        self.performSegue(withIdentifier: identifier, sender: self)
    }
    
    public func viewWillAppearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signal(for: #selector(UIViewController.viewWillAppear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })

        return signalProducer
    }
    public func viewDidAppearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signal(for: #selector(UIViewController.viewDidAppear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })
        
        return signalProducer
    }
    public func viewWillDisappearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signal(for: #selector(UIViewController.viewWillDisappear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })
        
        return signalProducer
    }
    public func viewDidDisappearSignalProducer() -> SignalProducer<Bool,NoError> {
        let signalProducer:SignalProducer<Bool,NoError> = self
            .rac_signal(for: #selector(UIViewController.viewDidDisappear(_:))).toSignalProducer()
            .flatMapError({_ in return .empty})
            .map({
                let animated:Bool = ($0! as! RACTuple).first as! Bool
                return animated
            })
        
        return signalProducer
    }
    
    open func bindViewModel(_ viewModel:ViewModel?) {
        if (self.responds(to: #selector(UIViewControllerRaccoon.setViewModel(_:)))) {
            //self.setValue(viewModel, forKey: "viewModel")
            self.perform(#selector(UIViewControllerRaccoon.setViewModel(_:)), with: viewModel)
        }
       _ = viewModel?.reloadAction?.errors.observeResult({[weak self] (result) in
          self?.receivedError(result.value!)
        })
        viewModel?.reloadAction?.isExecuting.producer.startWithResult({[weak self] (result) in
            if (result.value == true)  {
                self?.showLoader()
            }
            else {
                self?.hideLoader()
            }        })
    }
    
   
    
    
//    public func setViewModel(viewModel:ViewModel?){}
    open func receivedError(_ error:NSError) {}
    open func showLoader() {}
    open func hideLoader() {}
}
