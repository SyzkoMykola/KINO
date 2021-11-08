import UIKit

class SearchMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var urlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithValuesOfMovie(_ movie: Movie) {
        updateUI(name: movie.name, photoPath: movie.posterPath)
    }
    
    func setCellWithValuesOfTV(_ tv: TV) {
        updateUI(name: tv.name, photoPath: tv.posterPath)
    }
    
    // Update the UI Views
    private func updateUI(name: String, photoPath: String? ) {
        self.nameLabel.text = name
        
        guard let photoString = photoPath else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
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
