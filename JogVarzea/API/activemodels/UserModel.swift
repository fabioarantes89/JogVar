import UIKit

class UserModel:DataModel {
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
    }
}

