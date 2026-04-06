//
//  ApiService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation

final class ApiService {
  
  private static let baseUrl = "https://api.themoviedb.org/3/"
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func fetch<T: Decodable>(endpoint: String, queryStrings: [String: String], type: T.Type) async throws -> T {
    let dict = ["api_key": Secrets.apiKey].merging(queryStrings) { (current, _) in current }
    guard var components = URLComponents(string: ApiService.baseUrl + endpoint) else {
      throw ApiServiceError.invalidURL
    }
    components.queryItems = dict.map { URLQueryItem(name: $0.key, value: $0.value) }
    guard let url = components.url else {
      throw ApiServiceError.invalidURL
    }
    
    let (data, response) = try await session.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw ApiServiceError.invalidResponse
    }
    guard 200..<300 ~= httpResponse.statusCode else {
      throw ApiServiceError.unsuccessfulStatusCode(httpResponse.statusCode)
    }
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return try jsonDecoder.decode(T.self, from: data)
  }
  
  func fetch<T: Decodable>(endpoint: String, type: T.Type) async throws -> T {
    try await fetch(endpoint: endpoint, queryStrings: [:], type: type)
  }
}

enum ApiServiceError: Error {
  case invalidURL
  case invalidResponse
  case unsuccessfulStatusCode(Int)
}
