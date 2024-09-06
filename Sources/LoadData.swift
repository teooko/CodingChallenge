import Foundation
import FoundationNetworking

// Extract the specific shop fields from the data string
func extractDataFromCSV(data: String) -> [Shop]? {
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

func fetchDataFromURL(from urlString: String, completion: @escaping (Result<String, Error>) -> Void){
    guard let url = URL(string: urlString) else {
        
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data, let string = String(data: data, encoding: .utf8) else {
            print("Unable to decode data")
            return
        }
        completion(.success(string));
    }

    task.resume()
}


func fetchDataFromFile(from filename: String) -> [Shop]? {
  let fileURL = URL(fileURLWithPath: filename)
  var data = ""

  do {
    data = try String(contentsOf: fileURL, encoding: .utf8)
  } catch {
    print("Error: \(error)")
    return nil
  }

  return extractDataFromCSV(data: data)
}

enum NetworkError: Error {
  case URLError
  case requestError
  case unknown
}