import UIKit

class TVCVCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLable: UILabel!
    @IBOutlet weak var starButton: UIImageView!
    
    private var urlString: String = ""
    
    func setCellWithValuesOfForPopular(_ tv: TV, hesh: Int) {
        updateUIForPopular(photoPath: tv.posterPath, hesh: hesh)
    }

    func setCellWithValuesOf(_ tv: TV) {
        updateUI(photoPath: tv.posterPath, vote: tv.vote)
    }
    
    // Update the UI Views
    private func updateUI(photoPath: String?, vote: Double) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImageView.image = UIImage(named: "noImage")
            return
        }
        self.rateLable.text = String(vote)
        
        //Before we download the image we clear out the old one
        self.posterImageView.image = nil
        
        getImageDataFrom(url: photoImageURL)
    }
    
    private func updateUIForPopular(photoPath: String?, hesh: Int) {
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImageView.image = UIImage(named: "noImage")
            return
        }
    
        self.starButton.image = nil
       
        self.rateLable.text = "#\(hesh)"
        
        //Before we download the image we clear out the old one
        self.posterImageView.image = nil
        
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
                    self.posterImageView.image = image
                }
            }
            
        }.resume()
    }
}
