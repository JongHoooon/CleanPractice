//
//  ImageSpace.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import UIKit

enum ImageSpace {
    enum Placeholer {
        static let popcornImage = UIImage(systemName: "popcorn.fill")?
            .withTintColor(
                .systemGray,
                renderingMode: .alwaysOriginal
            )
    }
    enum Icon {
        static let chevronLeft = UIImage(systemName: "chevron.backward")        
    }
}
