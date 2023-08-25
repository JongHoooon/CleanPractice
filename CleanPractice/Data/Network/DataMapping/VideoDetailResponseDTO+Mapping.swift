//
//  VideoDetailResponseDTO+Mapping.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

struct VideoDetailResponseDTO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [GenreDTO]?
    let homepage: String?
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    struct GenreDTO: Codable {
        let id: Int
        let name: String
    }
}

// MARK: - Mapping to Domain
extension VideoDetailResponseDTO {
    func toDomain() -> VideoDetail {
        return VideoDetail(
            id: id,
            backdropPath: getImageURL(path: backdropPath),
            posterPath: getImageURL(path: posterPath),
            genres: genres?.compactMap { $0.name },
            title: title,
            overView: overview,
            runtime: runtime,
            voteAverage: voteAverage,
            releaseDate: tranformDateFormat(date: releaseDate)
        )
    }
}

// MARK: - Private
private extension VideoDetailResponseDTO {
    
    func getImageURL(path: String?) -> String {
        guard let path = path else { return "" }
        
        return Endpoint.imageBaseURL + path
    }
    
    func tranformDateFormat(date: String?) -> String {
        guard let date = date else { return "" }
        
        let dateSplits = date.split(separator: "-")
        let year = dateSplits[0]
        let month = dateSplits[1]
        let day = dateSplits[2]
        return [
            month,
            day,
            year
        ].map { String($0 ?? "") }
            .joined(separator: "/")
    }
}
