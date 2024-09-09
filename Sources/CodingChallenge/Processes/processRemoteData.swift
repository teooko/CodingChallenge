import Foundation

public func processRemoteData(from filename: String, x: Double, y: Double) {
  // The semaphore is being used to keep the program from exiting before the data
  // is received. It is a good fit because of the thread that starts in the fetchDataFromURL function.
  // An alternative solution is to just use async/await, but due to the lack of support for URLSession.shared.data
  // on Windows, I had to use this method.
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