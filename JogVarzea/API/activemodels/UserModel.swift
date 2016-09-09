import UIKit

class UserModel:DataModel {
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%");
        self.updateUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%");
        self.deleteUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%")
    }
    
    
}

