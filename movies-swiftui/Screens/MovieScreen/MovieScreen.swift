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
  
  var movie: MovieResult
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Image(uiImage: TMDBImageUtil.createImage(imagePath: movie.backdropPath!, imageSize: .W500)!)
        .resizable()
        .scaledToFit()

      HStack {
        VStack {
          HStack {
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
    MovieScreen(movie: MovieResult(
                  backdropPath: "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
                  id: 1,
                  posterPath: "/4VlXER3FImHeFuUjBShFamhIp9M.jpg",
                  overview: "My Overview",
                  title: "Title",
                  adult: false,
                  budget: 10000,
                  genres: [],
                  homePage: "http://google.com",
                  imdbId: "1",
                  originalLanguage: "English",
                  originalTitle: "Original Title",
                  popularity: 30,
                  status: nil,
                  tagline: "Tagline",
                  video: false,
                  voteAverage: 0.0,
                  voteCount: 1,
                  releaseDate: "2020-04-24"))
  }
}

