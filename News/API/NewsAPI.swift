//
//  NewsAPI.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import Foundation

struct NewsAPI {
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "pub_4543641bd2c82f1213489d39fb7f131334a9"
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func fetch(from category: Category) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURL(from: category))
    }
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
                
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
                
        switch response.statusCode {
                    
            case (200...299), (400...499):
                let apiResponse = try jsonDecoder.decode(NewsResponse.self, from: data)
                if apiResponse.status == "success" {
                    return apiResponse.results ?? []
                } else {
                    throw generateError(description: "An error occured")
                }
            default:
                throw generateError(description: "A server error occured")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsdata.io/api/1/news?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&q=\(percentEncodedString)"
        return URL(string: url)!
    }
    
    private func generateNewsURL(from category: Category) -> URL {
        var url = "https://newsdata.io/api/1/news?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
}
