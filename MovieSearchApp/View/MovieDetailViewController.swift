//
//  MovieDetailViewController.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 17/07/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: MovieSearch?
    
    @IBOutlet weak var lblTitile: UILabel!
    @IBOutlet weak var lblActors: UILabel!
    @IBOutlet weak var lblDirectors: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblRunTime: UILabel!
    @IBOutlet weak var lblRatedR: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    @IBOutlet weak var lblRatting1: UILabel!
    @IBOutlet weak var lblRatingAnswer: UILabel!
    @IBOutlet weak var lblRatting2: UILabel!
    @IBOutlet weak var lblRattingAnswer2: UILabel!
    @IBOutlet weak var lblRatting3: UILabel!
    @IBOutlet weak var lblRattingAnswer3: UILabel!
    @IBOutlet weak var lblIMDBRating: UILabel!
    @IBOutlet weak var lblIMDBVotes: UILabel!
    @IBOutlet weak var lblMetascore: UILabel!
    @IBOutlet weak var lblBoxOffice: UILabel!
    @IBOutlet weak var lblAwards: UILabel!
    @IBOutlet weak var lblReleasedate: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var lblProduction: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblDVD: UILabel!
    @IBOutlet weak var lblIMDBID: UILabel!
    
    @IBOutlet weak var imgPoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigation()
        self.setupUI()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Movie Details"
        self.navigationItem.backButtonTitle = "Back"
        self.setupDefaultNavigation()
    }
    
    func setupUI() {
        guard let movie = movie else { return }
        lblTitile.text = movie.title
        lblActors.text = movie.actors
        lblDirectors.text = movie.director
        lblWriter.text = movie.writer
        lblGenre.text = movie.genre
        lblRunTime.text = movie.runtime
        lblRatedR.text = movie.rated
        lblYear.text = movie.year
        lblPlot.text = movie.plot
        for (index,item) in movie.ratings.enumerated() {
            if index == 0 {
                lblRatting1.text = item.source
                lblRatingAnswer.text = item.value
            } else if index == 1 {
                lblRatting2.text = item.source
                lblRattingAnswer2.text = item.value
            } else if index == 2 {
                lblRatting3.text = item.source
                lblRattingAnswer3.text = item.value
            }
        }
        lblIMDBRating.text = movie.imdbRating
        lblIMDBVotes.text = movie.imdbVotes
        lblMetascore.text = movie.metascore
        lblBoxOffice.text = movie.boxOffice
        lblAwards.text = movie.awards
        lblReleasedate.text = movie.released
        lblCountry.text = movie.country
        lblEnglish.text = movie.language
        lblMovie.text = movie.type
        lblProduction.text = movie.production
        lblWebsite.text = movie.website
        lblDVD.text = movie.dvd
        lblIMDBID.text = movie.imdbID
        imgPoster.sd_setImageCustom(url: movie.poster,placeHolderImage: UIImage(named: "no-photo"))
    }
    
}