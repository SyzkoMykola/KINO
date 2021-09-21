import Foundation
import UIKit

class ApiService  {
    
    private var dataTask: URLSessionDataTask?

    
    // MARK: Popular actors requst
    func getPopularActorsData(page: Int = 1,  completion: @escaping (Result<ActorsData, Error>) -> Void) {
        
        let popularActorsURL = "https://api.themoviedb.org/3/person/popular?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        guard let url = URL(string: popularActorsURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ActorsData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Popular TV requst
    func getPopularTVData(page: Int = 1,  completion: @escaping (Result<TVData, Error>) -> Void) {
        let popularTVURL = "https://api.themoviedb.org/3/tv/popular?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        guard let url = URL(string: popularTVURL) else {return}
    
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
     
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
           
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
        
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TVData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    
    }
    
    // MARK: Top Rated TV requst
    func getTopRatedTVData(page: Int = 1,  completion: @escaping (Result<TVData, Error>) -> Void) {
        
        let popularTVURL = "https://api.themoviedb.org/3/tv/top_rated?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        guard let url = URL(string: popularTVURL) else {return}
      
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
         
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
           
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
            
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TVData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    
    }
    
    // MARK: TV On the air requst
    func getTVOnTheAirData(page: Int = 1,  completion: @escaping (Result<TVData, Error>) -> Void) {
        let TVOnTheAirURL = "https://api.themoviedb.org/3/tv/on_the_air?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        guard let url = URL(string:TVOnTheAirURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
         
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
           
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
            
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TVData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    
    // MARK: Search for all TV Shows
    
    func searchForAllTVShowsData (page: Int = 1,  completion: @escaping (Result<[[TV]], Error>) -> Void) {
        
        let tvOnTheAirURL = "https://api.themoviedb.org/3/tv/on_the_air?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        let tvTopRatedURL = "https://api.themoviedb.org/3/tv/top_rated?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        let popularTVURL = "https://api.themoviedb.org/3/tv/popular?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        let urls = [
            popularTVURL,
            tvTopRatedURL,
            tvOnTheAirURL
        ]
        
        var tvData = [[TV]](repeating: [TV](), count: 3)
        
        let group = DispatchGroup()
        for i in 0...(urls.count - 1){
            
            guard let url = URL(string: urls[i]) else {
                continue
            }
            
            group.enter()
            dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // Handel error
                if let error = error {
                    completion(.failure(error))
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    // Handel empty Response
                    print("Empty Response")
                 
                    return
                }
                
                print("Response status code: \(response.statusCode)")
                
                guard let data = data else {
                    // Handle empty Data
                    print("Empty Data")
                 
                    return
                }
                
                do {
                    // Parse the data
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(TVData.self, from: data)
                    tvData[i] = jsonData.result
//                    tvData.append(jsonData.result)
                        group.leave()
                 
                } catch let error {
                    completion(.failure(error))
                }
                
            }
            dataTask?.resume()
            
        }
        
        group.notify(queue: .main, execute: {
            print("I have done everything")
            completion(.success(tvData))
        })
        
    }
    
    // MARK: Search for Popular actors requst
    func searchPopularActorsData(query: String, page: Int,  completion: @escaping (Result<ActorsData, Error>) -> Void) {
        
        let popularActorsURL = "https://api.themoviedb.org/3/search/person?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&query=\(query)&page=\(page)&include_adult=false"
        
        guard let url = URL(string: popularActorsURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ActorsData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Search for Detail Popular actors requst
    func searchForActorData(id: Int,  completion: @escaping (Result<DetailActor, Error>) -> Void) {
        
        let popularActorsURL = "https://api.themoviedb.org/3/person/\(id)?api_key=a44576f6889f55561580856f29b6fe14&language=en-US"
        
        guard let url = URL(string: popularActorsURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(DetailActor.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Search to now in which movies actor play requst
    func searchForMovieCredits(id: Int,  completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        
        let popularActorsURL = "https://api.themoviedb.org/3/person/\(id)/movie_credits?api_key=a44576f6889f55561580856f29b6fe14&language=en-US"
        
        guard let url = URL(string: popularActorsURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieCredits.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get TV ganres DATA
    
    func getTVGanres(completion: @escaping (Result<Genres, Error>) -> Void) {
        let tvGanresListURL = "https://api.themoviedb.org/3/genre/tv/list?api_key=a44576f6889f55561580856f29b6fe14&language=en-US"
        
        guard let url = URL(string: tvGanresListURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Genres.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
    
    // MARK: Get Movies ganres DATA
    
    func getMovieGanres(completion: @escaping (Result<Genres, Error>) -> Void) {
        let tvGanresListURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=a44576f6889f55561580856f29b6fe14&language=en-US"
        
        guard let url = URL(string: tvGanresListURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Genres.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
    
    // MARK: Search for all Movies data
    
    func searchForAllMoviesData (page: Int = 1,  completion: @escaping (Result<[[Movie]], Error>) -> Void) {
        
        let uncomingMovieURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        let topRatedMovieURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
        
        let urls = [
            popularMovieURL,
            topRatedMovieURL,
            uncomingMovieURL
        ]
        
        var moviesData = [[Movie]](repeating: [Movie](), count: 3)
                
        let group = DispatchGroup()
        for i in 0...(urls.count - 1){
            
            guard let url = URL(string: urls[i]) else {
                continue
            }
            
            group.enter()
            dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // Handel error
                if let error = error {
                    completion(.failure(error))
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    // Handel empty Response
                    print("Empty Response")
                 
                    return
                }
                
                print("Response status code: \(response.statusCode)")
                
                guard let data = data else {
                    // Handle empty Data
                    print("Empty Data")
                 
                    return
                }
                
                do {
                    // Parse the data
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(MoviesData.self, from: data)
                    moviesData[i] = jsonData.movies
                   
//                    tvData.append(jsonData.result)
                        group.leave()
                 
                } catch let error {
                    completion(.failure(error))
                }
                
            }
            dataTask?.resume()
            
        }
        
        group.notify(queue: .main, execute: {
            print("I have done everything in MOVIES SEARCH")
            completion(.success(moviesData))
        })
    }
    
    // MARK: Search in Movies
    func searchInMoviesData(query: String, page: Int,  completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
       let searchInMoviesURL = "https://api.themoviedb.org/3/search/movie?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&query=\(query)&page=\(page)&include_adult=false"
    
        
        guard let url = URL(string: searchInMoviesURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Search in TV
    func searchInTVData(query: String, page: Int = 1,  completion: @escaping (Result<TVData, Error>) -> Void) {
        
       let searchInTVURL = "https://api.themoviedb.org/3/search/tv?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&query=\(query)&page=\(page)&include_adult=false"
    

    
        
        guard let url = URL(string: searchInTVURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TVData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get popular movies data
    func getPopularMoviesData(page: Int,  completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
       let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
    
        
        guard let url = URL(string: popularMovieURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get top rated movies data
    func getTopRayedMoviesData(page: Int,  completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let topRatedMovieURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
    
        
        guard let url = URL(string: topRatedMovieURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get uncoming movies data
    func getUncomingMoviesData(page: Int,  completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let uncomingMovieURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
    
        
        guard let url = URL(string: uncomingMovieURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get tv detail data
    func getTVDetailData(id: Int,  completion: @escaping (Result<DetailTV, Error>) -> Void) {
        
//        let uncomingMovieURL = "https://api.themoviedb.org/3/tv/\(id)?api_key=a44576f6889f55561580856f29b6fe14&language=en-US"
        let tvAndVideoURL = "https://api.themoviedb.org/3/tv/\(id)?api_key=a44576f6889f55561580856f29b6fe14&append_to_response=videos&language=en-US"
    
        
        guard let url = URL(string: tvAndVideoURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(DetailTV.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get uncoming movies data
    func getDetailTVActorsData(id: Int,  completion: @escaping (Result<TVDetailCast, Error>) -> Void) {
        
        let detailURL = "https://api.themoviedb.org/3/tv/\(id)/credits?api_key=a44576f6889f55561580856f29b6fe14&language=en-US"
    
        
        guard let url = URL(string: detailURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TVDetailCast.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get uncoming movies data
    func getRecommendedTV(id: Int, page: Int = 1,  completion: @escaping (Result<TVData, Error>) -> Void) {
        
        let recommendedTVURL = "https://api.themoviedb.org/3/tv/\(id)/recommendations?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
    
        
        guard let url = URL(string: recommendedTVURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TVData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: Get  data
    func getReviewsTVData(id: Int, page: Int = 1,  completion: @escaping (Result<ReviewsData, Error>) -> Void) {
        
        let reviesURL = "https://api.themoviedb.org/3/tv/\(id)/reviews?api_key=a44576f6889f55561580856f29b6fe14&language=en-US&page=\(page)"
    
        
        guard let url = URL(string: reviesURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handel error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handel empty Response
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ReviewsData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
}
