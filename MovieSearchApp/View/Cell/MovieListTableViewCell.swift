//
//  MovieListTableViewCell.swift
//  MovieApp
//
//  Created by Mitul Patel on 29/06/24.
//

import UIKit
import CoreData

protocol MovieListTableViewCellProtocol {
    func deleteMoviesAtIndex(indexPath: IndexPath)
    func editMoviesAtIndex(indexPath: IndexPath)
}

class MovieListTableViewCell: UITableViewCell {

    var indexPath: IndexPath?
    var delegate: MovieListTableViewCellProtocol?
    
    @IBOutlet weak var imgMovies: UIImageView!
    @IBOutlet weak var lblMovies: UILabel!
    @IBOutlet weak var lblStudio: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(modal: MovieSearch) {
        lblMovies.text = modal.title
        lblStudio.text = modal.type
        lblStudio.isHidden = false
        lblRating.text = modal.imdbID
        lblYear.text = modal.year
        imgMovies.sd_setImageCustom(url: modal.poster,placeHolderImage: UIImage(named: "no-photo"))
        
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        guard let index = indexPath else { return }
        delegate?.deleteMoviesAtIndex(indexPath: index)
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        guard let index = indexPath else { return }
        delegate?.editMoviesAtIndex(indexPath: index)
    }
    
}
