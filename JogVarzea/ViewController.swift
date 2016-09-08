

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let test:TeamsModel = TeamsModel()
        let promise:Promises = test.index(nil)
        promise.then { (data:AnyObject) in
            
            let transfer:DataTransporter = data as! DataTransporter;
            
            print(transfer.data)
            
            
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

