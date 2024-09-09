
// All the functions that get executed if the user decides to use a local file

public func processLocalData(from filename: String, x: Double, y: Double) {
  if let shops = fetchDataFromFile(from: filename) {
    let sortedShops = sortShopsByDistance(shops: shops, userCoords: (x, y))
    printFirstShops(from: sortedShops)
  } else {
    print("Error fetching local data.")
  }
}