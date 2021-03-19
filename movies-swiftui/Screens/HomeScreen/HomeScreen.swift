//
//  ContentView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import SwiftUI
import Promises

struct HomeScreen: View {
  
  private let movieService = MovieService()
  @ObservedObject var viewModel = HomeScreenViewModel()
  
  var body: some View {
    switch self.viewModel.loadingState {
    case .loading:
      ProgressView().onAppear(perform: load)
    case .error:
      Text("error")
    case .loaded(let details):
      NavigationView {
        ScrollView {
          VStack(alignment: .leading) {
            MoviePosterScroll(movies: details.nowPlayingMovies, title: "Popular")
            MoviePosterScroll(movies: details.trendingMovies, title: "Trending")
            Spacer()
          }

        }
        .navigationTitle("Movies")
      }
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
  
  func load() {
    viewModel.load()
  }
}

struct MoviePosterScroll : View {
  var movies: [MovieResult]
  var title: String
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Text(self.title)
        .font(.title)
        .fontWeight(.bold)
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
    HomeScreen()
  }
}
