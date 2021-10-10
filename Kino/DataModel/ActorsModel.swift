import UIKit

struct ActorsData: Decodable {
    
    let currentPage: Int
    let actors: [Actor]
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey{
        case actors = "results"
        case currentPage = "page"
        case totalPages = "total_pages"
    }
}

struct Actor: Decodable, Hashable, Equatable, Identifiable {
    
    let id = UUID()
    
    let idAct: Int
    let name: String
    let photoPath: String?

    
    private enum CodingKeys: String, CodingKey{
        case idAct = "id"
        case name = "name"
        case photoPath = "profile_path"
    }
}


