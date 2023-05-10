//
//  API.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 03/05/2023.
//

import Foundation
import SwiftUI

enum NetworkStatus {
  case idle
  case loading
  case success
  case error
}

enum NetworkError: Error {
    case invalidResponse(response: URLResponse)
    case decodingError(error: Error)
}

struct ApiRequest {
  static func getRequest<T: Decodable>(_ url: URL) async throws -> Result<T, Error> {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200
    else {
        return .failure(NetworkError.invalidResponse(response: response))
    }

    do {
      let decoder = JSONDecoder()
      let object = try decoder.decode(T.self, from: data)
      return .success(object)
    } catch {
      return .failure(NetworkError.decodingError(error: error))
        
    }
  }
}
