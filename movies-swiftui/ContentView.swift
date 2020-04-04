//
//  ContentView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import SwiftUI
import Promises

struct ContentView: View {
  
  private let movieService = MovieService()
  
  @State private var popularMovies = [MovieResult]()
  @State private var trendingMovies = [MovieResult]()
  
  var body: some View {
    VStack(alignment: .leading) {
      MoviePosterScroll(movies: popularMovies)
      MoviePosterScroll(movies: trendingMovies)
      Spacer()
    }.onAppear(perform: load)
  }
  
  
  func load() {
    all(
      movieService.fetchPopular(),
      movieService.fetchTrending()
    ).then { popular, trending in
      self.popularMovies = popular.results
      self.trendingMovies = trending.results
    }
  }
}

struct MoviePosterScroll : View {
  var movies: [MovieResult]
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Popular").font(.largeTitle)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(movies, id: \.id) { item in
            Image(uiImage: TMDBImageUtil.createImage(imagePath: item.posterPath!, imageSize: .W92)!)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
