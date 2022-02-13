//
//  Category.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import Foundation

enum Category: String, CaseIterable {
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    case environment
    case food
    case politics
    case top
    case world
    
    var text: String {
        if self == .top {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
