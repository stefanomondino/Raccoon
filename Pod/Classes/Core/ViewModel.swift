import ReactiveCocoa
import ReactiveSwift
import Result

public protocol ViewModelType {
    func listIdentifiers() -> [String]!
    func listViewModelFromModel(_ model:Any!) -> ViewModel!
    func listIdentifierAtIndexPath(_ indexPath:IndexPath) -> String!
}


open class ViewModel:NSObject, ViewModelType {
    
    open lazy var sectionedDataSource:MutableProperty<[[Any]?]> = MutableProperty([])
    open lazy var hasResults:MutableProperty<Bool> = MutableProperty(false)
    open var reloadAction:ReactiveSwift.Action<Any?,[[Any]?],NSError>? {
        didSet {
            if (reloadAction != nil ) {
                sectionedDataSource <~ reloadAction!.values
                hasResults <~ reloadAction!.values.map({ (sectionedDataSource) -> Bool in
                    return sectionedDataSource.reduce(0, { (count, array) -> Int in
                        guard let sum:Int = array!.count else {return count}
                        return count + sum
                    }) > 0
                })
            }
        }
    }
    
    open var dataSource:[Any]?{
        get {
            if (sectionedDataSource.value.first == nil) {
                sectionedDataSource.value = [[]]
            }
            return sectionedDataSource.value.first!
        }
        set {
            
            sectionedDataSource.value =  [newValue ?? []]
            
        }
    }
    
    open func listIdentifiers() -> [String]! {
        return []
    }
    open func listIdentifier() -> String! {
        return String(describing: self)
    }
    open func listViewModelFromModel(_ model: Any!) -> ViewModel! {
        return nil
    }
    open func listIdentifierAtIndexPath(_ indexPath: IndexPath) -> String! {
        return nil
    }
    
    open func viewModelAtIndexPath(_ indexPath:IndexPath) -> ViewModel! {
        return self.listViewModelFromModel(self.modelAtIndexPath(indexPath))
    }
    
    open func modelAtIndexPath(_ indexPath:IndexPath) -> Any! {
        return sectionedDataSource.value[(indexPath as NSIndexPath).section]![(indexPath as NSIndexPath).row]
    }
    open func numberOfSections() -> Int {
        return sectionedDataSource.value.count
    }
    open func numberOfItemsInSection(_ section:Int!) -> Int {
        return sectionedDataSource.value[section]!.count
    }
    
}

