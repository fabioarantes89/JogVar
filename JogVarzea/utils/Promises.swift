import UIKit

protocol PromsieDelegate:NSObjectProtocol{
    func then(promise:Promises)
}

enum PromiseStatus:Int{
    case running = 1
    case error = -1
    case completed = 2
}
class Promises:NSObject {
    var Result:AnyObject?
    var status:PromiseStatus =  PromiseStatus.running
    var callBacks:Dictionary<String,Array<(AnyObject)->Void>> = Dictionary<String,Array<(AnyObject)->Void>>()
    
    func then(closure:(AnyObject)->Void)->Promises{
        if((self.callBacks["success"]) == nil){
            self.callBacks["success"] = Array<(AnyObject) -> Void>()
        }
        (self.callBacks["success"])?.append(closure)
        return self
    }
    func recover(closure:(AnyObject)->Void)->Promises{
        if(self.callBacks["error"]) == nil{
            self.callBacks["error"] = Array<(AnyObject)->Void>()
        }
        (self.callBacks["error"])?.append(closure)
        return self
    }
    func resolv(result:AnyObject){
        self.Result = result
        self.status = PromiseStatus.completed
        if let callBacks = self.callBacks["success"]{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            for i in 0...(callBacks.count-1) {
                let callback = callBacks[i]
                callback(self.Result!)
            }
            
        }
    }
    
    func rejects(result:AnyObject){
        self.Result = result
        self.status = PromiseStatus.error
        if let callBacks = self.callBacks["error"]{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            for i in 0...(callBacks.count-1) {
                let callback = callBacks[i]
                callback(self.Result!)
            }
        }
    }
    override init() {
        super.init()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

}

class PromisesNet: NSObject{
    var Result:ServerHelperDataTransfer?
    var status:PromiseStatus =  PromiseStatus.running
    var callBacks:Dictionary<String,Array<(ServerHelperDataTransfer)->Void>> = Dictionary<String,Array<(ServerHelperDataTransfer)->Void>>()
    
    func then(closure:(ServerHelperDataTransfer)->Void)->PromisesNet{
        if((self.callBacks["success"]) == nil){
            self.callBacks["success"] = Array<(ServerHelperDataTransfer) -> Void>()
        }
        (self.callBacks["success"])?.append(closure)
        return self
    }
    func recover(closure:(ServerHelperDataTransfer)->Void)->PromisesNet{
        if(self.callBacks["error"]) == nil{
            self.callBacks["error"] = Array<(ServerHelperDataTransfer)->Void>()
        }
        (self.callBacks["error"])?.append(closure)
        return self
    }
    func resolv(result:ServerHelperDataTransfer){
        self.Result = result
        self.status = PromiseStatus.completed
        if let callBacks = self.callBacks["success"]{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            for i in 0...(callBacks.count-1) {
                let callback = callBacks[i]
                callback(self.Result!)
            }
            
        }
    }
    
    func rejects(result:ServerHelperDataTransfer){
        self.Result = result
        self.status = PromiseStatus.error
        if let callBacks = self.callBacks["error"]{
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            for i in 0...(callBacks.count-1) {
                let callback = callBacks[i]
                callback(self.Result!)
            }
        }
    }
    override init() {
        super.init()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
}
