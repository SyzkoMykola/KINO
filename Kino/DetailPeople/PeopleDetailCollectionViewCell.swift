//
//  PeopleDetailCollectionViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 26.04.2021.
//

import UIKit

class PeopleDetailCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var retLabel : UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    private var urlString: String = ""
    
    //Setup actors values
    func setCellWithValuesOf(_ movie: MovieCredit) {
        updateUI(vote: movie.vote, photoPath: movie.path)
    }
    
    // Update the UI Views
    private func updateUI(vote: Double, photoPath: String? ) {
        
        self.retLabel.text = String(vote)
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.movieImage.image = UIImage(named: "noImageAvailable")
            return
        }
        
        
        //Before we download the image we clear out the old one
        self.movieImage.image = nil
        
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
                    self.movieImage.image = image
                }
            }
            
        }.resume()
    }
}
