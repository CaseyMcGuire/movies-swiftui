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
      let movies: Array<Array<MoviePosterData>> = [popular, trending, upcoming, nowPlaying].map { movieList in
        let movieResults = movieList.results.compactMap { $0 }
        return movieResults.map { MoviePosterData(id: $0.id, path: $0.posterPath, title: $0.title)}
          
      }
      self.loadingState = .loaded(HomeScreenDetails(popularMovies: movies[0],
                                                    trendingMovies: movies[1],
                                                    upcomingMovies: movies[2],
                                                    nowPlayingMovies: movies[3]))
    }
  }
}

struct HomeScreenDetails {
  var popularMovies: Array<MoviePosterData>
  var trendingMovies: Array<MoviePosterData>
  var upcomingMovies: Array<MoviePosterData>
  var nowPlayingMovies: Array<MoviePosterData>
}
