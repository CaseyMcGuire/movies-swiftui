//
//  MovieScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 2/5/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation

class MovieScreenViewModel: ObservableObject {

  @Published var loadingState: LoadingState<MovieDetails> = .loading

  private let movieService = MovieService()
  
  func load(movieId: Int) {
    movieService.fetchMovie(id: movieId, appendToResponse: [.credits]).then { result in
      self.loadingState = .loaded(self.parse(result))
    }
    .catch { err in
      self.loadingState = .error
    }
  }
  
  private func parse(_ result: MovieResult) -> MovieDetails {
    return MovieDetails(result: result)
  }

  struct MovieDetails {
    let result: MovieResult
    
    var title: String {
      get {
        result.title
      }
    }
    
    var backdropPath: String? {
      get {
        result.backdropPath
      }
    }
    
    var posterPath: String? {
      get {
        result.posterPath
      }
    }
    
    var tagline: String? {
      get {
        result.tagline
      }
    }
    
    var overviewText: String? {
      get {
        result.overview
      }
    }
    
    var castMembers: [CastDetail] {
      get {
        guard let cast = result.credits?.cast else {
          return []
        }
        let castDetails: [CastDetail?] = cast.map { actor in
          guard let id = actor.id, let name = actor.name else {
            return nil
          }
          return CastDetail(id: id, name: name, characterName: actor.character, profilePath: actor.profilePath)
        }
        return castDetails[...6]
          .compactMap { $0 }// to filter nulls
      }
    }
  }
  
  struct CastDetail {
    let id: Int
    let name: String
    let characterName: String?
    let profilePath: String?
  }
}



enum LoadingState<Value> {
  case loading
  case loaded(Value)
  case error
}
