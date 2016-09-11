import UIKit
import CoreLocation
class Place: NSObject, SimpleDAO  {
    var _id:String?
    var name:String?
    var address:String?
    var zipCode:String?
    var loc:CLLocation?
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
    init(name:String, loc:CLLocation){
        self.name = name;
        self.loc = loc;
    }
    
    init(dictionary:NSDictionary){
        if let _id = dictionary.objectForKey("_id") as? String {
            self._id = _id;
        }
        if let name = dictionary.objectForKey("name") as? String {
            self.name = name;
        }
        if let address = dictionary.objectForKey("address") as? String {
            self.address = address;
        }
        if let zipcode = dictionary.objectForKey("zipcode") as? String {
            self.zipCode = zipcode;
        }
        if let file_id = dictionary.objectForKey("file_id") as? String {
            self.file_id = file_id;
        }
        if let loc = dictionary.objectForKey("loc") as? NSArray {
            if(loc.count == 2){
                let lattitude = loc[1] as? Double
                let longitude = loc[0] as? Double
                if lattitude != nil && longitude != nil {
                 let loc = CLLocation(latitude: CLLocationDegrees(floatLiteral: lattitude!), longitude: CLLocationDegrees(floatLiteral: longitude!))
                    
                    self.loc = loc
                }
            }
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
        if let address = self.address {
            body.appendData("address=\(address)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let zipCode = self.zipCode {
            body.appendData("zipcode=\(zipCode)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let loc = self.loc {
            let long = loc.coordinate.longitude
            let lat = loc.coordinate.latitude
            body.appendData("loc=\(long)&loc=\(lat)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let file_id = self.file_id {
            body.appendData("file_id=\(file_id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        
        transporter.data = body
        
        return transporter
    }
}


