//
//  TVDetailViewModel.swift
//  Kino
//
//  Created by Alina Bilonozhko on 04.05.2021.
//

import Foundation

class DetailTVViewModel {
    
    private var tv = [DetailTV]()
    private var apiService = ApiService()
    private var tvGanres = [Genre]()
    private var trailers = [Video]()
    private var cast = [TVDetailActor]()
    private var recommendedTV = [TV]()
    private var reviews = [Review]()
    
    private var currentPage = 1
    private var totalPages = 1
    private var urlYouTube = "https://www.youtube.com/watch?v="
    
    
    private var currentPageReviews = 1
    private var totalPagesReviews = 1
    
    // MARK: func to get current page and totalPages
    func getCurrentPage() -> Int{
        return currentPage
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    
    func getCurrentPageReviews() -> Int{
        return currentPageReviews
    }
    
    func getTotalPagesReviews() -> Int {
        return totalPagesReviews
    }
    
    //    MARK: Fetch for all tv data
    
    func fetchTVData(id: Int, completion: @escaping () -> ()) {

        apiService.getTVDetailData(id: id) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.tv.removeAll()
                self?.tv.append(listOF)
                print("\(String(describing: self?.tv))")
                self?.tvGanres.removeAll()
                self?.tvGanres = listOF.ganres
                self?.trailers.removeAll()
                guard let videos = listOF.videos.results else {
                    self?.trailers = []
                    return}
                self?.trailers = videos
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //    MARK: Fetch for all tv data
    func fetchCastData(id: Int, completion: @escaping () -> ()) {

        apiService.getDetailTVActorsData(id: id) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.cast = listOF.cast
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //    MARK: Fetch for all tv data
    func fetchRecommendedTVData(id: Int, page: Int, completion: @escaping () -> ()) {

        apiService.getRecommendedTV(id: id, page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                self?.recommendedTV = listOF.result
                self?.currentPage = listOF.currentPage
                self?.totalPages = listOF.totalPages
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }

        }
    }
    
    //    MARK: Fetch for all tv data
    func fetchReviewsData(id: Int, page: Int, completion: @escaping () -> ()) {

        apiService.getReviewsTVData(id: id, page: page) { [weak self] (result) in

            switch result {
            case .success(let listOF):
                print("REVIEW LOADING SUCCESS")
                self?.reviews = listOF.results
                self?.currentPageReviews = listOF.currentPage
                self?.totalPagesReviews = listOF.totalPages
                completion()
            case .failure(let error):
                print("REVIEW LOADING ERROR")
                print("Error: \(error)")
            }

        }
    }
    
    //MARK: get tv data and settings for cell
    func numberOfRowsInSectionActor (section: Int) -> Int {
        return cast.count
    }
    
    func getCountActor() -> Int {
        return cast.count
    }
    
    func cellForRowAtActor(indexPath: IndexPath) -> TVDetailActor {
        return cast[indexPath.row]
    }
    
    func cellForRowAtTV(indexPath: IndexPath) -> TV {
        return recommendedTV[indexPath.row]
    }
    
    func getActorData() -> [TVDetailActor]  {
        return cast
    }
    
    
    func getReccomendedData() -> [TV]  {
        return recommendedTV
    }
    
    func getReviewsData() -> [Review]  {
        return reviews
    }
    
    func getReviewsCount() -> Int {
        return reviews.count
    }
    
    func numberOfRowsInSectionReviews(section: Int) -> Int  {
        return reviews.count
    }
    
    
    func numberOfRowsInSectionReccomendedTV(section: Int) -> Int  {
        return recommendedTV.count
    }
    func getReccomendedTVCount() -> Int  {
        return recommendedTV.count
    }
    
    // MARK: get youtube key for trailer
    func getYouTubeURL() -> String? {
        if trailers.count == 0 {
            return nil
        } else {
            let url = urlYouTube + "\(trailers[0].keyForYouTube)"
            return url
        }
        
    }
    
    // MARK: For get TV Ganres data
//    func fetchGanresTVData() {
//
//        apiService.getTVGanres{ [weak self] (result) in
//
//            switch result {
//            case .success(let listOF):
//
//                let genres = listOF.results
//                for genre in genres {
//                    let id = genre.tvId
//                    let name = genre.tvGenreName
//                    self?.tvGanres[id] = name
//                }
//                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.tvGanres.count))")
//                print("I HAVE GANRE DATA. NOW I HAVE \(String(describing: self?.tvGanres))")
//            case .failure(let error):
//                print("Error procesing json data: \(error)")
//            }
//
//        }
//    }
    
    func getGanreName() -> String {
        var stringGanreName = ""
        for genre in tvGanres {
            stringGanreName = "\(genre.tvGenreName)" + " "
        }
        print("I HAVE GENGE. IT IS \(stringGanreName)")
        return stringGanreName
    }
//    
//    func combineGenreName(_ idsGenre: [Int]) -> String {
//        var ganreListString = ""
//        for id in idsGenre{
//            let name = getGanreName(id: id)
//            print("I AM COMBINING YOUR NAME")
//            ganreListString = ganreListString + "\(name) "
//
//        }
//        return ganreListString
//    }
//    
    // MARK: Setings for  tv
    
    func getDetail() -> [DetailTV] {
       
        return tv
    }
    
    
}


