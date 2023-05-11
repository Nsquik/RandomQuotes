//
//  API.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation
import SwiftUI

protocol Fetchable {
    associatedtype Content
    
    static var baseURL: URL { get }
    static func getRequestUrl(on: Content) throws -> URL
}



enum FetchError: Error {
    case invalidResponse(response: URLResponse)
    case decodingError(error: Error)
}

struct Fetch {
  static func getRequest<T: Decodable>(_ url: URL) async throws -> Result<T, Error> {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200
    else {
        return .failure(FetchError.invalidResponse(response: response))
    }

    do {
      let decoder = JSONDecoder()
      let object = try decoder.decode(T.self, from: data)
      return .success(object)
    } catch {
      return .failure(FetchError.decodingError(error: error))
        
    }
  }
}
