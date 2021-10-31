//
//  MovieScreen.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/4/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieScreen : View {
  
  @ObservedObject var movieViewModel = MovieScreenViewModel()
  var movieId: Int
  
  var body: some View {
    LoadableView(viewModel: movieViewModel) { data in
      MovieScreenImpl(movie: data)
    }.onAppear(perform: load)
    .navigationBarTitleDisplayMode(.inline)
  }
  
  func load() {
    movieViewModel.load(movieId: movieId)
  }
}

struct MovieScreenImpl : View {
  var movie: MovieDetails
  
  var body: some View {
    ScrollView{
      VStack {
        MovieScreenHeader(movie: self.movie)
        VStack {
          MovieInfoRow(rating: movie.rating, releaseDate: movie.releaseDate, language: movie.language)
          if let overviewText = self.movie.overviewText {
            HStack {
              TextBlock(title: "Overview", textBody: overviewText)
              
              Spacer()
            }.padding(.bottom, 12)
          }
          if !self.movie.castMembers.isEmpty {
            CreditsCarousel(title: "Actors", cast: self.movie.castMembers)
          }
          if let director = self.movie.director {
            CreditsCarousel(title: "Director", cast: [director])
          }
          if let similarMovies = self.movie.similarMovies {
            MoviePosterScroll(movies: similarMovies)
          }
          Spacer()
        }.padding(12)
      }
    }
  }
}

struct MovieScreen_Previews: PreviewProvider {
  static var previews: some View {
    MovieScreen(movieId: 464052)
  }
}
