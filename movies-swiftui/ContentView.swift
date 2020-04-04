//
//  ContentView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  private let movieService = MovieService()
  
  @State private var popularMovies = [MovieResult]()
  
  var body: some View {
    print(popularMovies)
    
    return VStack {
      MoviePosterScroll(movies: popularMovies)
    }.onAppear(perform: load)
  }
  
  
  func load() {
    movieService.fetchPopular { (list, err) in
      if list == nil {
        return
      }
      self.popularMovies = list!.results
    }
  }
}

struct MoviePosterScroll : View {
  var movies: [MovieResult]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(movies, id: \.id) { item in
          Image(uiImage: TMDBImageUtil.createImage(imagePath: item.posterPath!, imageSize: .W92)!)
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
