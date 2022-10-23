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
  
  @ObservedObject var viewModel = HomeScreenViewModel()
  
  var body: some View {
    switch self.viewModel.loadingState {
    case .loading:
      ProgressView().onAppear(perform: load)
    case .error:
      Text("error")
    case .loaded(let details):
      HomeScreenView(details: details)
    }
  }
  
  func load() {
    viewModel.load()
  }
}

struct HomeScreenView: View {
  var details: HomeScreenDetails
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          if let mostPopularMovie = details.mostPopularMovie {
            PictureScreenHeader(backdropPath: mostPopularMovie.backdropPath, imagePath: nil, title: mostPopularMovie.title, subtitle: nil, includeImage: false)
          }
          MoviePosterScrollSection(title: "Popular", movies: details.popularMovies)
          MoviePosterScrollSection(title: "Trending", movies: details.trendingMovies)
          MoviePosterScrollSection(title: "Upcoming", movies: details.upcomingMovies)
         Spacer()
        }

      }
      .navigationTitle("Movies")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}





struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
