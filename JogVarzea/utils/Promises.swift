import UIKit

protocol PromsieDelegate:NSObjectProtocol{
    func then(promise:Promises)
}

enum PromiseStatus:Int{
    case running = 1
    case error = -1
    case completed = 2
}

class Promises: NSObject{
    var Result:AnyObject?
    var status:PromiseStatus =  PromiseStatus.running
    var callBacks:Dictionary<String,Array<()->Void>> = Dictionary<String,Array<()->Void>>()
    
    func then(closure:()->Void)->Promises{
        if((self.callBacks["success"]) == nil){
            self.callBacks["success"] = Array<() -> Void>()
        }
        (self.callBacks["success"])?.append(closure)
        return self
    }
    func recover(closure:()->Void)->Promises{
        if(self.callBacks["error"]) == nil{
            self.callBacks["error"] = Array<()->Void>()
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
                callback()
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
                callback()
            }
        }
    }
    override init() {
        super.init()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
}
