import UIKit
enum MatchStatus: String {
    case ACCEPTED = "accepted", APPROVING = "approving", REFUSED = "refused"
}
class Match: NSObject, SimpleDAO  {
    var _id:String?
    var name:String?
    var match_in:NSDate?
    var team_home:Team?
    var team_visitor:Team?
    var place:String?
    var score_visitor:Int?
    var score_home:Int?
    var accepts_home:MatchStatus?
    var accepts_visitor:MatchStatus?
    
    init(id:String) {
        self._id = id
    }
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
        
        if let team_home = dictionary.objectForKey("team_home") as? NSDictionary {
            self.team_home = Team(dictionary: team_home)
        }
        if let team_visitor = dictionary.objectForKey("team_visitor") as? NSDictionary {
            self.team_visitor = Team(dictionary: team_visitor)
        }
        if let accepts_home = dictionary.objectForKey("accepts_home") as? String {
            switch(accepts_home){
                case MatchStatus.ACCEPTED.rawValue:
                    self.accepts_home = MatchStatus.ACCEPTED
                break
                case MatchStatus.REFUSED.rawValue:
                    self.accepts_home = MatchStatus.REFUSED
                break
                case MatchStatus.APPROVING.rawValue:
                    self.accepts_home = MatchStatus.APPROVING
                break
                default:
                break
            }
        }
        if let accepts_visitor = dictionary.objectForKey("accepts_visitor") as? String {
            switch(accepts_visitor){
            case MatchStatus.ACCEPTED.rawValue:
                self.accepts_visitor = MatchStatus.ACCEPTED
                break
            case MatchStatus.REFUSED.rawValue:
                self.accepts_visitor = MatchStatus.REFUSED
                break
            case MatchStatus.APPROVING.rawValue:
                self.accepts_visitor = MatchStatus.APPROVING
                break
                
            default:
                break
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
        if let team_home = self.team_home {
            body.appendData("team_home=\(team_home.id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let team_visitor = self.team_visitor {
            body.appendData("team_visitor=\(team_visitor.id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let score_home = self.score_home {
            body.appendData("score_home=\(score_home)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let score_visitor = self.score_visitor {
            body.appendData("score_visitor=\(score_visitor)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let accepts_home = self.accepts_home {
            body.appendData("accepts_home=\(accepts_home.rawValue)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let accepts_visitor = self.accepts_visitor {
            body.appendData("accepts_visitor=\(accepts_visitor.rawValue)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        transporter.data = body
        
        return transporter
    }
}


