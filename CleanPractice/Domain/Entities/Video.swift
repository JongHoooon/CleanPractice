//
//  Video.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

struct Video {
    let id: Int
    let posterPath: String
    let title: String
    let voteAverage: Double
    let releaseDate: String
}

struct VideosPage {
    let page: Int
    let totalPages: Int
    let videos: [Video]
}
