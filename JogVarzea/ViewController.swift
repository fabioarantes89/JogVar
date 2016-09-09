

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
         MARK: Normal Req
        var dict:Dictionary<String, String> = Dictionary<String, String>()
        //dict["page"] = "2"
        dict["TEAM_ID"] = "57531124f968916d6100f929"
        
        
        let test:TeamsModel = TeamsModel()
        let promise:Promises = test.show(dict)
        promise.then { (data:AnyObject) in
            
            let transfer:DataTransporter = data as! DataTransporter;
            
            //for var i in 0...(transfer.data.count-1) {
            // let team = transfer.data[i]
            //}
            
        }
        promise.recover { (transfer:AnyObject) in
            let transfer = transfer as? ServerHelperDataTransfer;
            let error = transfer?.error
            
            print(error?.code);
            
        }
        */
        
        /*
         
         MARK: Login Example
         
        // NSUserDefaults.standardUserDefaults().removeObjectForKey(APIUTILS.AuthTokenNSUserDefaults.rawValue)
        //NSUserDefaults.standardUserDefaults().synchronize()
        
        if(Oauth.isLogged()){
            let credentials:Oauth! = Oauth.returnCredentials()
            print(credentials)
        } else {
            // MARK: USER Login
            let user:Oauth = Oauth(email: "fabio.arantes@icloud.com", pass:"f-117s");
            
            let test:LoginModel = LoginModel()
            let promise = test.login(user)
            promise.then { (data:AnyObject) in
                
                let transfer:DataTransporter = data as! DataTransporter;
                
                //for var i in 0...(transfer.data.count-1) {
                // let team = transfer.data[i]
                //}
                
            }
            promise.recover { (transfer:AnyObject) in
                let transfer = transfer as? ServerHelperDataTransfer;
                let error = transfer?.error
                
                print(error?.code);
                
            }

        }
        */
        
        /*
         MARK: SHOW USER
        var dict:Dictionary<String, String> = Dictionary<String, String>()
        //dict["page"] = "2"
        //dict["TEAM_ID"] = "57531124f968916d6100f929"
        
        
        let test:UserModel = UserModel()
        let promise:Promises = test.index(dict)
        promise.then { (data:AnyObject) in
            
            let transfer:DataTransporter = data as! DataTransporter;
            
            //for var i in 0...(transfer.data.count-1) {
            // let team = transfer.data[i]
            //}
            
        }
        promise.recover { (transfer:AnyObject) in
            let transfer = transfer as? ServerHelperDataTransfer;
            let error = transfer?.error
            let dados = String(data: transfer!.data, encoding: NSUTF8StringEncoding)
            print(error?.code);
            print(dados);
            
        }

        */
        /*
         MARK: User SHOW
        var dict:Dictionary<String, String> = Dictionary<String, String>()
        //dict["page"] = "2"
        dict["USER_ID"] = "5737c40d0308d815533fd625"
        
        
        let test:UserModel = UserModel()
        let promise:Promises = test.show(dict)
        promise.then { (data:AnyObject) in
            
            let transfer:DataTransporter = data as! DataTransporter;
            
            //for var i in 0...(transfer.data.count-1) {
            // let team = transfer.data[i]
            //}
            
        }
        promise.recover { (transfer:AnyObject) in
            let transfer = transfer as? ServerHelperDataTransfer;
            let error = transfer?.error
            let dados = String(data: transfer!.data, encoding: NSUTF8StringEncoding)
            print(error?.code);
            print(dados);
            
        }
        */
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

