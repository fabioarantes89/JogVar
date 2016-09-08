import UIKit

class DataTransporter:NSObject {
    var data:Array<AnyObject> = Array<AnyObject>();
    var params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>();
    
}

class DataModel:NSObject {
    var indexUrl:String = "http://localhost/"
    
    func _defaultListParams(a:DataTransporter, dados:NSDictionary?) {
        a.params["totalPages"] = dados?.valueForKey("totalPages") as? Int
        a.params["currentPage"] = dados?.valueForKey("currentPage") as? Int
        a.params["perPage"] = dados?.valueForKey("perPage") as? Int
        a.params["totalRows"] = dados?.valueForKey("totalRows") as? Int
    }
    
    func _index(data:NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        return a
    }
    
    var serverH:ServerHelper = ServerHelper();
    func index(params:Dictionary<String, String>?) -> Promises {
        let promise:Promises = Promises();
        let url:NSURL = NSURL(string: self.indexUrl)!
        let p = self.serverH.load(url);
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._index(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        return promise;
    }
}