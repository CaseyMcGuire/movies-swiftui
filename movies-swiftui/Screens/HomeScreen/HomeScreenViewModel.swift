//
//  HomeScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation

@MainActor
final class HomeScreenViewModel: LoadableViewModel<HomeScreenDetails> {
  private let movieService = MovieService()

  func load() async {
    state = .loading
    do {
      async let popular = movieService.fetchPopular()
      async let trending = movieService.fetchTrending()
      async let upcoming = movieService.fetchUpcoming()
      async let nowPlaying = movieService.fetchNowPlaying()
      
      let popularResults = try await popular
      let trendingResults = try await trending
      let upcomingResults = try await upcoming
      let nowPlayingResults = try await nowPlaying
      let movies: [Array<MoviePosterData>] = [popularResults, trendingResults, upcomingResults, nowPlayingResults].map { movieList in
        let movieResults = movieList.results.compactMap { $0 }
        return movieResults.map { MoviePosterData(id: $0.id, path: $0.posterPath, title: $0.title)}
      }
      let mostPopularMovie = popularResults.results.compactMap { $0 }.first
      state = .loaded(HomeScreenDetails(mostPopularMovie: mostPopularMovie,
                                        popularMovies: movies[0],
                                        trendingMovies: movies[1],
                                        upcomingMovies: movies[2],
                                        nowPlayingMovies: movies[3]))
    } catch {
      state = .error
    }
  }
}

struct HomeScreenDetails {
  var mostPopularMovie: MovieResult?
  var popularMovies: Array<MoviePosterData>
  var trendingMovies: Array<MoviePosterData>
  var upcomingMovies: Array<MoviePosterData>
  var nowPlayingMovies: Array<MoviePosterData>
}
