import Foundation
import UIKit

class SearchMoviesViewModel {
    
    private var searchedMovies = [Movie]()
    private var searchedTV = [TV]()
    private var apiService = ApiService()
    private var currentPage = 1
    private var totalPages = 1
    private var ganres = [Int: String]()
    
    // MARK: Get movies data from search
    func fetchSearchInMoviesData(query: String, page: Int, completion: @escaping () -> ()) {
        
        apiService.searchInMoviesData(query: query, page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.searchedMovies.removeAll()
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                self?.searchedMovies.append(contentsOf: listOF.movies)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
            
        }
    }
    // MARK: Get movies data from search
    func fetchSearchInMoviesDataDif(query: String, page: Int, completion: @escaping () -> ()) {
        
        apiService.searchInMoviesData(query: query, page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                self?.searchedMovies.append(contentsOf: listOF.movies)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
            
        }
    }
    
    // MARK: For get TV Ganres data
    func fetchGanresTVData() {

        apiService.getTVGanres{ [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.ganres.removeAll()
                let genres = listOF.results
                for genre in genres {
                    let id = genre.tvId
                    let name = genre.tvGenreName
                    self?.ganres[id] = name
                }
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.ganres.count))")
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.ganres))")
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    // MARK: For get Movies Ganres data
    func fetchGanresMoviesData() {

        apiService.getMovieGanres() { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.ganres.removeAll()
                let genres = listOF.results
                for genre in genres {
                    let id = genre.tvId
                    let name = genre.tvGenreName
                    self?.ganres[id] = name
                }
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.ganres.count))")
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.ganres))")
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    // MARK: Get TV data from search
    func fetchSearchInTVData(query: String, page: Int = 1, completion: @escaping () -> ()) {
        
        apiService.searchInTVData(query: query, page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.searchedTV.removeAll()
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                self?.searchedTV.append(contentsOf: listOF.result)
                print("EVERITHING IS OK WITH DATA")
                completion()
            case .failure(let error):
                print("Error procesing json data in TV: \(error)")
            }
            
        }
    }
    
    // MARK: Get TV data from search for Diffable Data Source
    func fetchSearchInTVDataDif(query: String, page: Int = 1, completion: @escaping () -> ()) {
        
        apiService.searchInTVData(query: query, page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                self?.searchedTV.append(contentsOf: listOF.result)
                print("EVERITHING IS OK WITH DATA")
                completion()
            case .failure(let error):
                print("Error procesing json data in TV: \(error)")
            }
            
        }
    }
    
    // MARK: Get total and current page count
    
    func getCurrentPage() -> Int {
        return currentPage
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    
    // MARK: Settings for movies
    
    func numberOfRowsInSection (section: Int) -> Int {
        
        return searchedMovies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return searchedMovies[indexPath.row]
    }
    
    func getSearchMoviesCount() -> Int {
        return searchedMovies.count
    }
    
    func getMoviesData() -> [Movie]  {
        return searchedMovies
    }
    
    // MARK: Settings for TV
    func rowSearchedTV (section: Int) -> Int {
        
        return searchedTV.count
    }
    
    func cellForRowAtSearchedTV (indexPath: IndexPath) -> TV {
        return searchedTV[indexPath.row]
    }
    
    func getSearchTVCount() -> Int {
        return searchedTV.count
    }
    
    func getTVData() -> [TV]  {
        return searchedTV
    }
    
    // MARK: For top rated TV Cell
    
    func getGanreName(id: Int) -> String {
        let genreName = ""
        if let name = ganres[id] {
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
