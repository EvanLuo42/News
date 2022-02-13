//
//  Article.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article {
    let id = UUID()
    
    let title: String
    let creator: String?
    let image_url: String?
    let description: String?
    let pubDate: String
    let source_id: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case pubDate
        case creator
        case description
        case image_url
        case source_id
        case link
    }
    
    var authorText: String {
        creator ?? ""
    }
        
    var descriptionText: String {
        description ?? ""
    }
        
    var captionText: String {
        "\(source_id) ‧ \(pubDate)"
    }
    
    var articleURL: URL {
        URL(string: link)!
    }
        
    var imageURL: URL? {
        guard let image_url = image_url else {
            return nil
        }
        
        return URL(string: image_url)
    }
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {}

extension Article {
    
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsResponse.self, from: data)
        return apiResponse.results ?? []
    }
}
