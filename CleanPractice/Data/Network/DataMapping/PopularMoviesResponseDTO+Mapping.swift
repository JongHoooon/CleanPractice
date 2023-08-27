//
//  PopularMoviesResponseDTO.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

#warning("DTO가 꼭 필요할까??")
struct PopularMoviesResponseDTO: Decodable {
    let page: Int
    let videoDTOs: [VideoDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case videoDTOs = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct VideoDTO: Decodable {
        let adult: Bool?
        let backdropPath: String?
        let genreIDS: [Int]?
        let id: Int
        let originalLanguage: String
        let originalTitle, overview: String?
        let popularity: Double?
        let posterPath, releaseDate, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

// MARK: - Mapping to Domain

extension PopularMoviesResponseDTO {
    func toDomain() -> VideosPage {
        return VideosPage(
            page: page,
            totalPages: totalPages,
            videos: videoDTOs.compactMap { $0.toDomain() }
        )
    }
}

extension PopularMoviesResponseDTO.VideoDTO {
    func toDomain() -> Video {
        return Video(
            id: id,
            posterPath: getImageURL(path: posterPath),
            title: title,
            voteAverage: voteAverage,
            releaseDate: tranformDateFormat(date: releaseDate)
        )
    }
}


// MARK: - Private

private extension PopularMoviesResponseDTO.VideoDTO {
    
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
