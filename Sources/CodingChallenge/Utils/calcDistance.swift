import Foundation

// Calculate the distance from a shop to the user

func calcDistance(from shop: Shop, to user: (Double, Double)) -> Double {
  let distance = sqrt(pow(shop.coordX - user.0, 2) + pow(shop.coordY - user.1, 2))
  return Double(round(10000 * distance) / 10000)
}