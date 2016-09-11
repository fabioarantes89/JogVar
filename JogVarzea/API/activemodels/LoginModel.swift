import UIKit

class LoginModel:DataModel {
    var loginUrl:String!
    var meUrl:String!
    override init(){
        super.init()
        self.loginUrl = String(stringInterpolation: ApiBaseURL, "oauth/token")
        
    }
    func _login(data:NSData) -> DataTransporter {
        let a:DataTransporter = super._index(data);
        
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            
            a.data = Array<AnyObject>();
            
            if let token = dados?.objectForKey("token") as? String {
                let userId = dados?.objectForKey("user_id") as? String;
                let validUntil = dados?.objectForKey("valid_until") as? String;
                
                let oauth:Oauth = Oauth(token: token, userId: userId!, validUntil: validUntil!)
                a.data.append(oauth)
            } else {
                throw NSError(domain: APIUTILS.errorDomain.rawValue, code: 403, userInfo: nil)
            }
            
        } catch let error as NSError  {
            print(error)
        }
        
        
        return a
    }
    func login(user:SimpleDAO) -> Promises {
        let promise:Promises = Promises();
        
        let loginUrl = self.loginUrl;
        let p = self.postRequest(loginUrl, params: nil, data:user)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._login(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        
        return promise;
        
    }
    
    
}