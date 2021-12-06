import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOfForPopular(_ movie: Movie, hesh: Int) {
        updateUIForPopular(photoPath: movie.posterPath, hesh: hesh)
    }
    
    func setCellWithValuesOfUncoming(_ movie: Movie, data: String) {
        updateUIForUncoming(photoPath: movie.posterPath, data: movie.releaseDate)
    }

    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(photoPath: movie.posterPath, vote: movie.vote)
    }
    
    // Update the UI Views
    
    private func updateUIForUncoming(photoPath: String?, data: String) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
    
        self.starImage.image = nil
       
        self.rateLabel.text = data
        
        //Before we download the image we clear out the old one
        self.posterImage.image = nil
        
        getImageDataFrom(url: photoImageURL)
    }

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
    
    private func updateUIForPopular(photoPath: String?, hesh: Int) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
    
        self.starImage.image = nil
       
        self.rateLabel.text = "#\(hesh)"
        
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
