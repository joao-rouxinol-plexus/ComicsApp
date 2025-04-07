
import Foundation

// MARK: - EpisodesModel
struct EpisodesModel: Codable {
    let info: Informs
    let results: [Episode]
}

// MARK: - Info
struct Informs: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
