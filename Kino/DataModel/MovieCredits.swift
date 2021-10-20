import Foundation
import UIKit

struct MovieCredits: Decodable {
    let cast: [MovieCredit]
    let id: Int
    
    
    private enum CodingKeys: String, CodingKey{
        case id, cast
    }
}

struct MovieCredit: Decodable {
    let id: Int
    let vote: Double
    let path: String?
    private enum CodingKeys: String, CodingKey{
        case id
        case vote = "vote_average"
        case path = "poster_path"
    }
}
