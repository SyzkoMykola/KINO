import UIKit

class TVTVCell: UITableViewCell {

    @IBOutlet weak var tvCollectionView: UICollectionView!
    @IBOutlet weak var titleTVSectionLabel: UILabel!
    var tvViewModel = TVViewModel()
    private var apiService = ApiService()
    var cellTypeCount = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadTVData()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    private func loadTVData() {

        tvViewModel.fetchAllTvData() { [weak self] in
                        self?.tvCollectionView.delegate = self
                        self?.tvCollectionView.dataSource = self
                    }
            
        }
    
}

extension TVTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if cellTypeCount == 1 {
            guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: "TVCVCell", for: indexPath) as? TVCVCell else {fatalError()}
            let tv = tvViewModel.cellForRowAtPopularTV(indexPath: indexPath)
            let row = indexPath.row + 1
            cell.setCellWithValuesOfForPopular(tv, hesh: row)

            cell.desingMyCell()
            return cell
        } else if cellTypeCount == 2   {
            guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: "TVCVCell", for: indexPath) as? TVCVCell else {fatalError()}
            let tv = tvViewModel.cellForRowAtTopRatedTV(indexPath: indexPath)
            cell.setCellWithValuesOf(tv)
            cell.desingMyCell()
            return cell
        } else {
            guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: "TVCVCell", for: indexPath) as? TVCVCell else {fatalError()}
            let tv = tvViewModel.cellForRowAtTVOnTheAir(indexPath: indexPath)
            cell.setCellWithValuesOf(tv)
            cell.desingMyCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            
            let mainStorybord = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let destinationViewController = mainStorybord.instantiateViewController(withIdentifier: "TVDetailViewController") as? TVDetailViewController else {
                               print("Could not find the view controller")
                               return
            }
        
        if cellTypeCount == 1 {
            let tv = tvViewModel.cellForRowAtPopularTV(indexPath: indexPath)
            destinationViewController.id = tv.idTV
            guard let tvVC = mainStorybord.instantiateViewController(withIdentifier: "TVViewController")
                    as? TVViewController else {
                print("Could not find the view controller TVVIEWCONTROLLER")
                return
            }
            tvVC.navigationController?.pushViewController(destinationViewController, animated: true)
        } else if cellTypeCount == 2 {
            let tv = tvViewModel.cellForRowAtTopRatedTV(indexPath: indexPath)
            destinationViewController.id = tv.idTV
            guard let tvVC = mainStorybord.instantiateViewController(withIdentifier: "TVViewController")
                    as? TVViewController else {
                print("Could not find the view controller TVVIEWCONTROLLER")
                return
            }
            tvVC.navigationController?.pushViewController(destinationViewController, animated: true)
        } else {
            let tv = tvViewModel.cellForRowAtTVOnTheAir(indexPath: indexPath)
            destinationViewController.id = tv.idTV
            guard let tvVC = mainStorybord.instantiateViewController(withIdentifier: "TVViewController")
                    as? TVViewController else {
                print("Could not find the view controller TVVIEWCONTROLLER")
                return
            }
            tvVC.navigationController?.pushViewController(destinationViewController, animated: true)
        }
    //            let text = seeAllTvViewModel.combineGenreName(tv.gandersID)
    //            destinationViewController.genreText = text
     
        
    }
    
    
  
}


