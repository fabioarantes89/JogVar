import UIKit
class Match: NSObject, SimpleDAO  {
    var _id:String?
    var name:String?
    var match_in:NSDate?
    var team_home:Team?
    var team_visitor:Team?
    var place:String?
    var score_visitor:Int?
    var score_home:Int?
    
    init(name:String, team_home:Team, team_visitor:Team, match_in:NSDate, place:String){
        self.name = name
        self.match_in = match_in
        self.team_home = team_home
        self.team_visitor = team_visitor
        self.score_home = 0
        self.score_visitor = 0
        self.place = place
    }
    
    init(dictionary:NSDictionary){
        if let _id = dictionary.objectForKey("_id") as? String {
            self._id = _id;
        }
        if let name = dictionary.objectForKey("name") as? String {
            self.name = name;
        }
        if let match_in = dictionary.objectForKey("match_in") as? String {
            let formatter = NSDateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
            
            let d = formatter.dateFromString(match_in)
            self.match_in = d
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
        if let match_in = self.match_in {
            let formatter = NSDateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
            
            let d = formatter.stringFromDate(match_in)
            
            body.appendData("match_in=\(d)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let place = self.place {
            body.appendData("place=\(place)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        transporter.data = body
        
        return transporter
    }
}


