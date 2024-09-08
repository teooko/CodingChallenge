import Foundation

import FoundationNetworking

public func fetchDataFromURL(
  from urlString: String, completion: @escaping (Result<[Shop], RequestError>) -> Void
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

    do {
      let shops = try extractFromCSV(data: string)
      completion(.success(shops))
    } catch {
      completion(.failure(.parsingFailed(error.localizedDescription)))
    }
  }
  task.resume()
}

public enum RequestError: Error {
  case invalidURL
  case requestFailed
  case invalidResponse
  case parsingFailed(String)
}

extension RequestError: LocalizedError {
  public var errorDescription: String? {
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
    case .parsingFailed(let errorText):
      return NSLocalizedString(
        "Failed to parse the data: \(errorText)",
        comment: ""
      )
    }
  }
}