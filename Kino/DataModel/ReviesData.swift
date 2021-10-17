import Foundation


struct ReviewsData: Decodable {
    
    let id: Int
    let currentPage: Int
    let results: [Review]
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
            case id = "id"
            case currentPage = "page"
            case results = "results"
            case totalPages = "total_pages"
    }
}

struct Review: Decodable, Hashable, Identifiable, Equatable {
    
    let id = UUID()
    let author: String
    let content: String
    
    private enum CodingKeys: String, CodingKey {
            case author = "author"
            case content = "content"
    }
}
