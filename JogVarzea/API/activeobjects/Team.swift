//
//  Team.swift
//  JogVarzea
//
//  Created by Web1 on 31/08/16.
//  Copyright © 2016 torquatoStudios. All rights reserved.
//

import UIKit

class Team: NSObject {
    var id:String?
    var name:String?
    var desc:String?
    var uniform:String?
    var region:String?
    var city:String?
    var uf:String?
    var owner:User?
    var players:Array<User>?
    
    init(dictionary:NSDictionary){
        
        if let id = dictionary.objectForKey("_id") as? String{
            self.id = id
        }
        if let name = dictionary.objectForKey("name") as? String{
            self.name = name
        }
        if let desc = dictionary.objectForKey("description") as? String{
            self.desc = desc
        }
        if let uniform = dictionary.objectForKey("uniform") as? String{
            self.uniform = uniform
        }
        if let region = dictionary.objectForKey("region") as? String{
            self.region = region
        }
        if let city = dictionary.objectForKey("city") as? String{
            self.city = city
        }
        if let uf = dictionary.objectForKey("uf") as? String{
            self.uf = uf
        }
        
    }
}
