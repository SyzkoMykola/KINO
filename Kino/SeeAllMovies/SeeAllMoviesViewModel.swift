import Foundation
import UIKit

class SeeAllMoviesViewModel {
    
    private var apiService = ApiService()
    private var popularMovie = [Movie]()
    private var topRatedMovie = [Movie]()
    private var uncomingMovie = [Movie]()
    private var movieGanres = [Int: String]()
    
    private var currentPage = 0
    private var totalPages = 1
    
    // MARK: func to get current page and totalPages
    func getCurrentPage() -> Int{
        return currentPage
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    
    // MARK: For get Movies Ganres data
    func fetchGanresMoviesData() {

        apiService.getMovieGanres() { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.movieGanres.removeAll()
                let movieGanres = listOF.results
                for genre in movieGanres {
                    let id = genre.tvId
                    let name = genre.tvGenreName
                    self?.movieGanres[id] = name
                }
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.movieGanres.count))")
                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.movieGanres))")
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    //MARK: For popular movies data
    func fetchPopularMoviesData(page: Int, completion: @escaping () -> ()) {

        apiService.getPopularMoviesData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                print("CURRENT PAGE FROM REQUEST: \(String(describing: self?.currentPage))")
                print("TOTAL PAGES  FROM REQUEST: \(String(describing: self?.totalPages))")
                self?.popularMovie.append(contentsOf: listOF.movies)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //MARK: For top rated movies data
    func fetchTopRatedMoviesData(page: Int, completion: @escaping () -> ()) {

        apiService.getTopRayedMoviesData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                print("CURRENT PAGE FROM REQUEST: \(String(describing: self?.currentPage))")
                print("TOTAL PAGES  FROM REQUEST: \(String(describing: self?.totalPages))")
                self?.topRatedMovie.append(contentsOf: listOF.movies)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //MARK: For uncoming movies data
    func fetchUncomingMoviesData(page: Int, completion: @escaping () -> ()) {

        apiService.getUncomingMoviesData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                print("CURRENT PAGE FROM REQUEST: \(String(describing: self?.currentPage))")
                print("TOTAL PAGES  FROM REQUEST: \(String(describing: self?.totalPages))")
                self?.uncomingMovie.append(contentsOf: listOF.movies)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //    MARK: Fetch for all movies data
    func fetchAllMoviesData(page: Int, completion: @escaping () -> ()) {

        apiService.searchForAllMoviesData(page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.currentPage += 1
                self?.popularMovie = listOF[0]
                self?.topRatedMovie = listOF[1]
                self?.uncomingMovie = listOF[2]
                completion()
            case .failure(let error):
                print("Error procesing json data in MOVIESVIEWMODEL: \(error)")
            }

        }
    }
    
    // MARK: Setings for popular movie cell
    func numberOfRowsInSectionPopularMovie (section: Int) -> Int {
        return popularMovie.count
    }
    
    func cellForRowAtPopularMovie(indexPath: IndexPath) -> Movie {
        return popularMovie[indexPath.row]
    }
    
    func getPopularMovieData() -> [Movie] {
        return popularMovie
    }
    
    func getPopularMovieCount() -> Int {
        return popularMovie.count
    }
    
    // MARK: Setings for top  rated movie cell
    func numberOfRowsInSectionTopRatedMovie (section: Int) -> Int {
        return topRatedMovie.count
    }
    
    func cellForRowAtTopRatedMovie(indexPath: IndexPath) -> Movie {
        return topRatedMovie[indexPath.row]
    }
    
    func getTopRatedMovieData() -> [Movie]  {
        return topRatedMovie
    }
    
    func getTopRatedMovieCount() -> Int {
        return topRatedMovie.count
    }
    
    
    // MARK: Setings for Uncoming Movie Cell
    
    func numberOfRowsInSectionUncomingMovie (section: Int) -> Int {
        return uncomingMovie.count
    }
    
    func cellForRowAtUncomingMovie(indexPath: IndexPath) -> Movie {
        return uncomingMovie[indexPath.row]
    }
    
    func getUncomingMovieData() -> [Movie]  {
        return uncomingMovie
    }
    
    func getUncomingMovieCount() -> Int {
        return uncomingMovie.count
    }
    
    // MARK: Settings for ganres 
    func getGanreName(id: Int) -> String {
        let genreName = ""
        if let name = movieGanres[id] {
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
