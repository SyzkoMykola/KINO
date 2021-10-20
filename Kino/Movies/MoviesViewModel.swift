import Foundation
import UIKit

class MoviesViewModel {
    
    private var apiService = ApiService()
    
    private var popularMovie = [Movie]()
    private var topRatedMovie = [Movie]()
    private var uncomingMovie = [Movie]()
    
    private var allMovies = [MoviesData]()
    
    private var currentPage = 1
    private var totalPages = 1
    
    
    //    MARK: Fetch for all movies data
    func fetchAllMoviesData(completion: @escaping () -> ()) {

        apiService.searchForAllMoviesData { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.popularMovie.removeAll()
                self?.topRatedMovie.removeAll()
                self?.uncomingMovie.removeAll()
                self?.popularMovie = listOF[0]
                self?.topRatedMovie = listOF[1]
                self?.uncomingMovie = listOF[2]
                completion()
            case .failure(let error):
                print("Error procesing json data in MOVIESVIEWMODEL: \(error)")
            }

        }
    }
    
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
    
    // MARK: Setings for popular tv cell
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
    
    // MARK: Setings for top tv rated cell
    func numberOfRowsInSectionTopRatedMovie (section: Int) -> Int {
        return topRatedMovie.count
    }
    
    func cellForRowAtTopRatedMovie(indexPath: IndexPath) -> Movie {
        return topRatedMovie[indexPath.row]
    }
    
    func getTopRatedMovieData() -> [Movie]  {
        return topRatedMovie
    }
    
    
    // MARK: Setings for TV on the air Cell
    
    func numberOfRowsInSectionUncomingMovie (section: Int) -> Int {
        return uncomingMovie.count
    }
    
    func cellForRowAtUncomingMovie(indexPath: IndexPath) -> Movie {
        return uncomingMovie[indexPath.row]
    }
    
    func getUncomingMovieData() -> [Movie]  {
        return uncomingMovie
    }
    
    
}
