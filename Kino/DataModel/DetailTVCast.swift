import Foundation

struct TVDetailCast: Decodable {
    let cast: [TVDetailActor]
    private enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
}

struct TVDetailActor: Decodable {
    
    let idActor: Int
    let name: String
    let photoPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case idActor = "id"
        case name = "name"
        case photoPath = "profile_path"
    }
}
