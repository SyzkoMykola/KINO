import Foundation
import UIKit
struct Genres: Codable {
    let results: [Genre]
    
    private enum CodingKeys: String, CodingKey{
        case results = "genres"
    }
}
struct Genre: Codable, Hashable, Identifiable, Equatable {
    let id = UUID()
    
    let tvId: Int
    let tvGenreName: String
    
    private enum CodingKeys: String, CodingKey{
        case tvId = "id"
        case tvGenreName = "name"
    }
}
