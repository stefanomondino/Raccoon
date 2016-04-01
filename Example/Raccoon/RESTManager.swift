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



class RESTManager {
    static let sharedInstance = RESTManager()
    let kBaseURL = "https://itunes.apple.com/"
    func searchWithString(search:String?) -> SignalProducer<[AnyObject]?,NSError> {
        return SignalProducer {observer, disposable in
            Alamofire.request(.GET, self.kBaseURL+"search" , parameters: ["term":search ?? ""], encoding:.URL).responseJSON{ response in
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
            
        }
    }
}