import UIKit

class ServerHelperDataTransfer:NSObject {
    var header:NSHTTPURLResponse!;
    var data:NSData!

    init(headers:NSHTTPURLResponse, data:NSData){
        self.header = headers;
        self.data = data;
    }
}

class ServerHelper:NSObject {
    let defaultSession:NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask:NSURLSessionDataTask?
    
    
    
    func load(url:NSURL) -> Promises {
        
        
        let promise:Promises = Promises();
        
        if self.dataTask != nil {
            self.dataTask?.cancel()
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.dataTask = self.defaultSession.dataTaskWithURL(url) {data, response, error in
            dispatch_async(dispatch_get_main_queue(), {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            
            if error != nil {
                promise.rejects(error!);
            } else {
                if let response:NSHTTPURLResponse! = response as? NSHTTPURLResponse {
                    
                    let transfer:ServerHelperDataTransfer = ServerHelperDataTransfer(headers: response!, data: data!)
                    promise.resolv(transfer);
                }
            }
        }
        self.dataTask?.resume();
        return promise;
        
    }
    
}