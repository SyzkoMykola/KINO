import UIKit
 

class TVViewModel {
    
    private var apiService = ApiService()
    
    private var popularTV = [TV]()
    private var topRatedTV = [TV]()
    private var tvOnTheAir = [TV]()
    
    private var allShows = [TVData]()
    
    private var currentPage = 1
    private var totalPages = 1


    // MARK: func to get current page and totalPages
    func getCurrentPage() -> Int{
        return currentPage
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    
    func setNewCurrentPage(_ page: Int) {
        currentPage = page
        print("Я обновляю запрос и меняю номер страницы. Новая страница\(currentPage)")
    }
    

    
    //    MARK: Fetch for all tv data
    
    func fetchAllTvData(completion: @escaping () -> ()) {

        apiService.searchForAllTVShowsData() { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.popularTV.removeAll()
                self?.topRatedTV.removeAll()
                self?.tvOnTheAir.removeAll()
                self?.popularTV = listOF[0]
                self?.topRatedTV = listOF[1]
                self?.tvOnTheAir = listOF[2]
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    // MARK: Setings for popular tv cell
    func numberOfRowsInSectionPopularTV (section: Int) -> Int {
        return popularTV.count
    }
    
    func cellForRowAtPopularTV(indexPath: IndexPath) -> TV {
        return popularTV[indexPath.row]
    }
    
    func getPopularTVData() -> [TV] {
        return popularTV
    }
    
    func getPopularTVCount() -> Int {
        return popularTV.count
    }
    
    
    // MARK: Setings for top tv rated cell
    
    func numberOfRowsInSectionTopRatedTV (section: Int) -> Int {
        return topRatedTV.count
    }
    
    func cellForRowAtTopRatedTV(indexPath: IndexPath) -> TV {
        return topRatedTV[indexPath.row]
    }
    
    func getTopRatedTVData() -> [TV]  {
        return topRatedTV
    }
    
    
    // MARK: Setings for TV on the air Cell
    
    func numberOfRowsInSectionTVOnTheAir (section: Int) -> Int {
        return tvOnTheAir.count
    }
    
    func cellForRowAtTVOnTheAir(indexPath: IndexPath) -> TV {
        return tvOnTheAir[indexPath.row]
    }
    
    func getTVOnTheAirData() -> [TV]  {
        return tvOnTheAir
    }
    
    
}
