//
//  MovieSearchViewController.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 15/07/24.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    var arrMovies: [MovieSearch] = []
    
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var searchMovie: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMovie.delegate = self
        self.registerTableViewCells()
    }
    
    func registerTableViewCells() {
        tblMovies.register(UINib.init(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        tblMovies.rowHeight = UITableView.automaticDimension
        tblMovies.estimatedRowHeight = 30;
        tblMovies.tableFooterView = UIView()
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.reloadData()
        self.setupDefaultNavigation()
        
    }
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text ?? "").count >= 3 {
            
//            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
//            perform(#selector(performSearch), with: searchText, afterDelay: 1)
            self.performSearch(searchText: searchBar.text ?? "")
            self.searchMovie.resignFirstResponder()
        } else {
            self.arrMovies = []
            self.tblMovies.reloadData()
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
            DispatchQueue.main.async {
                let modal = MovieSearch(dictData: response)
                self.arrMovies = [modal]
                self.tblMovies.reloadData()
            }
        }
    }
    
}

extension MovieSearchViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell {
            cell.indexPath = indexPath
            cell.cellConfig(modal: arrMovies[indexPath.row])
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC: MovieDetailViewController = MovieDetailViewController.instantiateViewController(identifier: .main)
        movieDetailVC.movie = arrMovies[indexPath.row]
        self.pushVC(movieDetailVC)
    }
    
}
