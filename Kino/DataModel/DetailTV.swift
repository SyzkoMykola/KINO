import Foundation

struct DetailTV: Decodable, Equatable, Identifiable, Hashable {
    
    let id = UUID()
    
    
    let posterPath: String?
    let idTV: Int
    let name: String
    let vote: Double
    let firstAirData: String
    let ganres: [Genre]
    let overview: String
    let country: [String]
    let titleImage: String?
    let videos: VideosResults
    
    private enum CodingKeys: String, CodingKey{
        case posterPath = "poster_path"
        case idTV = "id"
        case name = "name"
        case vote = "vote_average"
        case firstAirData = "first_air_date"
        case ganres = "genres"
        case overview = "overview"
        case country = "origin_country"
        case titleImage = "backdrop_path"
        case videos = "videos"
        
    }
}

struct VideosResults: Decodable, Hashable, Identifiable, Equatable {

    let id = UUID()

    let results: [Video]?

    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }

}

struct Video: Decodable, Hashable, Equatable, Identifiable {
    
    let id = UUID()
    
    let keyForYouTube: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case keyForYouTube = "key"
        case name = "name"
    }
}
