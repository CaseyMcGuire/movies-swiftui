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
    
    var releaseDate: String? {
      if let releaseDate = result.releaseDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: releaseDate)
        let dateFormatterPrinter = DateFormatter()
        dateFormatterPrinter.dateStyle = .medium
        dateFormatterPrinter.timeStyle = .none
        dateFormatterPrinter.locale = Locale.current
        if let date = date {
          return dateFormatterPrinter.string(from: date)
        }
        else {
          return nil
        }
      }
      else {
        return result.releaseDate
      }
    }
    
    var rating: String? {
      if let voteAverage = result.voteAverage {
        return String(voteAverage)
      }
      else {
        return nil
      }
    }
    
    var language: String? {
      if let languageCode = result.originalLanguage {
        if let language = NSLocale.current.localizedString(forLanguageCode: languageCode) {
          return language
        }
      }
      return result.originalLanguage
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
    
    var director: CastDetail? {
      guard let crew = self.result.credits?.crew else { return nil }
      let index = crew.firstIndex { result in
        result.job == "Director"
      }
      if let index = index {
        let director = crew[index]
        if let id = director.id, let name = director.name, let job = director.job {
          return CastDetail(id: id, name: name, characterName: job, profilePath: director.profilePath)
        }
      }
      return nil
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
