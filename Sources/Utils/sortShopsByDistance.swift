import Foundation

func sortShopsByDistance(shops: [Shop], userCoords: (x: Double, y: Double)) -> (
  [(key: String, value: Double)]
) {
  var shopsDistanceDict = [String: Double]()

  for shop in shops {
    shopsDistanceDict[shop.name] = calcDistance(from: shop, to: userCoords)
  }

  return shopsDistanceDict.sorted { $0.value < $1.value }
}