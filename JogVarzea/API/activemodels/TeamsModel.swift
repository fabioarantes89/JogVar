import UIKit

class TeamsModel: DataModel {
    
    override func _index(data:NSData) -> DataTransporter {
        let a:DataTransporter = super._index(data);
        
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let arrData = dados?.valueForKey("data") as? NSArray {
                
                for var i in 0...(arrData.count-1) {
                    let item:NSDictionary = arrData[i] as! NSDictionary;
                    
                    a.data.append(Team(dictionary: item))
                    
                }
                
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        

        
        return a
    }
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "teams");
    }
}
