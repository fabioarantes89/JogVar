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
    var pass:String?
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
        /* FormData Example */
        /*
        transporter.header = "Content-Type: multipart/form-data; boundary=--\(transporter.Boundary)"
        let body  = NSMutableString();
        
        if let id = self._id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"id\"")
            body.appendString("\r\n\r\n\(id)")
        }
        if let name = self.name {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"name\"")
            body.appendString("\r\n\r\n\(name)")
        }
        if let salt = self.salt {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"salt\"")
            body.appendString("\r\n\r\n\(salt)")
        }
        if let pass = self.pass {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"pass\"")
            body.appendString("\r\n\r\n\(pass)")
        }
        if let email = self.email {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"email\"")
            body.appendString("\r\n\r\n\(email)")
        }
        if let rg = self.rg {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"rg\"")
            body.appendString("\r\n\r\n\(rg)")
        }
        if let cpf = self.cpf {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"cpf\"")
            body.appendString("\r\n\r\n\(cpf)")
        }
        if let telephone = self.telephone {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"telephone\"")
            body.appendString("\r\n\r\n\(telephone)")
        }
        if let file_id = self.file_id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"file_id\"")
            body.appendString("\r\n\r\n\(file_id)")
        }
        if let device_id = self.device_id {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"device_id\"")
            body.appendString("\r\n\r\n\(device_id)")
        }
        if let device_type = self.device_type {
            body.appendString("--\(transporter.Boundary)\r\n");
            body.appendString("Content-Disposition:form-data; name=\"device_type\"")
            body.appendString("\r\n\r\n\(device_type)")
        }
        

        transporter.data = body.dataUsingEncoding(NSUTF8StringEncoding)
        */
        transporter.header = "application/x-www-form-urlencoded"
        
        
        let body  = NSMutableData();
        
        if let id = self._id {
            body.appendData("id=\(id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let name = self.name {
            body.appendData("name=\(name)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let salt = self.salt {
            body.appendData("salt=\(salt)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let pass = self.pass {
            body.appendData("pass=\(pass)&".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        if let email = self.email {
            body.appendData("email=\(email)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let rg = self.rg {
            body.appendData("rg=\(rg)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let cpf = self.cpf {
            body.appendData("cpf=\(cpf)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let telephone = self.telephone {
            body.appendData("telephone=\(telephone)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let file_id = self.file_id {
            body.appendData("file_id=\(file_id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let device_id = self.device_id {
            body.appendData("device_id=\(device_id)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        if let device_type = self.device_type {
            body.appendData("device_type=\(device_type)&".dataUsingEncoding(NSUTF8StringEncoding)!)
            
        }
        
        
        transporter.data = body
        
        return transporter
    }
}


