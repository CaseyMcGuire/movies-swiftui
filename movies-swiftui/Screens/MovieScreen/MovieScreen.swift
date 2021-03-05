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
  
  private let movieService = MovieService()
  var movieId: Int
  
  var body: some View {
    switch movieViewModel.loadingState {
    case .loading:
      ProgressView()
        .onAppear {
          movieViewModel.load(movieId: self.movieId)
        }
        .navigationBarTitleDisplayMode(.inline)
    case .loaded(let movieResult):
      MovieScreenLoaded(movie: movieResult)
        .navigationBarTitleDisplayMode(.inline)
    case .error:
      Text("error")
    }
  }
}

struct MovieScreenLoaded : View {
  @State var movie: MovieResult
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 4) {
      Image(uiImage: TMDBImageUtil.createImage(imagePath: movie.backdropPath!, imageSize: .W780)!)
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
            Text(String(self.movie.tagline!))
              .font(.subheadline)
          }
          Spacer()
        }.offset(y: -140)
        .padding(.bottom, -140)
        HStack {
          VStack {
            Text(String(self.movie.overview))
              .font(.subheadline)
          }
          Spacer()
        }
        Spacer()
      }.padding(10)
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

