//
//  MovieScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 2/5/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation

class MovieScreenViewModel: ObservableObject {

  @Published var loadingState: LoadingState<MovieResult> = .loading

  private let movieService = MovieService()
  
  func load(movieId: Int) {
    movieService.fetchMovie(id: movieId, appendToResponse: [.credits]).then { result in
      self.loadingState = .loaded(result)
    }
    .catch { err in
      self.loadingState = .error
    }
  }
}

enum LoadingState<Value> {
  case loading
  case loaded(Value)
  case error
}
