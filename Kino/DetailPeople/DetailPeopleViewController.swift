//
//  DetailPeopleViewController.swift
//  Kino
//
//  Created by Alina Bilonozhko on 24.04.2021.
//

import UIKit

class DetailPeopleViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailPeopleContenView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var motherland: UILabel!
    @IBOutlet weak var biografhyTextField: UITextView!
    @IBOutlet weak var countOfMoviesLable: UILabel!
    @IBOutlet weak var movieCollectionViewe: UICollectionView!
    
    private var urlString: String = ""
    
    private var apiService = ApiService()
    private var viewModel = DatailPeopleViewModel()
    var id = 76543
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Check ID before loading data: \(id)")
        loadData(id: id)
        loadMovieCredits(id: id)
        print("I am hear in viewDidLoadDetail")
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    
    
    private func loadData(id: Int) {
        
        apiService.searchForActorData(id: id) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
        
                guard let birthDay = listOF.birthday else {
                    self?.birthday.text = ""
                    return
                }
                self?.birthday.text = birthDay

                guard let birhPlace = listOF.birth else {
                    self?.motherland.text = ""
                    return
                }
                self?.motherland.text = birhPlace
                let biography = listOF.biography
                print(biography)
                if listOF.biography == "" {
                    self?.biografhyTextField.text = ""
                    self?.biografhyTextField.isEditable = false
                } else {
                    self?.biografhyTextField.text = listOF.biography
                    self?.biografhyTextField.isEditable = false
                }
                
                self?.navigationItem.title = listOF.name
                
                guard let photoString = listOF.photoPath else {return}
                let urlForImage = "https://image.tmdb.org/t/p/w500" + photoString

                guard let photoImageURL = URL(string: urlForImage) else {
                    self?.photoImage.image = UIImage(named: "noImage")
                    return
                }
                //self?.photoImage.image = nil
                self?.getImageDataFrom(url: photoImageURL)
                print("I have set everything")
                
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
        }
    }
    
    
    private func loadMovieCredits(id: Int) {
        viewModel.fetchForActorMovieCredits(id: id) { [weak self] in
            guard let stringVoteCount = self?.viewModel.getMovieCount() else {return}
            self?.countOfMoviesLable.text = String(stringVoteCount)
            self?.movieCollectionViewe.delegate = self
            self?.movieCollectionViewe.dataSource = self
            self?.movieCollectionViewe.reloadData()
            
        }
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
                    self.photoImage.image = image
                } else {
                    self.photoImage.image = UIImage(named: "noImage")
                }
            }

        }.resume()
    }
 

}

extension DetailPeopleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleDetailCell", for: indexPath) as! PeopleDetailCollectionViewCell
        let actor = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(actor)
        cell.desingMyCell()
            return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (movieCollectionViewe.frame.size.width - 30) / 4
        let hight = movieCollectionViewe.frame.size.height
        return CGSize(width: width, height: hight)
    }

//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if currentPage < totalPages && indexPath.row == viewModel.getPopularActorsCount() - 5 {
//            currentPage = currentPage + 1
//            DispatchQueue.main.asyncAfter(deadline: .now() ) {
//                self.loadPopularActorsData(page: self.currentPage)
//            }
//        }
//
//    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let actor = viewModel.cellForRowAt(indexPath: indexPath)
//        print("I have an actor ID in PeopleVC:\(actor.id)")
//        // Pass data
//        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "DetailPeopleViewController") as? DetailPeopleViewController else {
//            print("Could not find the view controller")
//            return
//        }
//        destinationViewController.id = actor.id
//        navigationController?.pushViewController(destinationViewController, animated: true)
//
//    }

}

extension Sequence {
    
}
