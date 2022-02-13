//
//  NewsResponse.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import Foundation

struct NewsResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let results: [Article]?
    let nextPage: Int
}
