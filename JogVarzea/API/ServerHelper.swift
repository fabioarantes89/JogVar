import UIKit

enum APIUTILS:String {
    case ACCESS_TOKEN = "ACCESS_TOKEN", Authorization = "Authorization", errorDomain = "torquatoStudios.jogVarzea", bearer = "Bearer: "
}

class ServerHelperDataTransfer:NSObject {
    var header:NSHTTPURLResponse!;
    var data:NSData!
    var error:NSError?

    init(headers:NSHTTPURLResponse, data:NSData){
        self.header = headers;
        self.data = data;
    }
    init(headers:NSHTTPURLResponse, error:NSError, data:NSData?){
        self.header = headers;
        self.error = error;
        if let data = data {
            self.data = data;
        }
    }
}

class ServerHelper:NSObject {
    let defaultSession:NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask:NSURLSessionDataTask?
    
    
    func _authenticate(req:NSMutableURLRequest){
        let token:String? = NSUserDefaults.standardUserDefaults().valueForKey(APIUTILS.ACCESS_TOKEN.rawValue) as? String
        
        if let token = token {
            let auth = String(stringInterpolation: APIUTILS.bearer.rawValue, token)
            req.setValue(auth, forHTTPHeaderField: APIUTILS.Authorization.rawValue)
        }
        
    }
    
    func loadRequest(req:NSMutableURLRequest) -> PromisesNet {
        let promise:PromisesNet = PromisesNet();
        
        if self.dataTask != nil {
            self.dataTask?.cancel()
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        if(req.valueForHTTPHeaderField(APIUTILS.Authorization.rawValue) == nil){
            self._authenticate(req);
        }
        
        
        self.dataTask = self.defaultSession.dataTaskWithRequest(req, completionHandler: {data, response, error in
            dispatch_async(dispatch_get_main_queue(), {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            
            if error != nil {
                if let response:NSHTTPURLResponse! = response as? NSHTTPURLResponse {
                    let transfer:ServerHelperDataTransfer = ServerHelperDataTransfer(headers: response!, error: error!, data:nil)
                    promise.rejects(transfer);
                }
            } else {
                if let response:NSHTTPURLResponse! = response as? NSHTTPURLResponse {
                    if (response?.statusCode) != nil  &&  ((response?.statusCode) == 200 || (response?.statusCode) == 201 || (response?.statusCode) == 202){
                        
                        let transfer:ServerHelperDataTransfer = ServerHelperDataTransfer(headers: response!, data: data!)
                        promise.resolv(transfer);
                    } else {
                        let transfer:ServerHelperDataTransfer = ServerHelperDataTransfer(headers: response!, error: NSError(domain: APIUTILS.errorDomain.rawValue, code: response!.statusCode, userInfo: nil), data:data);
                        promise.rejects(transfer);
                    }
                    
                }
            }
        })
        self.dataTask?.resume();
        return promise;
    }
    func load(url:NSURL) -> PromisesNet {
        let req = NSMutableURLRequest(URL: url)
        return self.loadRequest(req);
    }
    
}