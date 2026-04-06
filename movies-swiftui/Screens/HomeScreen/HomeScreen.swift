//
//  ContentView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {

  @State private var viewModel = HomeScreenViewModel()

  var body: some View {
    LoadableView(viewModel: viewModel) { details in
      HomeScreenView(details: details)
    }
    .task {
      await viewModel.load()
    }
  }
}

struct HomeScreenView: View {
  var details: HomeScreenDetails
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          if let mostPopularMovie = details.mostPopularMovie {
            PictureScreenHeader(backdropPath: mostPopularMovie.backdropPath, imagePath: nil, title: mostPopularMovie.title, subtitle: nil, includeImage: false)
          }
          MoviePosterScrollSection(title: "Upcoming", movies:
              details.upcomingMovies)
          MoviePosterScrollSection(title: "Popular", movies: details.popularMovies)
          MoviePosterScrollSection(title: "Trending", movies: details.trendingMovies)
          MoviePosterScrollSection(title: "Now Playing", movies: details.nowPlayingMovies)
         Spacer()
        }

      }
      .navigationTitle("Movies")
    }
  }
}





struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
  }
}
