//
//  TVDetailViewController.swift
//  Kino
//
//  Created by Alina Bilonozhko on 04.05.2021.
//

import UIKit
//import YouTubePlayer
class TVDetailViewController: UIViewController {

    @IBOutlet weak var scrollDetailView: UIScrollView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var viewForStars: UIView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

//    @IBOutlet weak var youTubeView: YouTubePlayerView!
    
    
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    @IBOutlet weak var countActorsInTV: UILabel!
    @IBOutlet weak var recommendedTVCollectionView: UICollectionView!
    @IBOutlet weak var countRecommendedTV: UILabel!
    @IBOutlet weak var countRewies: UILabel!
    @IBOutlet weak var reviewsTableView: UITableView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, TV>!
    
    private var dataSourceReviews: UITableViewDiffableDataSource<Section, Review>!
    
    fileprivate enum Section {
        case main
    }
    
    private var viewModel = DetailTVViewModel()
    var id = 1
    private var urlString: String = ""
    private var urlStringTitle: String = ""
    var genreText = ""
    private var urlYouTube = "https://www.youtube.com/watch?v="
    
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var twoStar: UIImageView!
    @IBOutlet weak var threeStar: UIImageView!
    @IBOutlet weak var fourStar: UIImageView!
    @IBOutlet weak var fiveStar: UIImageView!
    @IBOutlet weak var sixStar: UIImageView!
    @IBOutlet weak var sevenStar: UIImageView!
    @IBOutlet weak var eightStar: UIImageView!
    @IBOutlet weak var nineStar: UIImageView!
    @IBOutlet weak var tenStar: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.fetchGanresTVData()
        loadTVDetailData(id: id)
        loadTVDetailActorData(id: id)
        loadReviewsData(id: id)
        loadRecommendedTVData(id: id)
        configureDataSource()
        configureDataSourceReviews()
    }
    
    private func loadTVDetailData(id: Int) {
        
        viewModel.fetchTVData(id: id) { [weak self] in
            let tvAR = self?.viewModel.getDetail()
            guard let tv = tvAR?[0] else {return}
            self?.setWithValuesOfTV(tv)
        }
    }
    
    private func loadTVDetailActorData(id: Int) {
        
       print("Я ДОЛЖЕН СЕЙЧАС ЗАГРУЗИТЬ АКТЕРОВ")
        
        viewModel.fetchCastData(id: id) { [weak self] in
            print("Я ЗАГРУЗИЛ АКТЕРОВ")
            self?.actorsCollectionView.delegate = self
            self?.actorsCollectionView.dataSource = self
            guard let count = self?.viewModel.getCountActor() else {return}
            self?.countActorsInTV.text = String(count)
            self?.actorsCollectionView.reloadData()
            
        }
        self.countActorsInTV.text = String(viewModel.getCountActor())
        
    }
    
    private func loadRecommendedTVData(id: Int, page: Int = 1) {
        
        viewModel.fetchRecommendedTVData(id: id, page: page) { [weak self] in
            self?.recommendedTVCollectionView.delegate = self
            guard let count = self?.viewModel.getReccomendedTVCount() else {return}
            self?.countRecommendedTV.text = String(count)
            self?.updateDataSource()
        }
    }
    
    private func loadReviewsData(id: Int, page: Int = 1) {
        viewModel.fetchReviewsData(id: id, page: page) { [weak self] in
            self?.reviewsTableView.delegate = self
            guard let countReviews = self?.viewModel.getReviewsCount() else {return}
            if countReviews == 0 {
                self?.reviewsTableView.isHidden = true
            }
            self?.countRewies.text = String(countReviews)
            self?.updateDataSourceReviews()
            
        }
    }
    
    private func configureDataSource() {
        
            dataSource = UICollectionViewDiffableDataSource<Section, TV>(collectionView: recommendedTVCollectionView) { (collectionView, indexPath, tv) -> RecommendedCollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as? RecommendedCollectionViewCell else {fatalError()}
                cell.setCellWithValuesOf(tv)
                cell.desingMyCell()
                return cell
                
            }
    }
    
    private func configureDataSourceReviews() {
        
        dataSourceReviews = UITableViewDiffableDataSource<Section, Review>(tableView: reviewsTableView) { (tableView, indexPath, review) ->  OverviewTableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OverviewTableViewCell else {fatalError()}
            cell.setCellWithValuesOfReviews(review)
            cell.desingMyCell()
            return cell
            
        }
    }
    
    private func updateDataSourceReviews(){
        var snapshootReviews = NSDiffableDataSourceSnapshot<Section, Review>()
        snapshootReviews.appendSections([.main])
        snapshootReviews.appendItems(viewModel.getReviewsData())
        dataSourceReviews.apply(snapshootReviews, animatingDifferences: true, completion: nil)
    
    }
    
    
    private func updateDataSource(){
        var snapshoot = NSDiffableDataSourceSnapshot<Section, TV>()
        snapshoot.appendSections([.main])
        snapshoot.appendItems(viewModel.getReccomendedData())
            
     
        dataSource.apply(snapshoot, animatingDifferences: true, completion: nil)
    
    }
    
    //Setup actors values
    func setWithValuesOfTV(_ tv: DetailTV) {
        updateUI(photoPath: tv.posterPath, vote: tv.vote, name: tv.name, firstAirData: tv.firstAirData, ovierview: tv.overview, countryName: tv.country, titleImage: tv.titleImage)
    }
    
    // Update the UI Views
    private func updateUI(photoPath: String?, vote: Double, name: String, firstAirData: String, ovierview: String, countryName: [String], titleImage: String?) {
        
        guard let photoString = photoPath else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
        urlString = "https://image.tmdb.org/t/p/w500" + photoString
        
        guard let photoImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImage")
            return
        }
//        guard let titleImageString = titleImage else {return}
//        urlStringTitle = "https://image.tmdb.org/t/p/w500" + titleImageString
//        guard let titlleImageURL = URL(string: urlStringTitle) else {
//            return
//        }
//        getImageDataForTitle(url: titlleImageURL)
        self.genreLabel.text = viewModel.getGanreName()
        self.rateLabel.text = String(vote)
        self.navigationItem.title = name
        self.dataLabel.text = firstAirData
        self.overviewTextView.text = ovierview
        overviewTextView.isEditable = false
        self.country.text = countryName[0]
        
        let stars = [oneStar, twoStar, threeStar, fourStar, fiveStar, sixStar, sevenStar, eightStar, nineStar, tenStar]
        
        let voteNumber = modf(vote)
        
        let fillStars = Int(voteNumber.0 - 1)
        for i in 0...fillStars {
            stars[i]?.image = UIImage(systemName: "star.fill")
        }
        let halfStar = voteNumber.1
        let starHalfAr = Int(voteNumber.0)
        if halfStar <= 0.2  {
            stars[starHalfAr]?.image = UIImage(systemName: "star")
        } else if halfStar >= 0.2 && halfStar <= 0.8 {
            stars[starHalfAr]?.image = UIImage(systemName: "star.fill.left")
        } else  {
            stars[starHalfAr]?.image = UIImage(systemName: "star.fill")
        }
      
//        if viewModel.getYouTubeURL() != nil{
//            guard let urlString = viewModel.getYouTubeURL() else {return}
//            guard let url = URL(string: urlString) else {return}
//            youTubeView.loadVideoURL(url)
//            
//        } else {
//            youTubeView.isHidden = true
//        }
//        
        
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
    
//    private func getImageDataForTitle(url: URL) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            // Handle error
//            if let error = error {
//                print("DataTask error\(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                //Handle Empty Data
//                print("Empty Data")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                if let image = UIImage(data: data){
//                    self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
//                }
//            }
//            
//        }.resume()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.actorsCollectionView {
            return viewModel.numberOfRowsInSectionActor(section: section)
        } else {
            return viewModel.numberOfRowsInSectionReccomendedTV(section: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.actorsCollectionView {
        let cellActors = actorsCollectionView.dequeueReusableCell(withReuseIdentifier: "ActorsTVDetailCollectionViewCell", for: indexPath) as! ActorsTVDetailCollectionViewCell
        let actor = viewModel.cellForRowAtActor(indexPath: indexPath)
        cellActors.setCellWithValuesOfActors(actor)
        cellActors.desingMyCell()
            return cellActors
        } else {
            let cellRecommended = recommendedTVCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as! RecommendedCollectionViewCell
            return cellRecommended
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.actorsCollectionView {
            let width = (actorsCollectionView.frame.size.width - 30) / 4
            let hight = actorsCollectionView.frame.size.height
            return CGSize(width: width, height: hight)
        } else {
            let width = (recommendedTVCollectionView.frame.size.width - 30) / 4
            let hight = recommendedTVCollectionView.frame.size.height
            return CGSize(width: width, height: hight)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.actorsCollectionView {
            let actor = viewModel.cellForRowAtActor(indexPath: indexPath)
            print("I have an actor ID in PeopleVC:\(actor.idActor)")
            // Pass data
            let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "DetailPeopleViewController") as? DetailPeopleViewController else {
                print("Could not find the view controller")
                return
            }
            destinationViewController.id = actor.idActor
            navigationController?.pushViewController(destinationViewController, animated: true)
        } else {
            let tv = viewModel.cellForRowAtTV(indexPath: indexPath)
            let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "TVDetailViewController") as?TVDetailViewController else {
                print("Could not find the view controller")
                return
            }
            destinationViewController.id = tv.idTV
            navigationController?.pushViewController(destinationViewController, animated: true)
    }
 }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if collectionView == self.recommendedTVCollectionView {
//            let currentPage = viewModel.getCurrentPage()
//            let totalPages = viewModel.getTotalPages()
//            if currentPage < totalPages && indexPath.row == viewModel.getReccomendedTVCount() - 5 {
//                print("I am in WILLDISPLAY CELL")
//                print("CURRENT_TOTAL_PAGES: \(totalPages)")
//                
//                let newPage = currentPage + 1
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() ) {
//                    self.loadRecommendedTVData(id: self.id, page: newPage)
//                    
//                        }
//            }
//        } else {
//            
//        }
    }
    
    
    

    
}

extension TVDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
        
}
