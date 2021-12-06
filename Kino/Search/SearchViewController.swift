//
//  SearchViewController.swift
//  Kino
//
//  Created by Alina Bilonozhko on 22.04.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    var apiService = ApiService()
    private var viewModel = SearchViewModel()
    
    private var currentPage = 1
    private var totalPages = 500
    private var searchTextGlobal = ""
    
   
    @IBOutlet weak var searchConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
    
       // loadPopularActorsData(page: currentPage)
    }
    
    func configureUI(){
        tableView.isHidden = true
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.sizeToFit()
    }
    private func loadPopularActorsData(query: String, page: Int) {
        viewModel.fetchSearchPopularActorData(query: query, page: page) { [weak self] in
            self?.tableView.delegate = self
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
          
            
        }
    }

}



extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        let actor = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(actor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentPage < totalPages && indexPath.row == viewModel.getPopularActorsCount() - 5 {
            currentPage = currentPage + 1
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.loadPopularActorsData(query: self.searchTextGlobal, page: self.currentPage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actor = viewModel.cellForRowAt(indexPath: indexPath)
        print("I have an actor ID in SearchVC:\(actor.idAct)")
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        
        tableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            searchTextGlobal = searchText
            loadPopularActorsData(query: searchText, page: currentPage)
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}


