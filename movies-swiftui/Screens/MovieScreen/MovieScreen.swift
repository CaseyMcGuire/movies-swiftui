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
  
  private let movieService = MovieService()

  var movieId: Int
  @State private var movie: MovieResult?
  
  var body: some View {
    if self.movie == nil {
      ProgressView().onAppear(perform: load)
    } else {
      MovieScreenLoaded(movie: self.movie!)
        .navigationBarTitleDisplayMode(.inline)

    }
  }
  
  func load() {
    movieService.fetchMovie(id: self.movieId).then { result in
      self.movie = result
    }
  }
  
}

struct MovieScreenLoaded : View {
  @State var movie: MovieResult
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
        Image(uiImage: TMDBImageUtil.createImage(imagePath: movie.backdropPath!, imageSize: .W500)!)
          .resizable()
          .scaledToFit()
      HStack {
        VStack {
          HStack {
            Image(uiImage: TMDBImageUtil.createImage(imagePath: movie.posterPath!, imageSize: .W92)!)
            Text(String(self.movie.title))
          }
          Text(String(self.movie.releaseDate!))
          Text(String(self.movie.overview))
        }
        Spacer()
      }
      Spacer()
    }//.padding(8)
  }
}

struct MovieScreen_Previews: PreviewProvider {
  static var previews: some View {
    MovieScreen(movieId: 464052)
  }
}

