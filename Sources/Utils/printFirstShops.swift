import Foundation

// Print the first 3 shops in the list

func printFirstShops(from sortedShops: [(key: String, value: Double)]) {
  print("\(sortedShops[0].key),\(sortedShops[0].value)")
  print("\(sortedShops[1].key),\(sortedShops[1].value)")
  print("\(sortedShops[2].key),\(sortedShops[2].value)")
}