//
//  DetailController.swift
//  Raccoon
//
//  Created by Leongiovanni on 12/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Raccoon
import ReactiveCocoa
import Result

class DetailController: UIViewController {

    //@IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView: UIStackView!
    var myViewModel:DetailModel?
    //    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = myViewModel?.trackDetail.trackName
        //self.collectionView.delegate = self
        //self.bindViewModelToCollectionView(myViewModel, collectionView: self.collectionView)
        //self.bindViewModelToStackView(myViewModel, stackView: self.collectionView)
        self.collectionView.bindViewModel(self.myViewModel)
        print(self.myViewModel)
    }

    override func bindViewModel(viewModel: ViewModel?) {
        self.myViewModel = viewModel as! DetailModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
//
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        if indexPath.indexAtPosition(0) == 0{
//            return CGSizeMake(collectionView.frame.size.width, 100)
//        }else if indexPath.indexAtPosition(0) == 5{
//            return CGSizeMake(collectionView.frame.size.width, 60)
//        }else{
//            return CGSizeMake(collectionView.frame.size.width, 40)
//        }
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
