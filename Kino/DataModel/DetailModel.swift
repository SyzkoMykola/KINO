import Foundation
import UIKit

struct DetailActor: Decodable {
    let birthday: String?
    let id: Int
    let name: String
    let biography: String
    let photoPath: String?
    let birth: String?
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case biography = "biography"
        case birthday = "birthday"
        case photoPath = "profile_path"
        case birth = "place_of_birth"
    }
}
