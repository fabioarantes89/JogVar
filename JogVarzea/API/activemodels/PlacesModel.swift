import UIKit

class PlacesModel:DataModel {
    override func _show(data:NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let dados = dados {
                a.data.append(Place(dictionary: dados))
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
                    
                    a.data.append(Place(dictionary: item))
                    
                }
                
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        
        
        
        return a
    }
    
    
    
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "places");
        self.createUrl = String(stringInterpolation: ApiBaseURL, "places");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "places/%PLACE_ID%");
        self.updateUrl = String(stringInterpolation: ApiBaseURL, "places/%PLACE_ID%");
        self.deleteUrl = String(stringInterpolation: ApiBaseURL, "places/%PLACE_ID%")
    }
    
    
}

