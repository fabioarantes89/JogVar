import UIKit
class Championship: NSObject, SimpleDAO  {
    var _id:String?
    var name:String?
    var type:Modality?
    var dateStart:NSDate?
    var dateEnd:NSDate?
    var owner:User?
    var file_id:String?
    var matches:Array<Match> = Array<Match>();
    
    
    init(dictionary:NSDictionary){
        if let _id = dictionary.objectForKey("_id") as? String {
            self._id = _id;
        }
        if let name = dictionary.objectForKey("name") as? String {
            self.name = name;
        }
        let formatter = NSDateFormatter()
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        
        if let date_start = dictionary.objectForKey("date_start") as? String {
            let d = formatter.dateFromString(date_start)
            self.dateStart = d
        }
        if let date_end = dictionary.objectForKey("date_end") as? String {
            let d = formatter.dateFromString(date_end)
            self.dateEnd = d
        }
        if let owner = dictionary.objectForKey("owner") as? NSDictionary {
            self.owner = User(dictionary: owner)
        } else if let owner = dictionary.objectForKey("owner") as? String {
            self.owner = User(id: owner)
        }
        if let file_id = dictionary.objectForKey("file_id") as? String {
            self.file_id = file_id;
        }
        if let matches = dictionary.objectForKey("matches") as? NSArray {
            if matches.count > 0 {
                for var i in 0...(matches.count-1) {
                    if let match = matches[i] as? NSDictionary {
                        self.matches.append(Match(dictionary: match))
                    } else if let match = matches[i] as? String {
                        self.matches.append(Match(id: match))
                    }
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
        transporter.data = body
        
        return transporter
    }
}


