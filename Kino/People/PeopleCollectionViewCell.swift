//
//  PeopleCollectionViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 19.04.2021.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    
    @IBOutlet weak var activIndicator: UIActivityIndicatorView!
    
    private var urlString: String = ""
    
    //Setup actors values
    func setCellWithValuesOf(_ actor: Actor) {
        updateUI(name: actor.name, photoPath: actor.photoPath)
    }
    
    // Update the UI Views
    private func updateUI(name: String, photoPath: String? ) {
        self.personNameLabel.text = name
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.personImage.image = UIImage(named: "noImage")
            return
        }
        
        //Before we download the image we clear out the old one
        self.personImage.image = nil
        
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
                    self.personImage.image = image
                }
            }
            
        }.resume()
    }
}
