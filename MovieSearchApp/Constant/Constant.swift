//
//  Constant.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 15/07/24.
//

import Foundation

class Constant: NSObject {
    
    public static var API_KEY = "29ee283a"
    
}

func setDataInString(_ text : AnyObject) -> String {
    var str = ""
    if text is String {
        str = text as! String
    }else if text is Int {
        str = String(text as! Int)
    }else if text is Float {
        str = String(text as! Float)
    }else if text is Double {
        str = String(text as! Double)
    }else if text is NSNumber {
        str = String(describing: text as! NSNumber)
    }
    
    return str
}
