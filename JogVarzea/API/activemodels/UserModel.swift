import UIKit

class UserModel:DataModel {
    var loginUrl:String!
    override init(){
        super.init()
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
        self.indexUrl = String(stringInterpolation: ApiBaseURL, "users");
        self.showUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%");
        self.updateUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%");
        self.deleteUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%")
        self.loginUrl = String(stringInterpolation: ApiBaseURL, "users/%USER_ID%")
    }
    func login(user:){
        let promise:Promises = Promises();
        
        let showUrl = self.showUrl;
        let p = self.postRequest(showUrl, params: params)
        p.then { (data:ServerHelperDataTransfer) in
            promise.resolv(self._show(data.data));
        }
        p.recover { (data:ServerHelperDataTransfer) in
            promise.rejects(data)
        }
        
        return promise;

    }
    
}

