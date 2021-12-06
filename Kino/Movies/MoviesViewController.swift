import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var tittleLabel: UILabel!
    let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchTapped(_ sender: Any) {

        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "SearchMoviesViewController") as? SearchMoviesViewController else {
                           print("Could not find the view controller")
                           return
        }
        destinationViewController.searchType = 1

        navigationController?.pushViewController(destinationViewController, animated: true)
        
  

    }
    
    @IBAction func seeAllTypeTapped(_ sender: Any) {
        
        guard let vc = mainStorybord.instantiateViewController(withIdentifier: "SeeAllMoviesViewController") as? SeeAllMoviesViewController else {
                           print("Could not find the view controller")
                           return
        }
        
        print("I am in seeAllTypeTapped")
        
        guard let cell = (sender as AnyObject).superview?.superview as? MoviesTableViewCell else {return}
//        guard let cell = (sender as AnyObject).superview??.superview  as? SeeAllMoviesTableViewCell else {
//            return // or fatalError() or whatever
//            }

        let indexPath = moviesTableView.indexPath(for: cell)
        
        guard let row = indexPath?.row else {
            print("I am in seeAllTypeTapped. and it is problem in indexPath")
            return
        }
        
        vc.type = row
        print("\(vc.type)")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
              navigationController?.setNavigationBarHidden(true, animated: true)
          } else {
              navigationController?.setNavigationBarHidden(false, animated: true)
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


extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        if row == 0 {
            guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {fatalError()}
            cell.cellTypeCount = 1
            print("Я устанавливаю первый заголовок")
            
            cell.titleLabel.text = "Popular movies"
            return cell
        } else if row == 1 {
            guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {fatalError()}
            cell.cellTypeCount = 2
            print("Я устанавливаю второй заголовок")
       
            cell.titleLabel.text = "Top rated movies"
            return cell
        } else {
            guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {fatalError()}
            cell.cellTypeCount = 3
            print("Я устанавливаю третий заголовок")
            
            cell.titleLabel.text = "Uncoming movies"
            return cell
        }
        
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 306
    }
}
