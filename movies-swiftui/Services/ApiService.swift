//
//  ApiService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import Promises
import Alamofire

class ApiService {
  
  private static let baseUrl = "https://api.themoviedb.org/3/"
  
  private func fetch2<T: Decodable>(endpoint: String, queryStrings: [String: String], type: T.Type, completion: @escaping (T?, Error?) -> ()) {
    let dict = ["api_key": Secrets.apiKey].merging(queryStrings) { (current, _) in current }
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    AF.request(ApiService.baseUrl + endpoint, parameters: dict)
      .responseDecodable(of: T.self, decoder: jsonDecoder) { response in
       completion(response.value, response.error)
    }
  }
  
  func fetch<T: Decodable>(endpoint: String, queryStrings: [String: String], type: T.Type) -> Promise<T> {
    return Promise { (resolve, reject) in
      self.fetch2(endpoint: endpoint, queryStrings: queryStrings, type: type) { (data, err) in
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
