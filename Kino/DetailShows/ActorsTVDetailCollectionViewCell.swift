//
//  ActorsTVDetailCollectionViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 04.05.2021.
//

import UIKit

class ActorsTVDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImge: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOfActors(_ actor: TVDetailActor) {
        updateUI(photoPath: actor.photoPath, name: actor.name)
    }
    
    private func updateUI(photoPath: String?, name: String) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.photoImge.image = UIImage(named: "noImage")
            return
        }
        self.nameLabel.text = name
        
        //Before we download the image we clear out the old one
        self.photoImge.image = nil
        
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
                    self.photoImge.image = image
                }
            }
            
        }.resume()
    }
}
