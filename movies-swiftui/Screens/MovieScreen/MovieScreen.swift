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
        .navigationBarTitleDisplayMode(.inline)
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
          .overlay(TintOverlay())
      HStack {
        Image(uiImage: TMDBImageUtil.createImage(imagePath: movie.posterPath!, imageSize: .W154)!)

        Text(String(self.movie.title))
      }.offset(y: -130)
       .padding(.bottom, -130)
      HStack {
        VStack {

          Text(String(self.movie.releaseDate!))
          Text(String(self.movie.overview))
        }
        Spacer()
      }
      Spacer()
    }
}
}

// https://www.codebales.com/swiftui-background-image-with-gradient-tint
struct TintOverlay: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    let color = self.colorScheme == .dark ? Color.black : Color.white
    ZStack {
      Text(" ")
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(LinearGradient(gradient: Gradient(colors: [color.opacity(0.1), color]), startPoint: .top, endPoint: .bottom))
  }
}

struct MovieScreen_Previews: PreviewProvider {
  static var previews: some View {
    MovieScreen(movieId: 464052)
  }
}

