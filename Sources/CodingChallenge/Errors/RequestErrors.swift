import Foundation

public enum RequestError: Error, Equatable {
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