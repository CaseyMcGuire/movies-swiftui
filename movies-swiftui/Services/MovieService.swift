//
//  MovieService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import Promises

class MovieService {
  
  private static let endpoint = "movie/"
  
  let apiService = ApiService()
  
  func fetchMovie(id: Int, appendToResponse: [MovieAppendToResponse] = []) -> Promise<MovieResult> {
    let url = MovieService.endpoint + String(id)
    var appendToResponse = appendToResponse.isEmpty ? "" : appendToResponse.reduce("") { acc, next in
      acc + "," + next.rawValue
    }
    if !appendToResponse.isEmpty {
      appendToResponse = "append_to_response=" + String(appendToResponse.dropFirst())
    }
    return apiService.fetch(endpoint: url, queryStrings: [appendToResponse], type: MovieResult.self)
  }
  
  func fetchPopular() -> Promise<MovieResultList> {
    let url = MovieService.endpoint + MovieCollectionType.POPULAR.rawValue
    return apiService.fetch(endpoint: url, type: MovieResultList.self)
  }
  
  func fetchTrending() -> Promise<MovieResultList> {
    let url = MovieCollectionType.TRENDING.rawValue
    return apiService.fetch(endpoint: url, type: MovieResultList.self)
  }
  
  func fetchUpcoming() -> Promise<MovieResultList> {
    let url = MovieService.endpoint + MovieCollectionType.UPCOMING.rawValue
    return apiService.fetch(endpoint: url, type: MovieResultList.self)
  }
  
  func fetchNowPlaying() -> Promise<MovieResultList> {
    let url = MovieService.endpoint + MovieCollectionType.NOW_PLAYING.rawValue
    return apiService.fetch(endpoint: url, type: MovieResultList.self)
  }
}

enum MovieCollectionType: String {
  case
    NOW_PLAYING = "now_playing",
    POPULAR = "popular",
    TRENDING = "trending/movie/day",
    UPCOMING = "upcoming"

}


enum MovieAppendToResponse: String {
  case credits = "credits"
}
