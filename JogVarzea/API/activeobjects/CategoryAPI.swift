import UIKit
class CategoryAPI: NSObject, SimpleDAO  {
    var _id:String?
    var name:String?
    var file_id:String?
    
    init(id:String){
        self._id = id;
    }
    init(name:String){
        self.name = name;
    }
    init(name:String, file_id:String){
        self.name = name;
        self.file_id = file_id;
    }
    
    init(dictionary:NSDictionary){
        if let _id = dictionary.objectForKey("_id") as? String {
            self._id = _id;
        }
        if let name = dictionary.objectForKey("name") as? String {
            self.name = name;
        }
            }
    func submitValues() -> SimpleDAOBody {
        let transporter = SimpleDAOBody();
                transporter.header = "application/x-www-form-urlencoded"
        
        
        let body  = NSMutableData();
        
        if let id = self._id {
            body.appendData("id=\(id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let name = self.name {
            body.appendData("name=\(name)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let file_id = self.file_id {
            body.appendData("file_id=\(file_id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }

        transporter.data = body
        
        return transporter
    }
}


