//
//  MovieService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation

class MovieService {
  
  private static let endpoint = "movie/"
  
  let apiService = ApiService()
  
  func fetchMovie(id: Int, completion: @escaping (MovieResult?, Error?) -> ()) {
    let url = MovieService.endpoint + String(id)
    apiService.fetch(endpoint: url, type: MovieResult.self, completion: completion)
  }
  
  func fetchPopular(completion: @escaping (MovieResultList?, Error?) -> ()) {
    let url = MovieService.endpoint + MovieCollectionType.POPULAR.rawValue
    apiService.fetch(endpoint: url, type: MovieResultList.self, completion: completion)
  }
  
  func fetchTrending(completion: @escaping (MovieResultList?, Error?) -> ()) {
    let url = MovieCollectionType.TRENDING.rawValue
    apiService.fetch(endpoint: url, type: MovieResultList.self, completion: completion)
  }
  
  func fetchUpcoming(completion: @escaping (MovieResultList?, Error?) -> ()) {
    let url = MovieService.endpoint + MovieCollectionType.UPCOMING.rawValue
    apiService.fetch(endpoint: url, type: MovieResultList.self, completion: completion)
  }
  
  func fetchNowPlaying(completion: @escaping (MovieResultList?, Error?) -> ()) {
    let url = MovieService.endpoint + MovieCollectionType.NOW_PLAYING.rawValue
    apiService.fetch(endpoint: url, type: MovieResultList.self, completion: completion)
  }
}

enum MovieCollectionType: String {
  case
    NOW_PLAYING = "now_playing",
    POPULAR = "popular",
    TRENDING = "trending/movie/day",
    UPCOMING = "upcoming"

}
