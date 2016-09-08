//
//  User.swift
//  JogVarzea
//
//  Created by Web1 on 31/08/16.
//  Copyright © 2016 torquatoStudios. All rights reserved.
//

import UIKit

class User: NSObject {
    var _id:String?
    var name:String?
    var email:String?
    var rg:String?
    var cpf:String?
    var telephone:String?
    
    init(id:String){
        self._id = id;
    }
    
    init(dictionary:NSDictionary){
        
    }
}


