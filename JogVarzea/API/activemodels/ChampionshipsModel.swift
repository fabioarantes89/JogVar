import UIKit

class ChampionshipsModel:DataModel {
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
    
    
    
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "championships");
        self.createUrl = String(stringInterpolation: ApiBaseURL, "championships");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "championships/%CHAMPIONSHIP_ID%");
        self.updateUrl = String(stringInterpolation: ApiBaseURL, "championships/%CHAMPIONSHIP_ID%");
        self.deleteUrl = String(stringInterpolation: ApiBaseURL, "championships/%CHAMPIONSHIP_ID%")
    }
    
    
}

