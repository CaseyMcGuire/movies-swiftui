//
//  MoviesApp.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
          TabView {
            Tab("Home", systemImage: "house") {
              HomeScreen()
            }
            Tab("Search", systemImage: "magnifyingglass") {
              SearchScreen()
            }
          }
        }
    }
}
