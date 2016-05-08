import ReactiveCocoa
import Result

public protocol ViewModelType {
    typealias T
    func listIdentifiers() -> [String]!
    func listViewModelFromModel(model:T!) -> ViewModel<T>!
    func listIdentifierAtIndexPath(indexPath:NSIndexPath) -> String!
}


public class ViewModel<T>:NSObject, ViewModelType {
    
    public lazy var sectionedDataSource:MutableProperty<[[T]]> = MutableProperty([])
    public lazy var hasResults:MutableProperty<Bool> = MutableProperty(false)
    public var reloadAction:ReactiveCocoa.Action<AnyObject?,[[T]],NSError>? {
        didSet {
            if (reloadAction != nil ) {
                sectionedDataSource <~ reloadAction!.values
                hasResults <~ reloadAction!.values.map({ (sectionedDataSource) -> Bool in
                    return sectionedDataSource.reduce(0, combine: { (count, array) -> Int in
                        guard let sum:Int = array.count else {return count}
                        return count + sum
                    }) > 0
                })
            }
        }
    }
    
    public var dataSource:[T]?{
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
    
    public func listIdentifiers() -> [String]! {
        return []
    }
    public func listIdentifier() -> String! {
        return String(self)
    }
    public func listViewModelFromModel(model: T!) -> ViewModel! {
        return nil
    }
    public func listIdentifierAtIndexPath(indexPath: NSIndexPath) -> String! {
        return nil
    }
    
    public func viewModelAtIndexPath(indexPath:NSIndexPath) -> ViewModel! {
        return self.listViewModelFromModel(self.modelAtIndexPath(indexPath))
    }
    
    public func modelAtIndexPath(indexPath:NSIndexPath) -> T! {
        return sectionedDataSource.value[indexPath.section][indexPath.row]
    }
    public func numberOfSections() -> Int {
        return sectionedDataSource.value.count
    }
    public func numberOfItemsInSection(section:Int!) -> Int {
        return sectionedDataSource.value[section].count
    }
    
}

