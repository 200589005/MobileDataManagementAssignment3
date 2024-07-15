//
//  MovieSearch.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 15/07/24.
//

import Foundation

class MovieSearch: NSObject {
    var title: String = ""
    var year: String = ""
    var rated: String = ""
    var released: String = ""
    var runtime: String = ""
    var genre: String = ""
    var director: String = ""
    var writer: String = ""
    var actors: String = ""
    var plot: String = ""
    var language: String = ""
    var country: String = ""
    var awards: String = ""
    var poster: String = ""
    var ratings: [MovieSearchRating] = []
    var metascore: String = ""
    var imdbRating: String = ""
    var imdbVotes: String = ""
    var imdbID: String = ""
    var type: String = ""
    var dvd: String = ""
    var boxOffice: String = ""
    var production: String = ""
    var website: String = ""
    var response: String = ""

    // MARK: - Initialization
    override init() {
        super.init()
    }

    init(dictData: [String: Any]) {
        title = setDataInString(dictData["Title"] as AnyObject)
        year = setDataInString(dictData["Year"] as AnyObject)
        rated = setDataInString(dictData["Rated"] as AnyObject)
        released = setDataInString(dictData["Released"] as AnyObject)
        runtime = setDataInString(dictData["Runtime"] as AnyObject)
        genre = setDataInString(dictData["Genre"] as AnyObject)
        director = setDataInString(dictData["Director"] as AnyObject)
        writer = setDataInString(dictData["Writer"] as AnyObject)
        actors = setDataInString(dictData["Actors"] as AnyObject)
        plot = setDataInString(dictData["Plot"] as AnyObject)
        language = setDataInString(dictData["Language"] as AnyObject)
        country = setDataInString(dictData["Country"] as AnyObject)
        awards = setDataInString(dictData["Awards"] as AnyObject)
        poster = setDataInString(dictData["Poster"] as AnyObject)
        
        if let ratingsArray = dictData["Ratings"] as? [[String: Any]] {
            for ratingDict in ratingsArray {
                let rating = MovieSearchRating(dictData: ratingDict)
                ratings.append(rating)
            }
        }
        
        metascore = setDataInString(dictData["Metascore"] as AnyObject)
        imdbRating = setDataInString(dictData["imdbRating"] as AnyObject)
        imdbVotes = setDataInString(dictData["imdbVotes"] as AnyObject)
        imdbID = setDataInString(dictData["imdbID"] as AnyObject)
        type = setDataInString(dictData["Type"] as AnyObject)
        dvd = setDataInString(dictData["DVD"] as AnyObject)
        boxOffice = setDataInString(dictData["BoxOffice"] as AnyObject)
        production = setDataInString(dictData["Production"] as AnyObject)
        website = setDataInString(dictData["Website"] as AnyObject)
        response = setDataInString(dictData["Response"] as AnyObject)
    }
}
