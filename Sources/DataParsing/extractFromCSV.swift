import Foundation

// Extract the specific shop fields from the data string

func extractFromCSV(data: String) -> [Shop]? {
  var shops = [Shop]()
  let rows = data.components(separatedBy: "\n")

  for row in rows {
    let columns = row.components(separatedBy: ",")

    if columns.count == 3 {
      let name = columns[0]
      guard let coordX = Double(columns[1]) else {
        print("Error: Invalid coordinate X")
        return nil
      }
      guard let coordY = Double(columns[2]) else {
        print("Error: Invalid coordinate Y")
        return nil
      }
      let shop = Shop(name: name, coordX: coordX, coordY: coordY)
      shops.append(shop)
    }
  }
  return shops
}