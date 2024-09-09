import Foundation

public func handleProgramExecution() {
    let (x, y, filename) = parseArguments() 
    let semaphore = DispatchSemaphore(value: 0)

    fetchDataFromURL(from: Config.baseUrl + filename) { (result) in
      switch result {
      case .success(let shops):

        let sortedShops = sortShopsByDistance(shops: shops, userCoords: (x, y))
        printFirstShops(from: sortedShops)

      case .failure(let error):
        print(error.localizedDescription)
      }
      semaphore.signal()
    }

    semaphore.wait()
}