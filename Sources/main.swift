import Foundation
import FoundationNetworking

if let (x, y, filename) = parseArguments() {
    let semaphore = DispatchSemaphore(value: 0)
    
    fetchDataFromURL(from: Config.baseUrl + filename) { (result) in
      switch result {
        case .success(let shops):
          var shopsDistanceDict = Dictionary<String, Double>()

          for shop in shops {
            shopsDistanceDict[shop.name] = calcDistance(from: shop, to: (x, y))
          }
          
          let sortedShops = shopsDistanceDict.sorted { $0.value < $1.value }
          printFirstShops(from: sortedShops)

        case .failure(let error):
            print(error)
        }
        semaphore.signal()
    }
    
    semaphore.wait()
} else {
    print("Failed to parse arguments.")
}
