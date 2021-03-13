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
    if popularMovies.isEmpty {
      ProgressView().onAppear(perform: load)
    }
    else {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          MoviePosterScroll(movies: popularMovies, title: "Popular")
          MoviePosterScroll(movies: trendingMovies, title: "Trending")
          Spacer()
        }

      }
      .navigationTitle("Movies")
    }
    .navigationViewStyle(StackNavigationViewStyle())


    }
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
    }.catch { err in
      print(err)
    }

  }
}

struct MoviePosterScroll : View {
  var movies: [MovieResult]
  var title: String
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Text(self.title).font(.title3)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(movies, id: \.id) { item in
            NavigationLink(destination: MovieScreen(movieId: item.id)) {
              Image(uiImage: TMDBImageUtil.createImage(imagePath: item.posterPath!, imageSize: .W300)!)
                .resizable()
                .frame(width: 100, height: 150)
                .scaledToFill()
            }
            .buttonStyle(PlainButtonStyle())
          }
        }
      }
    }.padding(4)
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
