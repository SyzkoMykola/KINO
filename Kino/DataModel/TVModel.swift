import UIKit

struct TVData: Decodable {
    let currentPage: Int
    let result: [TV]
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case result = "results"
        case totalPages = "total_pages"
    }
    
}

struct TV: Decodable, Hashable, Identifiable, Equatable {
    let id = UUID()
    
    let posterPath: String?
    let idTV: Int
    let name: String
    let vote: Double
    let gandersID: [Int]


    private enum CodingKeys: String, CodingKey{
        case posterPath = "poster_path"
        case idTV = "id"
        case name = "name"
        case vote = "vote_average"
        case gandersID = "genre_ids"
        
    }
}
