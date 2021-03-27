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
            Text("Popular")
              .font(.title)
              .fontWeight(.bold)
            MoviePosterScroll(movies: details.nowPlayingMovies)
            Text("Popular")
              .font(.title)
              .fontWeight(.bold)
            MoviePosterScroll(movies: details.trendingMovies)
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





struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
