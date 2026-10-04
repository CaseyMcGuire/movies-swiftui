//
//  MoviePosterScroll.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/25/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MoviePosterScroll : View {
  var movies: [MoviePosterData]
  
  var body: some View {
    
    VStack(alignment: .leading) {

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(movies, id: \.id) { item in
            NavigationLink(destination: MovieScreen(movieId: item.id)) {
              VStack(alignment: .leading){
                MoviePoster(backdropPath: item.path, title: item.title)
              }
            }
            .buttonStyle(PlainButtonStyle())
          }
        }
      }
    }.padding(4)
  }
}

struct MoviePosterData {
  let id: Int
  let path: String?
  let title: String?
}


#Preview {
  MoviePosterScroll(movies: [MoviePosterData(id: 1, path: "/6KErczPBROQty7QoIsaa6wJYXZi.jpg", title: "Tom and Jerry asdfasjldfjasdlfajsfals;dfjasdlfjdl")])
}
