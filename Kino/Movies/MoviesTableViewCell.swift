import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    private var moviesViewModel = MoviesViewModel()
    
    var cellTypeCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadMovieData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func loadMovieData() {

        moviesViewModel.fetchAllMoviesData() { [weak self] in
                        self?.moviesCollectionView.delegate = self
                        self?.moviesCollectionView.dataSource = self
                    }
            
        }
    

    
    
    
}


extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if cellTypeCount == 1 {
            guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {fatalError()}
            let movie = moviesViewModel.cellForRowAtPopularMovie(indexPath: indexPath)
            let row = indexPath.row + 1
            cell.setCellWithValuesOfForPopular(movie, hesh: row)
            cell.desingMyCell()
            return cell
            
        } else if cellTypeCount == 2   {
            guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {fatalError()}
            let movie = moviesViewModel.cellForRowAtTopRatedMovie(indexPath: indexPath)
            cell.setCellWithValuesOf(movie)
            cell.desingMyCell()
            return cell
        } else {
            guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {fatalError()}
            let movie = moviesViewModel.cellForRowAtUncomingMovie(indexPath: indexPath)
            cell.setCellWithValuesOfUncoming(movie, data: movie.releaseDate)
            cell.desingMyCell()
            return cell
        }
    }
  
}

