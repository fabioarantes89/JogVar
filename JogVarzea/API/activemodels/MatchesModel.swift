import UIKit

class MatchesModel:DataModel {
    var teamsMatchUrl:String!
    
    override func _show(data:NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let dados = dados {
                a.data.append(Match(dictionary: dados))
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        
        
        return a
    }
    override func _index(data: NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let arrData = dados?.valueForKey("data") as? NSArray {
                
                for var i in 0...(arrData.count-1) {
                    let item:NSDictionary = arrData[i] as! NSDictionary;
                    
                    a.data.append(Match(dictionary: item))
                    
                }
                
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        
        
        
        return a
    }
    func teamsMatches(teamID:String, params:Dictionary<String, String>?) -> Promises {
        let promise:Promises = Promises();
        
        var insideDictionary:Dictionary<String, String> = Dictionary<String, String>();
        if let params = params {
            for (key, value) in params {
                insideDictionary.updateValue(value, forKey: key)
            }
        }
        
        insideDictionary.updateValue(teamID, forKey: "TEAM_ID")
        
        
        let indexUrl = self.indexUrl;
        let p = self.getRequest(indexUrl, params: insideDictionary)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._index(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        
        
        return promise;
    }
    
    
    
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "matches");
        self.createUrl = String(stringInterpolation: ApiBaseURL, "matches");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "matches/%MATCH_ID%");
        self.teamsMatchUrl = String(stringInterpolation: ApiBaseURL, "teams/%TEAM_ID%/matches");
        self.updateUrl = String(stringInterpolation: ApiBaseURL, "matches/%MATCH_ID%");
        self.deleteUrl = String(stringInterpolation: ApiBaseURL, "matches/%MATCH_ID%")
    }
    
    
}

