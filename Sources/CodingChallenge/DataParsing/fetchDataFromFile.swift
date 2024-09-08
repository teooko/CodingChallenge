import Foundation

func fetchDataFromFile(from filename: String) -> [Shop]? {
  let fileURL = URL(fileURLWithPath: filename)
  var data = ""

  do {
    data = try String(contentsOf: fileURL, encoding: .utf8)
  } catch {
    print("Error: \(error)")
    return nil
  }

  do {
    let shops = try extractFromCSV(data: data)
    return shops
  } catch {
    print(error.localizedDescription)
  }
  return nil
}