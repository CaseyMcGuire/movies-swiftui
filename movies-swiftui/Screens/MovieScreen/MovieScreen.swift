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
    switch movieViewModel.loadingState {
    case .loading:
      ProgressView()
        .onAppear {
          movieViewModel.load(movieId: self.movieId)
        }
        .navigationBarTitleDisplayMode(.inline)
    case .loaded(let movieDetails):
      MovieDetailScreen(movie: movieDetails)
        .navigationBarTitleDisplayMode(.inline)
    case .error:
      Text("error")
    }
  }
}

struct MovieDetailScreen : View {
  var movie: MovieScreenViewModel.MovieDetails
  
  var body: some View {
    ScrollView{
      VStack(alignment: .leading, spacing: 4) {
        let backdropImage =  TMDBImageUtil.createImageMaybe(imagePath: movie.backdropPath, imageSize: .W780)
        if let backdropImage = backdropImage {
          Image(uiImage: backdropImage)
            .resizable()
            .scaledToFit()
            .overlay(TintOverlay())
        }
        
        
        VStack(alignment: .leading) {
          HStack {
            MoviePoster(backdropPath: movie.posterPath)
            Spacer()
            VStack {
              Text(String(self.movie.title))
                .font(.headline)
              if let tagline = movie.tagline {
                Text(String(tagline))
                  .font(.subheadline)
              }
            }
            Spacer()
          }
          .offset(y: backdropImage != nil ? -140 : 0)
          .padding(.bottom, backdropImage != nil ? -140 : 0)
//          MovieInfoRow()
          HStack {
            VStack(alignment: .leading) {
              Text("Overview")
                .font(.system(size: 20))
                .fontWeight(.medium)
                .padding(.bottom, 1)
              
              if let overviewText = self.movie.overviewText {
                Text(overviewText)
                  .fontWeight(.light)
                  .font(.subheadline)
              }
            }
            
            Spacer()
          }.padding(.vertical, 12)
          CreditsCarousel(cast: self.movie.castMembers)
          Spacer()
        }.padding(10)
      }
    }
  }
}

struct MovieScreen_Previews: PreviewProvider {
  static var previews: some View {
    MovieScreen(movieId: 464052)
  }
}

