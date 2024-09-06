import Foundation
import FoundationNetworking

if let (x, y, filename) = parseArguments() {
    var finished = false
    
    fetchDataFromURL(from: Config.baseUrl + filename) { (result) in
      switch result {
        case .success(let data):
          var shopsDistanceDict = Dictionary<String, Double>()
          guard let shops = extractFromCSV(data: data) else {
            return
          }
          for shop in shops {
            shopsDistanceDict[shop.name] = calcDistance(from: shop, to: (x, y))
          }
          let sortedShops = shopsDistanceDict.sorted { $0.value < $1.value }
          printFirstShops(from: sortedShops)

        case .failure(let error):
            print(error)
        }
        finished = true
    }
    
    while !finished {
      RunLoop.current.run(mode: .default, before: .distantFuture)
  }
} else {
    print("Failed to parse arguments.")
}
