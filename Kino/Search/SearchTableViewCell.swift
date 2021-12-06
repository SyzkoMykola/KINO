//
//  SearchTableViewCell.swift
//  Kino
//
//  Created by Alina Bilonozhko on 22.04.2021.
//

import UIKit

protocol SendBackLocations {
    func sendBackLocations(locations: [CGPoint])
}

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageCell: UIImageView!
    
    @IBOutlet weak var nameLabelCell: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ actor: Actor) {
        updateUI(name: actor.name, photoPath: actor.photoPath)
    }
    
    // Update the UI Views
    private func updateUI(name: String, photoPath: String? ) {
        self.nameLabelCell.text = name
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.photoImageCell.image = UIImage(named: "noImage")
            return
        }
        self.photoImageCell.image = nil
        
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
                    self.photoImageCell.image = image
                }
            }
            
        }.resume()
    }
    
        
    
}
