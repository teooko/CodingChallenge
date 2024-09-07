import Foundation

import FoundationNetworking

func fetchDataFromURL(
  from urlString: String, completion: @escaping (Result<[Shop], ValidationError>) -> Void
) {
  guard let url = URL(string: urlString) else {
    completion(.failure(.invalidURL))
    return
  }

  let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if error != nil {
      completion(.failure(.requestFailed))
      return
    }

    guard let httpResponse = response as? HTTPURLResponse,
      (200...299).contains(httpResponse.statusCode)
    else {
      completion(.failure(.invalidResponse))
      return
    }

    guard let data = data, let string = String(data: data, encoding: .utf8) else {
      completion(.failure(.invalidResponse))
      return
    }

    guard let shops = extractFromCSV(data: string) else {
      completion(.failure(.parsingFailed))
      return
    }

    completion(.success(shops))
  }

  task.resume()
}

enum ValidationError: Error {
  case invalidURL
  case requestFailed
  case invalidResponse
  case parsingFailed
}

extension ValidationError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return NSLocalizedString(
        "The URL provided was invalid",
        comment: ""
      )
    case .requestFailed:
      return NSLocalizedString(
        "The request failed due to a network error",
        comment: ""
      )
    case .invalidResponse:
      return NSLocalizedString(
        "The server response was invalid",
        comment: ""
      )
    case .parsingFailed:
      return NSLocalizedString(
        "Failed to parse the data",
        comment: ""
      )
    }
  }
}