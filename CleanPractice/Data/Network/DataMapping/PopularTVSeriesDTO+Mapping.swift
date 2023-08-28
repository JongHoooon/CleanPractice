//
//  PopularTVSeriesDTO+Mapping.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

struct PopularTVSeriesDTO: Decodable {
    let page: Int
    let tvSeriesDTO: [TVSeriesDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case tvSeriesDTO = "result"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct TVSeriesDTO: Decodable {
        let backdropPath: String?
        let firstAirDate: String?
        let genreIDS: [Int]?
        let id: Int
        let name: String?
        let originCountry: [String]?
        let originalLanguage, originalName, overview: String?
        let popularity: Double?
        let posterPath: String?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case firstAirDate = "first_air_date"
            case genreIDS = "genre_ids"
            case id, name
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

// MARK: - Mapping to Domain
extension PopularTVSeriesDTO.TVSeriesDTO {
    
    func toDomain() -> Video {
        return Video(
            id: id,
            posterPath: posterPath,
            title: name,
            voteAverage: voteAverage,
            releaseDate: firstAirDate
        )
    }
}

extension PopularTVSeriesDTO {
    
    func toDomain() -> VideosPage {
        return VideosPage(
            page: page,
            totalPages: totalPages,
            videos: tvSeriesDTO.map { $0.toDomain() }
        )
    }
}
