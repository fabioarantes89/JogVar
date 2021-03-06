//
//  User.swift
//  JogVarzea
//
//  Created by Web1 on 31/08/16.
//  Copyright © 2016 torquatoStudios. All rights reserved.
//

import UIKit

class FileDAO: NSObject, SimpleDAO  {
    var _id:String?
    var filename:String?
    var type:String?
    var created_at:String?
    var path:String?
    var image:UIImage?
    
    init(image:UIImage){
        self.image = image;
    }
    
    init(dictionary:NSDictionary){
        if let _id = dictionary.objectForKey("_id") as? String {
            self._id = _id;
        }
        if let filename = dictionary.objectForKey("filename") as? String {
            self.filename = filename;
        }
        if let type = dictionary.objectForKey("type") as? String {
            self.type = type;
        }
        if let created_at = dictionary.objectForKey("created_at") as? String {
            self.created_at = created_at;
        }
        if let path = dictionary.objectForKey("path") as? String {
            self.path = path;
        }
        
    }
    func submitValues() -> SimpleDAOBody {
        let transporter = SimpleDAOBody();
        /* FormData Example */
        
         transporter.header = "multipart/form-data; boundary=\(transporter.Boundary)"
         let body  = NSMutableData();
         
        
         if let image = self.image {
            
            let imageData:NSData = UIImagePNGRepresentation(image)!
            //print(imageData)
            body.appendData("--\(transporter.Boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!);
            //body.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"image.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            
            let date:NSDate = NSDate();
            let dateFormatter:NSDateFormatter = NSDateFormatter();
            dateFormatter.dateFormat = "ddMMyyyy-HH:mm:ss";
            let strDate = dateFormatter.stringFromDate(date)
            
            body.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"image-\(strDate).png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            
            
            body.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(imageData)
            body.appendData("\r\n--\(transporter.Boundary)--".dataUsingEncoding(NSUTF8StringEncoding)!)
            
            
         }
        
        let debug = String(data: body, encoding: NSUTF8StringEncoding)
        print(debug);
        
            
            
         transporter.data = body
        return transporter
    }
}


