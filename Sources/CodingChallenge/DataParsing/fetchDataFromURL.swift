import Foundation

import FoundationNetworking

public func fetchDataFromURL(
  from urlString: String,
  session: URLSession = URLSession.shared,
  completion: @escaping (Result<[Shop], RequestError>) -> Void
) {
  guard let url = URL(string: urlString) else {
    completion(.failure(.invalidURL))
    return
  }

  let task = session.dataTask(with: url) { data, response, error in
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