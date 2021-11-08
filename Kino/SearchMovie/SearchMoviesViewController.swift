import UIKit

class SearchMoviesViewController: UIViewController {

    @IBOutlet weak var searchMoviesTableView: UITableView!
    @IBOutlet weak var topConstSMTV: NSLayoutConstraint!
    @IBOutlet weak var downConst: NSLayoutConstraint!
    
    private var searchMoviesViewModel = SearchMoviesViewModel()
    private let searchBar = UISearchBar()
    private var searchTextGlobal = ""
    
    var searchType = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        searchMoviesTableView.isHidden = true
        navigationItem.titleView = searchBar
        searchBar.delegate = self
//        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.sizeToFit()
    }
    
    private func loadSearchMoviesData(query: String, page: Int) {
        searchMoviesViewModel.fetchSearchInMoviesData(query: query, page: page) { [weak self] in
            self?.searchMoviesTableView.delegate = self
            self?.searchMoviesTableView.dataSource = self
            self?.searchMoviesTableView.reloadData()
          
            
        }
    }
    
    private func loadSearchTVData(query: String, page: Int) {
        searchMoviesViewModel.fetchSearchInTVData(query: query, page: page) { [weak self] in
                self?.searchMoviesTableView.delegate = self
                self?.searchMoviesTableView.dataSource = self
                self?.searchMoviesTableView.reloadData()
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchType == 1 {
            return searchMoviesViewModel.numberOfRowsInSection(section: section)
            
        } else {
            return searchMoviesViewModel.rowSearchedTV(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if searchType == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMoviesTableViewCell", for: indexPath) as! SearchMoviesTableViewCell
            let movie = searchMoviesViewModel.cellForRowAt(indexPath: indexPath)
            cell.setCellWithValuesOfMovie(movie)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMoviesTableViewCell", for: indexPath) as! SearchMoviesTableViewCell
            let tv = searchMoviesViewModel.cellForRowAtSearchedTV(indexPath: indexPath)
            cell.setCellWithValuesOfTV(tv)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var currentPage = searchMoviesViewModel.getCurrentPage()
        let totalPages = searchMoviesViewModel.getTotalPages()
        
        if searchType == 1 {
            let sectionToLoad = searchMoviesViewModel.getSearchMoviesCount() - 1
            
            if currentPage < totalPages && indexPath.row == sectionToLoad {
                currentPage = currentPage + 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    self.loadSearchMoviesData(query: self.searchTextGlobal, page: currentPage)
                }
                
            }
            
        } else {
            let sectionToLoad = searchMoviesViewModel.getSearchTVCount() - 1
            if currentPage < totalPages && indexPath.row == sectionToLoad {
                currentPage = currentPage + 1
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    self.loadSearchTVData(query: self.searchTextGlobal, page: currentPage)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "TVDetailViewController") as? TVDetailViewController else {
                           print("Could not find the view controller")
                           return
        }
        
        if searchType == 2 {
            let tv = searchMoviesViewModel.cellForRowAtSearchedTV(indexPath: indexPath)
            destinationViewController.id = tv.idTV
//            let text = seeAllTvViewModel.combineGenreName(tv.gandersID)
//            destinationViewController.genreText = text
        }
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    

    
}



extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        topConstSMTV.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        
        searchMoviesTableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false && searchType == 1 {
            searchTextGlobal = searchText
            let currentPage = searchMoviesViewModel.getCurrentPage()
            loadSearchMoviesData(query: searchText, page: currentPage)
            
        } else if searchText.isEmpty == false && searchType == 2 {
            searchTextGlobal = searchText
            let currentPage = searchMoviesViewModel.getCurrentPage()
            loadSearchTVData(query: searchText, page: currentPage)
            
        }
        searchMoviesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("I have clicked in search button in keyboard")
        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "SearchDiffableViewController") as? SearchDiffableViewController else {
                           print("Could not find the view controller")
                           return
        }
        destinationViewController.querySearch = searchTextGlobal
        destinationViewController.type = searchType
        
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
}
