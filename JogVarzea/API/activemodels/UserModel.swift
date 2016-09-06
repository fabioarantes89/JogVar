import UIKit

class UserModel:NSObject {
    var serverH:ServerHelper = ServerHelper();
    
    func loadContent(){
        let promise:Promises = self.serverH.load(NSURL(string: "http://www.estrelando.com.br/")!);
        promise.then({
            data in
            
            NSLog("%d", data)
        })
    }
}
