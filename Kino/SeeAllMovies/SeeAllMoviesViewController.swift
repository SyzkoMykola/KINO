import UIKit

class SeeAllMoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Movie>!
    private var viewModel = SeeAllMoviesViewModel()
    var type = 0
    
    
    fileprivate enum Section {
        case main
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchGanresMoviesData()
        loadMoviesData()
        configureDataSource()
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }
  
    
    private func loadMoviesData(page: Int = 1) {
        
        if type == 0 {
            
            viewModel.fetchPopularMoviesData(page: page) {  [weak self] in
                print("I HAVE LOAD DATA FOR popular movies")
                self?.moviesTableView.delegate = self
                self?.updateDataSource()
            }
            
        } else if type == 1 {
            
            viewModel.fetchTopRatedMoviesData(page: page) {  [weak self] in
                print("I HAVE LOAD DATA FOR top rated movies")
                self?.moviesTableView.delegate = self
                self?.updateDataSource()
                
            }
            
        } else {
            
            viewModel.fetchUncomingMoviesData(page: page) {  [weak self] in
                print("I HAVE LOAD DATA FOR uncoming movies")
                self?.moviesTableView.delegate = self
                self?.updateDataSource()
                
            }
        }
       
        
    }
    
    private func configureDataSource() {
        
            dataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: moviesTableView) { (tableView, indexPath, movie) -> SeeAllMoviesTableViewCell? in
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllMoviesTableViewCell", for: indexPath) as? SeeAllMoviesTableViewCell else {fatalError()}
                if self.type == 0 {
                    cell.updateLabel(indexPath.row)
                } else {
                    cell.countLabel.text = nil
                }
                cell.genreLabel.text = self.viewModel.combineGenreName(movie.gandersID)
                cell.setCellWithValuesOf(movie)
                cell.desingMyCell()
                return cell
                
            }
    }
    
    private func updateDataSource(){
        var snapshoot = NSDiffableDataSourceSnapshot<Section, Movie>()
        
        if type == 0 {
            snapshoot.appendSections([.main])
            snapshoot.appendItems(viewModel.getPopularMovieData())
            
        } else if type == 1 {
            snapshoot.appendSections([.main])
            snapshoot.appendItems(viewModel.getTopRatedMovieData())
            
            } else {
                snapshoot.appendSections([.main])
                snapshoot.appendItems(viewModel.getUncomingMovieData())
                
            }
        dataSource.apply(snapshoot, animatingDifferences: true, completion: nil)
    
    }
    

   

}

extension SeeAllMoviesViewController: UITableViewDelegate {
    // MARK: - Table heihgt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
    // MARK: - Table load new data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentPage = viewModel.getCurrentPage()
        let totalPages = viewModel.getTotalPages()
        var countInArray: Int?
        if type == 0 {
            countInArray = viewModel.getPopularMovieCount()
            
        } else if type == 1 {
            countInArray = viewModel.getTopRatedMovieCount()
            
            } else {
                countInArray = viewModel.getUncomingMovieCount()
                
            }
        
        guard let currentRows = countInArray  else {
            return
        }
        
        if currentPage < totalPages && indexPath.row == currentRows - 4 {
            print("I am in WILLDISPLAY CELL")
            print("CURRENT_TOTAL_PAGES: \(totalPages)")
            
            let newPage = currentPage + 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.loadMoviesData(page: newPage)
                
                    }
        }
    }
    
    
    
    
    
}

