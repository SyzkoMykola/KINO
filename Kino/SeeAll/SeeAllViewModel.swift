import Foundation
import UIKit

class SeeAllTVViewModel {
    
    private var apiService = ApiService()
    private var popularTV = [TV]()
    private var topRatedTV = [TV]()
    private var tvOnTheAir = [TV]()
    private var tvGanres = [Int: String]()

    private var currentPage = 1
    private var totalPages = 1
    
    // MARK: func to get current page and totalPages
    func getCurrentPage() -> Int{
        return currentPage
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    // MARK: For get TV Ganres data
    func fetchGanresTVData() {

        apiService.getTVGanres{ [weak self] (result) in

            switch result {
            case .success(let listOF):
            
                let genres = listOF.results
                for genre in genres {
                    let id = genre.tvId
                    let name = genre.tvGenreName
                    self?.tvGanres[id] = name
                }
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.tvGanres.count))")
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.tvGanres))")
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    // MARK: For top rated TV Cell
    func fetchPopularFilmData(page: Int, completion: @escaping () -> ()) {

        apiService.getPopularTVData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                print("CURRENT PAGE FROM REQUEST: \(String(describing: self?.currentPage))")
                self?.totalPages = listOF.totalPages
                print("TOTAL PAGES  FROM REQUEST: \(String(describing: self?.totalPages))")
                self?.popularTV.append(contentsOf: listOF.result)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    
    // MARK: For top rated TV Cell
    func fetchTopRatedTVData(page: Int, completion: @escaping () -> ()) {

        apiService.getTopRatedTVData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                print("CURRENT PAGE FROM REQUEST: \(String(describing: self?.currentPage))")
                print("TOTAL PAGES  FROM REQUEST: \(String(describing: self?.totalPages))")
                self?.topRatedTV.append(contentsOf: listOF.result)
                
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //MARK: For TV on the Air
    func fetchTvOnTheAirData(page: Int, completion: @escaping () -> ()) {

        apiService.getTVOnTheAirData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                print("CURRENT PAGE FROM REQUEST: \(String(describing: self?.currentPage))")
                print("TOTAL PAGES  FROM REQUEST: \(String(describing: self?.totalPages))")
                self?.tvOnTheAir.append(contentsOf: listOF.result)
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
    func getTopRatedTVCount() -> Int {
        return topRatedTV.count
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
    
    func getTVOnTheAirCount() -> Int {
        return tvOnTheAir.count
    }
    
    // MARK: For top rated TV Cell
    
//    private func getNonOptionalTVGanres() -> [Int: String] {
//        guard tvGanres is [Int: String] else {
//            return [:]
//        }
//    }
    
    func getGanreName(id: Int) -> String {
//       let name = tvGanres[id]
//       return name
        let genreName = ""
        if let name = tvGanres[id] {
            return name
        }
        return genreName
    }
    
    func combineGenreName(_ idsGenre: [Int]) -> String {
        var ganreListString = ""
        for id in idsGenre{
            let name = getGanreName(id: id)
            print("I AM COMBINING YOUR NAME")
            ganreListString = ganreListString + "\(name) "

        }
        return ganreListString
    }
    
}
