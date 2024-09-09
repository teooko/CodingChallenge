import Foundation

public func sortShopsByDistance(shops: [Shop], userCoords: (x: Double, y: Double)) -> (
  [(key: String, value: Double)]
) {

  // I decided it would be useful to map the shop names to their distances
  // so that I can sort and display them in the console efficiently.
  var shopsDistanceDict = [String: Double]()

  for shop in shops {
    shopsDistanceDict[shop.name] = calcDistance(from: shop, to: userCoords)
  }

  // The speed with which my program runs is mostly dictated by the .sorted method. 
  // It has a time complexity of O(n log n).
  return shopsDistanceDict.sorted { $0.value < $1.value }
}