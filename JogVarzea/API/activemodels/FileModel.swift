import UIKit

class FileModel:DataModel {
    override func _show(data:NSData) -> DataTransporter {
        let a:DataTransporter = DataTransporter ();
        
        do {
            let dados = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            self._defaultListParams(a, dados:dados)
            
            if let dados = dados {
                a.data.append(FileDAO(dictionary: dados))
            }
            
            
        } catch let error as NSError  {
            print(error)
        }
        
        
        return a
    }
    override init(){
        super.init()
        self.createUrl = String(stringInterpolation: ApiBaseURL, "files");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "files/%FILE_ID%");
    }
    
}

