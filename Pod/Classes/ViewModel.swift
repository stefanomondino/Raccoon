import ReactiveCocoa
import Result

public protocol ViewModelType {
    func cellIdentifiers() -> [String]!
    func cellViewModelFromModel(model:AnyObject!) -> ViewModel!
    func cellIdentifierAtIndexPath(indexPath:NSIndexPath) -> String!
}


public class ViewModel:NSObject, ViewModelType {
    
    public let sectionedDataSource:MutableProperty<[[AnyObject]?]> = MutableProperty([])
    
    public var reloadAction:ReactiveCocoa.Action<AnyObject?,[[AnyObject]?],NSError>? {
        didSet {
            if (reloadAction != nil ) {
                sectionedDataSource <~ reloadAction!.values
            }
        }
    }
    
    public var dataSource:[AnyObject]?{
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
    
    public func cellIdentifiers() -> [String]! {
        return []
    }
    public func cellViewModelFromModel(model: AnyObject!) -> ViewModel! {
        return nil
    }
    public func cellIdentifierAtIndexPath(indexPath: NSIndexPath) -> String! {
        return nil
    }
    
    public func viewModelAtIndexPath(indexPath:NSIndexPath) -> ViewModel! {
        return self.cellViewModelFromModel(self.modelAtIndexPath(indexPath))
    }
    
    public func modelAtIndexPath(indexPath:NSIndexPath) -> AnyObject! {
        return sectionedDataSource.value[indexPath.section]![indexPath.row]
    }
    public func numberOfSections() -> Int {
        return sectionedDataSource.value.count
    }
    public func numberOfItemsInSection(section:Int!) -> Int {
        return sectionedDataSource.value[section]!.count
    }
    
}

