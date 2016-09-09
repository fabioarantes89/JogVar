import UIKit
class Oauth:NSObject, SimpleDAO  {
    var appSecret:String = APP_SECRET
    var email:String!
    var pass:String!
    var token:String?
    var userId:String?
    var validUntil:String?
    
    init(email:String, pass:String){
        self.email = email;
        self.pass = pass;
        
    }
    init(token:String, userId:String, validUntil:String){
        self.token = token
        self.userId = userId
        self.validUntil = validUntil
        
        
        NSUserDefaults.standardUserDefaults().setValue(self.token, forKey: APIUTILS.AuthTokenNSUserDefaults.rawValue)
        NSUserDefaults.standardUserDefaults().setValue(self.userId, forKey: APIUTILS.AuthUserIDNSUserDefaults.rawValue)
        NSUserDefaults.standardUserDefaults().setValue(self.validUntil, forKey: APIUTILS.AuthValidUntilNSUserDefaults.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func isLogged() -> Bool {
        var ret:Bool = false
        
        
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(APIUTILS.AuthTokenNSUserDefaults.rawValue) as? String {
            ret = true
        }

        return ret
    }
    class func returnCredentials() -> Oauth? {
        if self.isLogged() {
            let token = NSUserDefaults.standardUserDefaults().objectForKey(APIUTILS.AuthTokenNSUserDefaults.rawValue) as? String
            let userId = NSUserDefaults.standardUserDefaults().objectForKey(APIUTILS.AuthUserIDNSUserDefaults.rawValue) as? String
            let validUntil = NSUserDefaults.standardUserDefaults().objectForKey(APIUTILS.AuthValidUntilNSUserDefaults.rawValue) as? String
            
            let oauth:Oauth = Oauth(token:token!, userId:userId!, validUntil:validUntil!)
            return oauth
        }
        return nil
    }
    
    func submitValues() -> SimpleDAOBody {
        let transporter = SimpleDAOBody();
        transporter.header = "application/x-www-form-urlencoded"
        let body  = NSMutableData();
        
        body.appendData("appSecret=\(self.appSecret)".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("&email=\(self.email)".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("&pass=\(self.pass)".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        transporter.data = body
        
        return transporter
    }
}


