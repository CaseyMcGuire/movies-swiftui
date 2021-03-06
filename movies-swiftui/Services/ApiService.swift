//
//  ApiService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import Promises

class ApiService {
  
  private static let baseUrl = "https://api.themoviedb.org/3/"
  
  private func fetch<T: Decodable>(endpoint: String, queryStrings: [String], type: T.Type, completion: @escaping (T?, Error?) -> ()) {
    let baseUrl = ApiService.baseUrl + endpoint + "?api_key=" + Secrets.apiKey
    let queryString = queryStrings.reduce("") { acc, next in
      return acc + "&" + next
    }
    let fullUrl = baseUrl + queryString

    guard let url = URL(string: fullUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      if err != nil {
        completion(nil, err)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let searchResults = try jsonDecoder.decode(T.self, from: data)
        completion(searchResults, nil)
      } catch let jsonErr {
        completion(nil, jsonErr)
      }
      }.resume()
    
  }
  
  func fetch<T: Decodable>(endpoint: String, queryStrings: [String], type: T.Type) -> Promise<T> {
    return Promise { (resolve, reject) in
      self.fetch(endpoint: endpoint, queryStrings: queryStrings, type: type) { (data, err) in
        if err != nil {
          reject(err!)
        }
        else {
          resolve(data!)
        }
      }
    }
  }
  
  func fetch<T: Decodable>(endpoint: String, type: T.Type) -> Promise<T> {
    return fetch(endpoint: endpoint, queryStrings: [], type: type)
  }
  
}
