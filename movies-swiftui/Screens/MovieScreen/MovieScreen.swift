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
      MovieScreenImpl(movie: movieDetails)
        .navigationBarTitleDisplayMode(.inline)
    case .error:
      Text("error")
    }
  }
}

struct MovieScreenImpl : View {
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
          VStack {
            HStack {
              MoviePoster(backdropPath: movie.posterPath)
              Spacer()
              VStack {
                Text(String(self.movie.title))
                  .font(.system(size: 24))
                  .fontWeight(.semibold)

                if let tagline = movie.tagline {
                  Text(String(tagline))
                    .font(.system(size: 17))
                }
              }
              Spacer()
            }
            .offset(y: backdropImage != nil ? -140 : 0)
            .padding(.bottom, backdropImage != nil ? -140 : 0)
          }
          .padding(.bottom, 12)
          MovieInfoRow(rating: movie.rating, releaseDate: movie.releaseDate, language: movie.language)
          HStack {
            VStack(alignment: .leading) {
              Text("Overview")
                .font(.system(size: 24))
                .fontWeight(.medium)
                .padding(.bottom, 1)
              if let overviewText = self.movie.overviewText {
                Text(overviewText)
                  .fontWeight(.light)
                  .font(.system(size: 17))
              }
            }
            Spacer()
          }.padding(.bottom, 12)
          if !self.movie.castMembers.isEmpty {
            CreditsCarousel(title: "Actors", cast: self.movie.castMembers)
          }
          if let director = self.movie.director {
            CreditsCarousel(title: "Director", cast: [director])
          }
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

