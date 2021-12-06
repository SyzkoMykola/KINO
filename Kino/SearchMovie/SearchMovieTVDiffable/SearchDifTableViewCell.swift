//
//  SearchDifTableViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 03.05.2021.
//

import UIKit

class SearchDifTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLAbel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var urlString: String = ""
    
    //Setup actors values
    func setCellWithValuesOfTV(_ tv: TV) {
        updateUI(photoPath: tv.posterPath, vote: tv.vote, name: tv.name)
    }
    
    func setCellWithValuesOfMovie(_ movie: Movie) {
        updateUI(photoPath: movie.posterPath, vote: movie.vote, name: movie.name)
    }
    
    
    // Update the UI Views
    private func updateUI(photoPath: String?, vote: Double, name: String) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
        self.rateLAbel.text = String(vote)
        self.nameLabel.text = name
        
        //Before we download the image we clear out the old one
        self.posterImage.image = nil
        
        getImageDataFrom(url: photoImageURL)
    }

    
    // MARK: Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle error
            if let error = error {
                print("DataTask error\(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                //Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.posterImage.image = image
                }
            }
            
        }.resume()
    }

}
