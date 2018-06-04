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
import ReactiveSwift
import Result


@objc public protocol UIViewControllerRaccoon {
    @objc func setViewModel(_ viewModel:ViewModel!)
    @objc var viewModel:ViewModel {get set}
}

extension UIViewController {
    
    open func performSegueWithIdentifier(_ identifier:String!, viewModel:ViewModel?) {
        
        let signal = self.reactive.signal(for: #selector(prepare(for:sender:)))
            .producer
            .take(first: 1)
            .map { input in
                
                let segue:UIStoryboardSegue = input.first as! UIStoryboardSegue
                return segue.destination
            }
            .flatMap(FlattenStrategy.latest) { (viewController:UIViewController) -> SignalProducer<UIViewController, NSError> in
                if let navController = viewController as? UINavigationController ,
                    let vc = navController.topViewController {
                    
                    return SignalProducer<UIViewController, NSError>(value:vc)
                }
                return SignalProducer<UIViewController, NSError>(value:viewController)
        }
        
        signal.startWithResult { (result) in
            result.value?.bindViewModel(viewModel)
        }
        
        self.performSegue(withIdentifier: identifier, sender: self)
        
    }
    
    
    public func viewWillAppearSignalProducer() -> SignalProducer<Bool,NoError> {
        let  signal = self.reactive.signal(for: #selector(viewWillAppear(_:)))
            .producer
            .promoteError()
            .map{ input -> Bool in
                let animated:Bool = (input.first as? Bool) ?? false
                return animated
        }
        return signal
    }
    
    public func viewDidAppearSignalProducer() -> SignalProducer<Bool,NoError> {
        let  signal = self.reactive.signal(for: #selector(viewDidAppear(_:)))
            .producer
            .promoteError()
            .map{ input -> Bool in
                let animated:Bool = (input.first as? Bool) ?? false
                return animated
        }
        return signal
    }
    
    public func viewWillDisappearSignalProducer() -> SignalProducer<Bool,NoError> {
        let  signal = self.reactive.signal(for: #selector(viewWillDisappear(_:)))
            .producer
            .promoteError()
            .map{ input -> Bool in
                let animated:Bool = (input.first as? Bool) ?? false
                return animated
        }
        return signal
    }
    public func viewDidDisappearSignalProducer() -> SignalProducer<Bool,NoError> {
        let  signal = self.reactive.signal(for: #selector(viewDidDisappear(_:)))
            .producer
            .promoteError()
            .map{ input -> Bool in
                let animated:Bool = (input.first as? Bool) ?? false
                return animated
        }
        return signal
    }
    
    @objc open func bindViewModel(_ viewModel:ViewModel?) {
        
        if let vm = viewModel
        {
            if self.responds(to: #selector(setter: UIViewControllerRaccoon.viewModel)) {
                self.perform(#selector(setter: UIViewControllerRaccoon.viewModel), with: viewModel!)
            }else if self.responds(to: #selector(UIViewControllerRaccoon.setViewModel(_:))) {
                self.perform(#selector(UIViewControllerRaccoon.setViewModel(_:)), with: vm)
            }
            vm.reloadAction?.errors.observeResult({[weak self] (result) in
                if let error = result.value {
                    self?.receivedError(error)
                }
            })
            //            vm.reloadAction?.isExecuting
            //                .producer
            //                .startWithResult({[weak self] (result) in
            //                    if (result.value == true)  {
            //                        self?.showLoader()
            //                    }
            //                    else {
            //                        self?.hideLoader()
            //                    }
            //                })
        }
        
    }
    
    @objc open func receivedError(_ error:NSError) {}
    @objc open func showLoader() {}
    @objc open func hideLoader() {}
}
