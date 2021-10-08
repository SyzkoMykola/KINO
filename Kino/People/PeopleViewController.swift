//
//  PeopleViewController.swift
//  Kino
//
//  Created by Alina Bilonozhko on 19.04.2021.
//

import UIKit

class PeopleViewController: UIViewController {
    
    private var apiService = ApiService()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Actor>!
    
    fileprivate enum Section {
        case main
    }
    

//    private var actors = [Actor]()
    
    private var viewModel = ActorsViewModel()

    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
            loadPopularActorsData()
            configureDataSource()
        

    }

    
   
    
    private func loadPopularActorsData(page: Int = 1) {
        viewModel.fetchPopularActorData(page: page) { [weak self] in
            self?.peopleCollectionView.delegate = self
            self?.updateDataSource()
            
        }
    }
    
    
    
    
    @IBAction func searchBarButtonTapped(_ sender: Any) {
        let viewController = UIViewController(nibName: "SearchViewController.", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
              navigationController?.setNavigationBarHidden(true, animated: true)
          } else {
              navigationController?.setNavigationBarHidden(false, animated: true)
          }
    }
    
    private func configureDataSource() {
    
        
        dataSource = UICollectionViewDiffableDataSource<Section, Actor>(collectionView: peopleCollectionView) { (collectionView, indexPath, actor) -> PeopleCollectionViewCell?  in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCollectionViewCell", for: indexPath) as? PeopleCollectionViewCell else {fatalError()}
            cell.setCellWithValuesOf(actor)
            cell.desingMyCell()
            return cell
            
        }
               
    }
    
    private func updateDataSource(){
        var snapshoot = NSDiffableDataSourceSnapshot<Section, Actor>()
        snapshoot.appendSections([.main])
        snapshoot.appendItems(viewModel.returnActors())
      
        dataSource.apply(snapshoot, animatingDifferences: true, completion: nil)
    
    }
    
    
    
}


 //MARK: CollectionView
extension PeopleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if currentPage < totalPages && indexPath.row == viewModel.getPopularActorsCount() - 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! PeopleCollectionViewCell
//            cell.activIndicator.startAnimating()
//            return cell
//        } else {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCollectionViewCell", for: indexPath) as! PeopleCollectionViewCell
//        let actor = viewModel.cellForRowAt(indexPath: indexPath)
//        cell.setCellWithValuesOf(actor)
//        cell.desingMyCell()
//            return cell
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 20) / 3
        return CGSize(width: width, height: 220.0)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var currentPage = viewModel.getCurrentPage()
        let totalPages = viewModel.getTotalPages()
        let countRow = viewModel.getPopularActorsCount() - 5
        if currentPage < totalPages && indexPath.row == countRow {
            currentPage = currentPage + 1
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.loadPopularActorsData(page: currentPage)
            }
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actor = viewModel.cellForRowAt(indexPath: indexPath)
        print("I have an actor ID in PeopleVC:\(actor.idAct)")
        // Pass data
        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "DetailPeopleViewController") as? DetailPeopleViewController else {
            print("Could not find the view controller")
            return
        }
        destinationViewController.id = actor.idAct
        navigationController?.pushViewController(destinationViewController, animated: true)

    }

}

extension UIView {
    func desingMyCell() {
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.masksToBounds = true
    }
}

extension PeopleViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Start prefetching")
        
    }
}





