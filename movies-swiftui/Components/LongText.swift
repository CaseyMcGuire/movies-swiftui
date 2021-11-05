//
//  LongText.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 11/4/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI


// https://stackoverflow.com/a/63102244/11283051
struct LongText: View {
  
  /* Indicates whether the user want to see all the text or not. */
  @State private var expanded: Bool = false
  
  /* Indicates whether the text has been truncated in its display. */
  @State private var truncated: Bool = false
  
  var text: String
  
  var lineLimit = 10
  var font: Font = .body
  var weight: Font.Weight = .black
  

  
  var body: some View {
    VStack {
      // Render the real text (which might or might not be limited)
      Text(text)
        .lineLimit(expanded ? nil : lineLimit)
        
        .background(
          
          // Render the limited text and measure its size
          Text(text)
            .lineLimit(lineLimit)
            .background(GeometryReader { displayedGeometry in
              
              // Create a ZStack with unbounded height to allow the inner Text as much
              // height as it likes, but no extra width.
              ZStack {
                
                // Render the text without restrictions and measure its size
                Text(self.text)
                  .background(GeometryReader { fullGeometry in
                    
                    // And compare the two
                    Color.clear.onAppear {
                      self.truncated = fullGeometry.size.height > displayedGeometry.size.height
                    }
                  })
              }
              .frame(height: .greatestFiniteMagnitude)
            })
            .hidden() // Hide the background
        )
        if truncated {
          HStack {
            toggleButton
            Spacer()
          }
        }

    }
  }
  
  var toggleButton: some View {
    Button(action: { self.expanded.toggle() }) {
      Text(self.expanded ? "Show less" : "Show more")
        .font(font)
        .fontWeight(weight)
        .font(.caption)
    }
  }
}

struct LongText_Previews: PreviewProvider {
    static var previews: some View {
      LongText(text: "lafjal;sdfjasldfkjasl;fjasfl;asjdf")
    }
}
