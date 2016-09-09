

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

