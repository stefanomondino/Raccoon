//
//  RESTManager.swift
//  Raccoon
//
//  Created by Stefano Mondino on 31/03/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import Mantle
import ReactiveCocoa
import SDWebImage

class RESTManager {
    static let sharedInstance = RESTManager()
    let kBaseURL = "https://itunes.apple.com/"
    func searchWithString(search:String?) -> SignalProducer<[AnyObject]?,NSError> {
        return SignalProducer {observer, disposable in
           let request = Alamofire.request(.GET, self.kBaseURL+"search" , parameters: ["term":search ?? ""], encoding:.URL).responseJSON{ response in
                let JSON = response.result.value as? [String : AnyObject] ?? ["":""]
                
                let results = JSON!["results"] as? [AnyObject] ?? []
                do {
                    let tracks = try MTLJSONAdapter.modelsOfClass(Track.self, fromJSONArray: results) as! [Track]
                    
                    observer.sendNext(tracks)
                    observer.sendCompleted()
                } catch let error {
                    observer.sendFailed(error as NSError)
                }
            }
         disposable.addDisposable({ 
            request.cancel()
         })
        }
    }
    
    func getImageFromUrl(url:NSURL?) -> SignalProducer<UIImage?, NSError>{
        let  manager = SDWebImageManager.sharedManager();
        if (url == nil) {
            return SignalProducer.init(value: nil)
        }
        return SignalProducer {observer, disposable in
            observer.sendNext(nil)
            let block: SDWebImageCompletionWithFinishedBlock = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, completed:Bool, imageURL: NSURL!) -> Void in
                if (image != nil){
                    observer.sendNext(image)
                    observer.sendCompleted()
                }
                else {
                    observer.sendFailed(error)
                }
            }
            let operation = manager.downloadImageWithURL(url ,options:SDWebImageOptions.RetryFailed, progress:nil, completed:block )
            disposable.addDisposable(ReactiveCocoa.ActionDisposable.init(action: { () -> () in
                operation.cancel()
            })
            )
        }
    }
}