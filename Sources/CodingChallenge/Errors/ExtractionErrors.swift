import Foundation

public enum ExtractionError: Error, Equatable {
  case invalidCoordinate(Int, Character)
  case invalidEntry(Int)
}

extension ExtractionError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidCoordinate(let row, let coordinate):
      let format = NSLocalizedString(
        "Invalid %@ coordinate in row %@", 
        comment: ""
        )
      return String(format: format, String(coordinate), String(row))
    case .invalidEntry(let row):
      let format = NSLocalizedString(
        "The entry in row %@ is invalid",
        comment: ""
        )
      return String(format: format, String(row))
    }
  }
}