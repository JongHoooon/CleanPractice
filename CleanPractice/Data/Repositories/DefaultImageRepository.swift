//
//  DefaultImageRepository.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/25.
//

#warning("image 관련 통신을 꼭 View Model에서 해야할까??")

import Foundation

final class DefaultImageRepository: ImageRepository {
    
    func fetchImage(imagePath: String) async throws -> Data {
        guard let url = URL(string: imagePath) else {
            throw FetchImageError.noImageURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
