//
//  MovieInfoRow.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/12/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MovieInfoRow: View {
  var rating: String?
  var releasedate: String?
  var language: String?
  
  var body: some View {
    GeometryReader { metrics in
      HStack {
        Text(self.rating!)
          .frame(width: metrics.size.width * 0.33)
        Text(self.releasedate!)
          .frame(width: metrics.size.width * 0.33)
        Text(self.language!)
          .frame(width: metrics.size.width * 0.33)
        
      }
      
    }
  }
}

struct MovieInfoRow_Previews: PreviewProvider {
  static var previews: some View {
    MovieInfoRow(rating: "8.2", releasedate: "March 15, 2021", language: "English")
  }
}
