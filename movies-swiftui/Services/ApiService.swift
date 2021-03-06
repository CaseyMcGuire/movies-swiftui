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
  
  private func createUrl(endpoint: String, queryStrings: [String: String]) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.themoviedb.org"
    urlComponents.path = "/3/" + endpoint
    urlComponents.addQueryItems(["api_key": Secrets.apiKey])
    urlComponents.addQueryItems(queryStrings)
    let url: URL? = urlComponents.url
    return url
  }
  
  private func fetch<T: Decodable>(endpoint: String, queryStrings: [String: String], type: T.Type, completion: @escaping (T?, Error?) -> ()) {

        
    guard let url = createUrl(endpoint: endpoint, queryStrings: queryStrings) else { return }
    
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
  
  func fetch<T: Decodable>(endpoint: String, queryStrings: [String: String], type: T.Type) -> Promise<T> {
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
    return fetch(endpoint: endpoint, queryStrings: [:], type: type)
  }
}

private extension URLComponents {
  mutating func addQueryItems(_ items: [String: String]) {
    let newQueryItems = items.map { URLQueryItem(name: $0, value: $1) }
    self.queryItems = (self.queryItems ?? []) + newQueryItems
  }
}
