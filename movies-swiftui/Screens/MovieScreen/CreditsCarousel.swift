//
//  CreditsCarousel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/13/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct CreditsCarousel : View {
  var title: String
  var cast: [MovieScreenViewModel.CastDetail]
  
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(self.title)
        .font(.system(size: 24))
        .fontWeight(.medium)
      ScrollView(.horizontal) {
        HStack {
          ForEach(self.cast, id: \.id) { result in
            VStack {
              MoviePoster(backdropPath: result.profilePath, size: .medium, circle: true)
                .padding(.horizontal, 4)
              Spacer()
              Text(result.name)
                .font(.system(size: 12))
                .fontWeight(.light)
              if let characterName = result.characterName {
                Text(characterName)
                  .font(.system(size: 12))
                  .foregroundColor(.gray)
                  .multilineTextAlignment(.center)
              }
              Spacer()
            }.frame(width: 100, height: 175)
          }
        }
      }
    }
  }
}

struct CreditsCarousel_Previews: PreviewProvider {
  static var previews: some View {
    CreditsCarousel(title: "Actors", cast: [
                      .init(id: 1,
                            name: "Gad Gadot",
                            characterName: "Diana Prince / Wonder Woman",
                            profilePath: "/cG8f05QzSrLunXgEIJUEj4F3IVz.jpg"),
                      .init(id: 2,
                            name: "Chris Pine",
                            characterName: "Steve Trevor",
                            profilePath: "/ipG3BMO8Ckv9xVeEY27lzq975Qm.jpg")])
  }
}
