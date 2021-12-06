import Foundation
import UIKit

struct MoviesData: Decodable {
    let currentPage: Int
    let movies: [Movie]
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey{
        case currentPage = "page"
        case movies = "results"
        case totalPages = "total_pages"
        }
}

struct Movie: Decodable, Hashable, Identifiable, Equatable {
    
    let id = UUID()
    let posterPath: String?
    let gandersID: [Int]
    let vote: Double
    let name: String
    let overview: String
    let idTV: Int
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
    case posterPath = "poster_path"
    case gandersID = "genre_ids"
    case vote = "vote_average"
    case name = "original_title"
    case overview = "overview"
    case idTV = "id"
    case releaseDate = "release_date"
        
    }
    
}


