//
//  ImageRepository.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/25.
//

import Foundation

protocol ImageRepository {
    func fetchImage(imagePath: String) async throws -> Data
}
