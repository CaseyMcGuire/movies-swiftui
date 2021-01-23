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
  private let viewModel = HomeScreenViewModel()
  
  @State private var popularMovies = [MovieResult]()
  @State private var trendingMovies = [MovieResult]()
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          MoviePosterScroll(movies: popularMovies)
          MoviePosterScroll(movies: trendingMovies)
          Spacer()
        }

      }
    }
    .onAppear(perform: load)
      
  }
  
  
  func load() {
    all(
      movieService.fetchPopular(),
      movieService.fetchTrending(),
      movieService.fetchUpcoming(),
      movieService.fetchNowPlaying()
    ).then { popular, trending, upcoming, nowPlaying in
      self.popularMovies = popular.results
      self.trendingMovies = trending.results
    }
  }
}

struct MoviePosterScroll : View {
  var movies: [MovieResult]
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Text("Popular").font(.title)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(movies, id: \.id) { item in
            NavigationLink(destination: MovieScreen(movieId: item.id)) {
              Image(uiImage: TMDBImageUtil.createImage(imagePath: item.posterPath!, imageSize: .W92)!)
            }
            .buttonStyle(PlainButtonStyle())
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
