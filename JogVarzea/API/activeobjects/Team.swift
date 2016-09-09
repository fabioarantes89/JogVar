//
//  Team.swift
//  JogVarzea
//
//  Created by Web1 on 31/08/16.
//  Copyright © 2016 torquatoStudios. All rights reserved.
//

import UIKit

class Team: NSObject, SimpleDAO {
    var id:String?
    var name:String?
    var desc:String?
    var uniform:String?
    var region:String?
    var city:String?
    var uf:String?
    var owner:User?
    var players:Array<User>?
    var type:String?
    
    
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
        if let type = dictionary.objectForKey("type") as? String{
            self.type = type
        }
        
        if let arrPlayers = dictionary.objectForKey("players") as? NSArray {
            self.players = Array<User>();
            if(arrPlayers.count > 0){
                for var i in 0...(arrPlayers.count-1) {
                    let item = arrPlayers[i] as! String;
                    self.players?.append(User(id: item));
                }
            }
            
        }
        if let own = dictionary.objectForKey("owner") as? String {
            self.owner = User(id: own)
        }
    }
    
    func submitValues() -> SimpleDAOBody {
        let transporter = SimpleDAOBody();
        
        let body  = NSMutableString();
        
        if let id = self.id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(id)")
        }
        
        
        if let name = self.name {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(name)")
        }
        if let desc = self.desc {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(desc)")
        }
        if let uniform = self.uniform {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(uniform)")
        }
        if let region = self.region {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(region)")
        }
        if let city = self.city {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(city)")
        }
        if let uf = self.uf {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(uf)")
        }
        if let owner = self.owner {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(owner._id)")
        }
        /*
         MARK: TODO
        if let players = self.players {
            for var i in 0...(players.count-1) {
                var player = players[i] as? User;
                
                body.appendString("--\(transporter.Boundary)\r\n");
                body.appendString("\r\n\r\n\(player.id)")
            }
            
        }
         */
        if let type = self.type {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(type)")
        }
        
        transporter.data = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        return transporter
    }
    
}
