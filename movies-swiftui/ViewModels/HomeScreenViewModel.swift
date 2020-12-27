//
//  HomeScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import Promises

class HomeScreenViewModel {
  private let movieService = MovieService()
  private let isLoading: Bool = true
  
  init() {
    all(
      movieService.fetchPopular(),
      movieService.fetchTrending(),
      movieService.fetchUpcoming(),
      movieService.fetchNowPlaying()
    ).then { popular, trending, upcoming, nowPlaying in
      
    }
  }
}
