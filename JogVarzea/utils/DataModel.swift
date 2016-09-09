import UIKit

class DataTransporter:NSObject {
    var data:Array<AnyObject> = Array<AnyObject>();
    var params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>();
    
}
class SimpleDAOBody {
    var data:NSData!
    var header:String!
    var Boundary:String = "lkjasldkjaosihda98syd9ahsd98ahs"
}
protocol SimpleDAO:NSObjectProtocol {
    func submitValues() -> SimpleDAOBody
}

class DataModel:NSObject {
    var indexUrl:String!
    var showUrl:String!
    var updateUrl:String!
    var deleteUrl:String!
    var createUrl:String!
    
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
    func _show(data:NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        return a
    }
    
    var serverH:ServerHelper = ServerHelper();
    
    func index(params:Dictionary<String, String>?) -> Promises {
        let promise:Promises = Promises();
        
        let indexUrl = self.indexUrl;
        let p = self.getRequest(indexUrl, params: params)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._index(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }

        
        return promise;
    }
    func show(params:Dictionary<String, String>?) -> Promises {
        let promise:Promises = Promises();
        
        let showUrl = self.showUrl;
        let p = self.getRequest(showUrl, params: params)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._show(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        
        return promise;
    }
    func update(object:SimpleDAO, params:Dictionary<String, String>?) -> Promises {
        let promise:Promises = Promises();
        
        let showUrl = self.updateUrl;
        //let p = self.getRequest(showUrl, params: params)
        let p = self.putRequest(showUrl, params: params, data:object)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._show(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        
        return promise;
    }
    func create(object:SimpleDAO, params:Dictionary<String, String>?) -> Promises {
        let promise:Promises = Promises();
        
        let createUrl = self.createUrl;
        let p = self.postRequest(createUrl, params: params, data:object)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._show(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }

        return promise;
    }
    
    func formatUrl(url:String, params:Dictionary<String, String>) -> String {
        var finalUrl = url;
        for (key, value) in params {
            let value = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
            finalUrl = finalUrl.stringByReplacingOccurrencesOfString(String(stringInterpolation: "%", key, "%"), withString: value)
        }
        
        return finalUrl;
    }
    
    func postRequest(url:String, params:Dictionary<String, String>?, data:SimpleDAO?) -> PromisesNet {
        var paramsStr = "?";
        
        var urlFin = url
        
        if let params = params {
            urlFin = self.formatUrl(url, params:params);
            
            for (key, value) in params {
                if(!url.localizedCaseInsensitiveContainsString(key)){
                    let key = key.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    let value = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    
                    paramsStr = String(stringInterpolation: paramsStr, key, "=", value, "&")
                }
            }
        }
        
        let url:NSURL = NSURL(string: String(stringInterpolation: urlFin, paramsStr))!
        
        
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "POST"
        
        if let data = data {
            let dao = data.submitValues()
            let dataPackage:NSData = dao.data
            
            req.HTTPBody = dataPackage
            req.setValue(String(dataPackage.length), forHTTPHeaderField: "Content-Length")
            req.setValue(dao.header, forHTTPHeaderField: "Content-Type")
        }
        
        let p = self.serverH.loadRequest(req)
        
        return p;
    }
    
    func putRequest(url:String, params:Dictionary<String, String>?, data:SimpleDAO?) -> PromisesNet {
        var paramsStr = "?";
        
        var urlFin = url
        
        if let params = params {
            urlFin = self.formatUrl(url, params:params);
            
            for (key, value) in params {
                if(!url.localizedCaseInsensitiveContainsString(key)){
                    let key = key.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    let value = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    
                    paramsStr = String(stringInterpolation: paramsStr, key, "=", value, "&")
                }
            }
        }
        
        let url:NSURL = NSURL(string: String(stringInterpolation: urlFin, paramsStr))!
        
        
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "PUT"
        
        if let data = data {
            let dao = data.submitValues()
            let dataPackage:NSData = dao.data
            //let boundary = dao.Boundary
            
            req.HTTPBody = dataPackage
            req.setValue(String(dataPackage.length), forHTTPHeaderField: "Content-Length")
            req.setValue(dao.header, forHTTPHeaderField: "Content-Type")
            
        }
        
        let p = self.serverH.loadRequest(req)
        
        return p;
    }
    func getRequest(url:String, params:Dictionary<String, String>?) -> PromisesNet {
        
        
        var urlFin = url
        
        var paramsStr = "?";
        
        if let params = params {
            urlFin = self.formatUrl(url, params:params);
            
            for (key, value) in params {
                if(!url.localizedCaseInsensitiveContainsString(key)){
                    let key = key.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    let value = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    
                    paramsStr = String(stringInterpolation: paramsStr, key, "=", value, "&")
                }
            }
        }
        
        let url:NSURL = NSURL(string: String(stringInterpolation: urlFin, paramsStr))!
        
        
        let req = NSMutableURLRequest(URL: url)
        let p = self.serverH.loadRequest(req)
        
        return p;
    }
    func deleteRequest(url:String, params:Dictionary<String, String>?) -> PromisesNet {
        
        
        var urlFin = url
        
        var paramsStr = "?";
        
        if let params = params {
            urlFin = self.formatUrl(url, params:params);
            
            for (key, value) in params {
                if(!url.localizedCaseInsensitiveContainsString(key)){
                    let key = key.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    let value = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
                    
                    paramsStr = String(stringInterpolation: paramsStr, key, "=", value, "&")
                }
            }
        }
        
        let url:NSURL = NSURL(string: String(stringInterpolation: urlFin, paramsStr))!
        
        
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "DELETE";
        let p = self.serverH.loadRequest(req)
        
        return p;
    }
    
}