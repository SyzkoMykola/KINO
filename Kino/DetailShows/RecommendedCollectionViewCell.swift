//
//  RecommendedCollectionViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 04.05.2021.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ tv: TV) {
        updateUI(photoPath: tv.posterPath, vote: tv.vote)
    }
    
    // Update the UI Views
    private func updateUI(photoPath: String?, vote: Double) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
        self.rateLabel.text = String(vote)
        
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
