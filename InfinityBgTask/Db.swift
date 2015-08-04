//
//  DB.swift
//  Found
//
//  Created by Emerson Carvalho on 8/3/15.
//  Copyright (c) 2015 Your School. All rights reserved.
//

import Foundation

let DB_MESSAGE = "DB_MESSAGE";
class DB {
    
    
    class func addMessage(_message : String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let messages: AnyObject? = defaults.objectForKey(DB_MESSAGE)
        
        var datetime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .MediumStyle)
        
        var message:String = "\(datetime): \(_message)"
        
        var messagesArray: [String] = []
        
        if  messages != nil {
            messagesArray = messages as! [String]
        }
        
        println(message)
        
        messagesArray.append(message)
        defaults.setObject(messagesArray, forKey: DB_MESSAGE)
        defaults.synchronize()
    }
    
    class func getMessages() -> [String] {
        let defaults = NSUserDefaults.standardUserDefaults()
        let messages: AnyObject? = defaults.objectForKey(DB_MESSAGE)
        
        var messagesArray: [String] = []
        
        if  messages != nil {
            messagesArray = messages as! [String]
        }
        
        return messagesArray
    }
    
    class func clear() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(DB_MESSAGE)
    }
}

