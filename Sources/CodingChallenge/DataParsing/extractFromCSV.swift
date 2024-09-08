import Foundation

// Extract the specific shop fields from the data string

public func extractFromCSV(data: String) throws -> [Shop] {
  var shops = [Shop]()
  let rows = data.components(separatedBy: "\n")

  for (index, row) in rows.enumerated() {
    let columns = row.components(separatedBy: ",")

    if columns.count == 3 {
      let name = columns[0]
      guard let coordX = Double(columns[1]) else {
        throw ExtractionError.invalidCoordinate(index, "X")
      }
      guard let coordY = Double(columns[2]) else {
        throw ExtractionError.invalidCoordinate(index, "Y")
      }
      let shop = Shop(name: name, coordX: coordX, coordY: coordY)
      shops.append(shop)
    } else {
      throw ExtractionError.invalidEntry(index)
    }
  }
  return shops
}

public enum ExtractionError: Error {
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