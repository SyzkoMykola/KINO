import UIKit

class TVViewController: UIViewController {

    @IBOutlet weak var tvTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvTableView.delegate = self
        tvTableView.dataSource = self
        
    }
    
    @IBAction func seeAllTapped(_ sender: Any) {
            let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "SeeAllViewController") as? SeeAllViewController else {
                    print("Could not find the view controller")
                    return
            }
        
            guard let cell = (sender as AnyObject).superview?.superview as? TVTVCell else {
            return // or fatalError() or whatever
           }

        let indexPath = tvTableView.indexPath(for: cell)
        guard let row = indexPath?.row else {
            return
        }
        destinationViewController.whatSeeAllTapped = row
        
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
    @IBAction func searchPressed(_ sender: Any) {
        let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "SearchMoviesViewController") as? SearchMoviesViewController else {
                           print("Could not find the view controller")
                           return
        }
        destinationViewController.searchType = 2
        navigationController?.pushViewController(destinationViewController, animated: true)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
              navigationController?.setNavigationBarHidden(true, animated: true)
          } else {
              navigationController?.setNavigationBarHidden(false, animated: true)
          }
    }
    
}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tvTableView.dequeueReusableCell(withIdentifier: "TVTVCell", for: indexPath) as? TVTVCell else {fatalError()}
        let row = indexPath.row
        if row == 0 {
            guard let cell = tvTableView.dequeueReusableCell(withIdentifier: "TVTVCell", for: indexPath) as? TVTVCell else {fatalError()}
            cell.cellTypeCount = 1
            print("Я устанавливаю первый заголовок")
            cell.titleTVSectionLabel.text = "Popular TV"
            
            return cell
        } else if row == 1 {
            guard let cell = tvTableView.dequeueReusableCell(withIdentifier: "TVTVCell", for: indexPath) as? TVTVCell else {fatalError()}
            cell.cellTypeCount = 2
            print("Я устанавливаю второй заголовок")
            cell.titleTVSectionLabel.text = "Top rated TV"
            return cell
        } else {
            guard let cell = tvTableView.dequeueReusableCell(withIdentifier: "TVTVCell", for: indexPath) as? TVTVCell else {fatalError()}
            cell.cellTypeCount = 3
            print("Я устанавливаю третий заголовок")
            cell.titleTVSectionLabel.text = "TV on the air"
            return cell
        }
        
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 306
    }
    

    
}


 
