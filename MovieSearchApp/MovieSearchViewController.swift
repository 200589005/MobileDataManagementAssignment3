//
//  MovieSearchViewController.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 15/07/24.
//

import UIKit

class MovieSearchViewController: UIViewController {
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var searchMovie: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMovie.delegate = self
    }
    
    
    
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {
            
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
            perform(#selector(performSearch), with: searchText, afterDelay: 1)
        }
    }
    
    @objc func performSearch(searchText: String) {
        var dict: [String:String] = [:]
        dict["apikey"] = Constant.API_KEY
        dict["t"] = searchText
        let url = "http://www.omdbapi.com/?\(dict.urlEncodedString())"
        print(url)
        API.shared.unqualifiedRequest(url: url, method: .get, headers: [:], body: nil) { response, error in
            if let error = error {
                print(error)
                return
            }
            guard let response = response else {
                return
            }
            print(response.json)
        }
    }
    
}
