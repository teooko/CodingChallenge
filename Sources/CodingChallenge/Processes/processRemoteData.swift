import Foundation

public func processRemoteData(from filename: String, x: Double, y: Double) {
  let semaphore = DispatchSemaphore(value: 0)

  fetchDataFromURL(from: Config.baseUrl + filename) { (result) in
    switch result {
    case .success(let shops):
      let sortedShops = sortShopsByDistance(shops: shops, userCoords: (x, y))
      printFirstShops(from: sortedShops)
    case .failure(let error):
      print("Error fetching remote data: \(error.localizedDescription)")
    }
    semaphore.signal()
  }

  semaphore.wait()
}