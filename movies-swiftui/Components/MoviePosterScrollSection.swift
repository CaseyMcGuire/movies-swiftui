//
//  MoviePosterScrollSection.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/22/22.
//  Copyright © 2022 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MoviePosterScrollSection: View {
  var title: String
  var movies: [MoviePosterData]
  
    var body: some View {
      VStack(alignment: .leading) {
        Text(title)
          .font(.title)
          .fontWeight(.bold)
        MoviePosterScroll(movies: movies)
      }
    }
}

/*struct MoviePosterScrollSection_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterScrollSection()
    }
}*/
