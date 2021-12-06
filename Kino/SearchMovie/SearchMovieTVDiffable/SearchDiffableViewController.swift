//
//  SearchDiffableViewController.swift
//  Kino
//
//  Created by Alina Bilonozhko on 02.05.2021.
//

import UIKit

class SearchDiffableViewController: UIViewController {

    var querySearch = "s"
    private var dataSourceTV: UITableViewDiffableDataSource<Section, TV>!
    private var dataSourceMovie: UITableViewDiffableDataSource<Section, Movie>!
    private var searchViewModel = SearchMoviesViewModel()
    
    fileprivate enum Section {
        case main
    }
    
    var type = 1
    
    @IBOutlet weak var searchDifTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(querySearch)")
        if type == 2 {
            searchViewModel.fetchGanresTVData()
        } else {
            searchViewModel.fetchGanresMoviesData()
        }
        loadData(page: 1, query: querySearch)
        configureDataSource()
    }
    

    private func loadData(page: Int = 1, query: String) {
        if type == 2 {
            searchViewModel.fetchSearchInTVDataDif(query: querySearch, page: page) { [weak self] in
                self?.searchDifTableView.delegate = self
                self?.updateDataSource()
                
            }

        } else {
            searchViewModel.fetchSearchInMoviesDataDif(query: querySearch, page: page) { [weak self] in
                self?.searchDifTableView.delegate = self
                self?.updateDataSource()
                
            }
        }
    }
    
    private func configureDataSource() {
        
        if type == 2 {
            dataSourceTV = UITableViewDiffableDataSource<Section, TV>(tableView: searchDifTableView) { (tableView, indexPath, tv) -> SearchDifTableViewCell? in
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDifTableViewCell", for: indexPath) as? SearchDifTableViewCell else {fatalError()}
                
                cell.genreLabel.text = self.searchViewModel.combineGenreName(tv.gandersID)
                cell.setCellWithValuesOfTV(tv)
                cell.desingMyCell()
                return cell
                
            }
        } else {
            dataSourceMovie = UITableViewDiffableDataSource<Section, Movie>(tableView: searchDifTableView) { (tableView, indexPath, movie) -> SearchDifTableViewCell? in
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDifTableViewCell", for: indexPath) as? SearchDifTableViewCell else {fatalError()}
                
                cell.genreLabel.text = self.searchViewModel.combineGenreName(movie.gandersID)
                cell.setCellWithValuesOfMovie(movie)
                cell.desingMyCell()
                return cell
                
            }
        }
           
    }
    
    private func updateDataSource(){
        if type == 2 {
            var snapshoot = NSDiffableDataSourceSnapshot<Section, TV>()
            snapshoot.appendSections([.main])
            snapshoot.appendItems(searchViewModel.getTVData())
            dataSourceTV.apply(snapshoot, animatingDifferences: true, completion: nil)
        } else {
            var snapshoot = NSDiffableDataSourceSnapshot<Section, Movie>()
            snapshoot.appendSections([.main])
            snapshoot.appendItems(searchViewModel.getMoviesData())
            dataSourceMovie.apply(snapshoot, animatingDifferences: true, completion: nil)
        }
    
    }


}

extension SearchDiffableViewController: UITableViewDelegate {
    // MARK: - Table heihgt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
    // MARK: - Table load new data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let currentPage = searchViewModel.getCurrentPage()
        let totalPages = searchViewModel.getTotalPages()
        var countInArray: Int?
        
        if type == 1 {
            countInArray = searchViewModel.getSearchMoviesCount()
        } else {
            countInArray = searchViewModel.getSearchTVCount()
            
        }
                
        guard let currentRows = countInArray  else {
            return
        }
        
        if currentPage < totalPages && indexPath.row == currentRows  - 10 {
            print("I am in WILLDISPLAY CELL")
            print("CURRENT_TOTAL_PAGES: \(totalPages)")
            
            let newPage = currentPage + 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.loadData(page: newPage, query: self.querySearch)
                
                    }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "TVDetailViewController") as? TVDetailViewController else {
                           print("Could not find the view controller")
                           return
        }
        
        if type == 2 {
            let tv = searchViewModel.cellForRowAtSearchedTV(indexPath: indexPath)
            destinationViewController.id = tv.idTV
//            let text = seeAllTvViewModel.combineGenreName(tv.gandersID)
//            destinationViewController.genreText = text
        }
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
    
    
    
}
