import Foundation

// Calculate the distance from a shop to the user
func calcDistance(from shop: Shop, to user: (Double, Double)) -> Double {
  let distance = sqrt(pow(shop.coordX - user.0, 2) + pow(shop.coordY - user.1, 2))
  return Double(round(10000 * distance) / 10000)
}

// Print the first 3 shops in the list
func printFirstShops(from sortedShops: [(key: String, value: Double)])
{
  print("\(sortedShops[0].key),\(sortedShops[0].value)")
  print("\(sortedShops[1].key),\(sortedShops[1].value)")
  print("\(sortedShops[2].key),\(sortedShops[2].value)")
}

// Parse the console arguments
let arguments = CommandLine.arguments

func parseArguments() -> (Double, Double, String)? {
  if arguments.count > 4 {
    print("Error: Too many arguments")
    return nil
  }
  if arguments.count < 4 {
    print("Error: Too few arguments")
    return nil
  }

  guard let userCoordX = Double(arguments[1]) else {
    print("Error: Invalid coordinate X")
    return nil
  }
  guard let userCoordY = Double(arguments[2]) else {
    print("Error: Invalid coordinate Y")
    return nil
  }
  let file = arguments[3]

  return (userCoordX, userCoordY, file)
}