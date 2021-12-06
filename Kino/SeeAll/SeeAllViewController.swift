import UIKit

class SeeAllViewController: UIViewController{
    private var dataSource: UITableViewDiffableDataSource<Section, TV>!
    private var seeAllTvViewModel = SeeAllTVViewModel()
    private var searchMoviesViewModel = SearchMoviesViewModel()
    
    @IBOutlet weak var tvTableView: UITableView!
    
    var whatSeeAllTapped = 0
    var querySearch = ""
    
    fileprivate enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seeAllTvViewModel.fetchGanresTVData()
        loadTVData()
        configureDataSource()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadTVData(page: Int = 1) {

        if whatSeeAllTapped == 0 {
            seeAllTvViewModel.fetchPopularFilmData(page: page){ [weak self] in
                print("I HAVE LOAD DATA FOR POPULAR TV")
                self?.tvTableView.delegate = self
                self?.updateDataSource()
            }
        } else if whatSeeAllTapped == 1 {
            seeAllTvViewModel.fetchTopRatedTVData(page: page) {[weak self] in
                    print("I HAVE LOAD DATA FOR top rated")
                    self?.tvTableView.delegate = self
                    self?.updateDataSource()
            }
        } else {
            seeAllTvViewModel.fetchTvOnTheAirData(page: page) {[weak self] in
                        print("I HAVE LOAD DATA FOR tv on the air")
                        self?.tvTableView.delegate = self
                        self?.updateDataSource()
            }
        }
        
        
        }
    
    private func configureDataSource() {
        
            dataSource = UITableViewDiffableDataSource<Section, TV>(tableView: tvTableView) { (tableView, indexPath, tv) -> SeeAllTableViewCell? in
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllTableViewCell", for: indexPath) as? SeeAllTableViewCell else {fatalError()}
                if self.whatSeeAllTapped == 0 {
                    cell.updateLabel(indexPath.row)
                } else {
                    cell.countLabel.text = nil
                }
                cell.typeLabel.text = self.seeAllTvViewModel.combineGenreName(tv.gandersID)
                cell.setCellWithValuesOf(tv)
                cell.desingMyCell()
                return cell
                
            }
    }
    

    
    private func updateDataSource(){
        var snapshoot = NSDiffableDataSourceSnapshot<Section, TV>()
        
        if whatSeeAllTapped == 0 {
            snapshoot.appendSections([.main])
            snapshoot.appendItems(seeAllTvViewModel.getPopularTVData())
            
        } else if whatSeeAllTapped == 1 {
            snapshoot.appendSections([.main])
            snapshoot.appendItems(seeAllTvViewModel.getTopRatedTVData())
            
            } else {
                snapshoot.appendSections([.main])
                snapshoot.appendItems(seeAllTvViewModel.getTVOnTheAirData())
                
            }
        dataSource.apply(snapshoot, animatingDifferences: true, completion: nil)
    
    }
}


extension SeeAllViewController: UITableViewDelegate {
    // MARK: - Table heihgt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
    // MARK: - Table load new data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentPage = seeAllTvViewModel.getCurrentPage()
        let totalPages = seeAllTvViewModel.getTotalPages()
        var countInArray: Int?
        if whatSeeAllTapped == 0 {
            countInArray = seeAllTvViewModel.getPopularTVCount()
            
        } else if whatSeeAllTapped == 1 {
            countInArray = seeAllTvViewModel.getTopRatedTVCount()
            
            } else {
                countInArray = seeAllTvViewModel.getTVOnTheAirCount()
                
            }
        
        guard let currentRows = countInArray  else {
            return
        }
        
        if currentPage < totalPages && indexPath.row == currentRows - 4 {
            print("I am in WILLDISPLAY CELL")
            print("CURRENT_TOTAL_PAGES: \(totalPages)")
            
            let newPage = currentPage + 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.loadTVData(page: newPage)
                
                    }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "TVDetailViewController") as? TVDetailViewController else {
                           print("Could not find the view controller")
                           return
        }
        
        if whatSeeAllTapped == 0 {
            let tv = seeAllTvViewModel.cellForRowAtPopularTV(indexPath: indexPath)
            destinationViewController.id = tv.idTV
//            let text = seeAllTvViewModel.combineGenreName(tv.gandersID)
//            destinationViewController.genreText = text
            navigationController?.pushViewController(destinationViewController, animated: true)
        } else if whatSeeAllTapped == 1 {
            let tv = seeAllTvViewModel.cellForRowAtTopRatedTV(indexPath: indexPath)
            destinationViewController.id = tv.idTV
//            let text = seeAllTvViewModel.combineGenreName(tv.gandersID)
//            destinationViewController.genreText = text
            navigationController?.pushViewController(destinationViewController, animated: true)
        } else {
            let tv = seeAllTvViewModel.cellForRowAtTVOnTheAir(indexPath: indexPath)
            destinationViewController.id = tv.idTV
//            let text = seeAllTvViewModel.combineGenreName(tv.gandersID)
//            destinationViewController.genreText = text
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    
    
    
    
    
}








//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if whatSeeAllTapped == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllTableViewCell", for: indexPath) as? SeeAllTableViewCell else {
//                fatalError()
//            }
//            let tv = tvViewModel.cellForRowAtPopularTV(indexPath: indexPath)
//            cell.setCellWithValuesOf(tv)
//            cell.desingMyCell()
//            return cell
//        } else if whatSeeAllTapped == 1 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllTableViewCell", for: indexPath) as? SeeAllTableViewCell else {
//            fatalError()
//        }
//            let tv = tvViewModel.cellForRowAtTopRatedTV(indexPath: indexPath)
//            cell.setCellWithValuesOf(tv)
//            cell.desingMyCell()
//            return cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllTableViewCell", for: indexPath) as? SeeAllTableViewCell else {
//            fatalError()
//        }
//            let tv = tvViewModel.cellForRowAtTVOnTheAir(indexPath: indexPath)
//            cell.setCellWithValuesOf(tv)
//            cell.desingMyCell()
//            return cell
//        }
//    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 230
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}

