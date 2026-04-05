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
    let backdropURL: URL? = backdropPath.flatMap { TMDBImageUtil.imageURL(imagePath: $0, imageSize: .W780) }
    VStack {
      if let backdropURL = backdropURL {
        AsyncImage(url: backdropURL) { image in
          image
            .resizable()
            .scaledToFit()
            .overlay(TintOverlay())
            .clipped()
        } placeholder: {
          Rectangle()
            .fill(Color.gray)
            .aspectRatio(16/9, contentMode: .fit)
        }
      }

      let offset: CGFloat = backdropURL != nil ? -140 : 0
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
      PictureScreenHeader(backdropPath: "/cgoy7t5Ve075naBPcewZrc08qGw.jpg", imagePath: nil, title: "Dwayne Johnson", subtitle: nil, includeImage: false)

      }
    }

