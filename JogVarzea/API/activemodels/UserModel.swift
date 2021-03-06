import UIKit

class UserModel:DataModel {
    var meUrl:String!
    override func _show(data:NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let dados = dados {
                a.data.append(User(dictionary: dados))
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        
        
        return a
    }
    override func _index(data: NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let arrData = dados?.valueForKey("data") as? NSArray {
                
                for var i in 0...(arrData.count-1) {
                    let item:NSDictionary = arrData[i] as! NSDictionary;
                    
                    a.data.append(User(dictionary: item))
                    
                }
                
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        

        
        return a
    }
    
    func me() -> Promises {
        let promise:Promises = Promises();
        
        let loginUrl = self.meUrl;
        let p = self.getRequest(loginUrl, params: nil)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._show(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        
        return promise;
        
    }
    
    
    override init(){
        super.init()
        self.meUrl = String(stringInterpolation: ApiBaseURL, "users/me")
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
        self.createUrl = String(stringInterpolation: ApiBaseURL, "users");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%");
        self.updateUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%");
        self.deleteUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%")
    }
    
    
}

