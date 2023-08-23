//
//  Reusable.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import Foundation
import UIKit

protocol ReusableProtocol {}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {}
