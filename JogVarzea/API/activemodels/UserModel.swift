import UIKit


class DataModel:NSObject {
    var indexUrl:String = "http://localhost/"
    
    
    func _index(data:NSData) -> Array<AnyObject> {
        let a:Array<AnyObject> = Array<AnyObject>();
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

class UserModel:DataModel {
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
    }
}

