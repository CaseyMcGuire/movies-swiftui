//
//  PictureScreenHeader.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/31/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct PictureScreenHeader: View {
  var backdropPath: String?
  var imagePath: String?
  var title: String
  var subtitle: String?
  var includeImage: Bool = true
  
  var body: some View {
    VStack {
      let backdropImage =  TMDBImageUtil.createImageMaybe(imagePath: backdropPath, imageSize: .W780)
      if let backdropImage = backdropImage {
        Image(uiImage: backdropImage)
          .resizable()
          .scaledToFit()
          .overlay(TintOverlay())
          .clipped()
      }
      
      let offset: CGFloat = backdropImage != nil ? -140 : 0
      VStack(alignment: .leading) {
        VStack {
          HStack {
            if includeImage {
              MoviePoster(backdropPath: imagePath)
            }
            Spacer()
            VStack {
              Text(String(title))
                .font(.system(size: 24))
                .fontWeight(.semibold)
              
              if let subtitle = subtitle {
                Text(String(subtitle))
                  .font(.system(size: 17))
              }
            }
            Spacer()
          }
          .offset(y: offset)
          .padding(.bottom, offset)
          .padding(.horizontal)
        }
      }
    }
  }
}

enum PictureScreenPlaceholder {
  case grey
  case none
}

struct PictureScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
      PictureScreenHeader(backdropPath: "/sGMA6pA2D6X0gun49igJT3piHs3.jpg", imagePath: nil, title: "Tom Hardy", subtitle: nil, includeImage: false)
    }
}
