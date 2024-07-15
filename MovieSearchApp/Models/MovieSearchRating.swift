//
//  MovieSearchRating.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 15/07/24.
//

import Foundation

class MovieSearchRating: NSObject {
    var source: String = ""
    var value: String = ""

    // MARK: - Initialization
    override init() {
        super.init()
    }

    init(dictData: [String: Any]) {
        source = setDataInString(dictData["Source"] as AnyObject)
        value = setDataInString(dictData["Value"] as AnyObject)
    }
}
