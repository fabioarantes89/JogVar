//
//  User.swift
//  JogVarzea
//
//  Created by Web1 on 31/08/16.
//  Copyright © 2016 torquatoStudios. All rights reserved.
//

import UIKit

class User: NSObject, SimpleDAO  {
    var _id:String?
    var name:String?
    var salt:String?
    var email:String?
    var rg:String?
    var cpf:String?
    var telephone:String?
    var plays_at:String?
    var file_id:String?
    var device_id:String?
    var device_type:String?
    
    init(id:String){
        self._id = id;
    }
    
    init(dictionary:NSDictionary){
        
    }
    func submitValues() -> SimpleDAOBody {
        let transporter = SimpleDAOBody();
        
        let body  = NSMutableString();
        
        if let id = self._id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(id)")
        }
        if let name = self.name {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(name)")
        }
        if let salt = self.salt {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(salt)")
        }
        if let email = self.email {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(email)")
        }
        if let rg = self.rg {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(rg)")
        }
        if let cpf = self.cpf {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(cpf)")
        }
        if let telephone = self.telephone {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(telephone)")
        }
        if let file_id = self.file_id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(file_id)")
        }
        if let device_id = self.device_id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(device_id)")
        }
        if let device_type = self.device_type {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("\r\n\r\n\(device_type)")
        }
        

        transporter.data = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        return transporter
    }
}


