//
//  SearchService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/26.
//  Copyright © 2026 Casey McGuire. All rights reserved.
//

final class SearchService {
  
  private let apiService = ApiService()
  
  private static let endpoint = "search/movie"
  
  func searchMovies(query: String) async throws -> MovieResultList {
    let url = SearchService.endpoint
    return try await apiService.fetch(endpoint: url, queryStrings: ["query" : query], type: MovieResultList.self)
  }
  
}
