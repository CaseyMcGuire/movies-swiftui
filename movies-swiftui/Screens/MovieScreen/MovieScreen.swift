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
        Image(uiImage: TMDBImageUtil.createImage(imagePath: movie.backdropPath!,
                                                 imageSize: .W780)!)
          .resizable()
          .scaledToFit()
          .overlay(TintOverlay())
        
        
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
          .offset(y: -140)
          .padding(.bottom, -140)
          
          
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

struct CreditsCarousel : View {
  var cast: [MovieScreenViewModel.CastDetail]
  
  var body: some View {
    Text("Actors")
      .font(.system(size: 20))
      .fontWeight(.medium)
    
    ScrollView(.horizontal) {
      HStack {
        ForEach(self.cast, id: \.id) { result in
          VStack {
            MoviePoster(backdropPath: result.profilePath)
              .padding(.horizontal, 4)
            Text(result.name)
              .font(.system(size: 17))
              .fontWeight(.light)
          }
        }
      }
    }
  }
}


struct MovieScreen_Previews: PreviewProvider {
  static var previews: some View {
    MovieScreen(movieId: 464052)
  }
}

