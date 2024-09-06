import Foundation

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