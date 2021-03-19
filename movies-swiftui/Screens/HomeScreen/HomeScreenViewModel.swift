//
//  HomeScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import Promises

class HomeScreenViewModel : ObservableObject {
  private let movieService = MovieService()
  
  @Published var loadingState: LoadingState<HomeScreenDetails> = .loading
  
  func load() {
    all(
      movieService.fetchPopular(),
      movieService.fetchTrending(),
      movieService.fetchUpcoming(),
      movieService.fetchNowPlaying()
    ).then { popular, trending, upcoming, nowPlaying in
      let movies = [popular, trending, upcoming, nowPlaying].map { movieList in
        return movieList.results.compactMap { $0 }
      }
      self.loadingState = .loaded(HomeScreenDetails(popularMovies: movies[0],
                                                    trendingMovies: movies[1],
                                                    upcomingMovies: movies[2],
                                                    nowPlayingMovies: movies[3]))
    }
  }
}

struct HomeScreenDetails {
  var popularMovies: Array<MovieResult>
  var trendingMovies: Array<MovieResult>
  var upcomingMovies: Array<MovieResult>
  var nowPlayingMovies: Array<MovieResult>
}
