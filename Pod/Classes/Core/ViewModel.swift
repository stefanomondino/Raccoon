import ReactiveCocoa
import Result

public protocol ViewModelType {
    func listIdentifiers() -> [String]!
    func listViewModelFromModel(model:AnyObject!) -> ViewModel!
    func listIdentifierAtIndexPath(indexPath:NSIndexPath) -> String!
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
    
    public func listIdentifiers() -> [String]! {
        return []
    }
    public func listIdentifier() -> String! {
        return String(self)
    }
    public func listViewModelFromModel(model: AnyObject!) -> ViewModel! {
        return nil
    }
    public func listIdentifierAtIndexPath(indexPath: NSIndexPath) -> String! {
        return nil
    }
    
    public func viewModelAtIndexPath(indexPath:NSIndexPath) -> ViewModel! {
        return self.listViewModelFromModel(self.modelAtIndexPath(indexPath))
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

