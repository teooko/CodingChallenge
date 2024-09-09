func parseArguments() -> (Double, Double, String) {
  var coordX: Double?
  var coordY: Double?
  var file: String?

  repeat {
    print("Please introduce the X coordinate: ")
    if let userCoordX = readLine(), let x = Double(userCoordX) {
        coordX = x
    } else {
      print("Invalid coordinate X. Please try again.")
        }
    } while coordX == nil

    repeat {
        print("Please introduce the Y coordinate: ")
        if let userCoordY = readLine(), let y = Double(userCoordY) {
            coordY = y
        } else {
            print("Invalid coordinate Y. Please try again.")
        }
    } while coordY == nil

    repeat {
        print("Please introduce the file name: ")
        if let inputFile = readLine(), !inputFile.isEmpty {
            file = inputFile
        } else {
            print("Invalid file name. Please try again.")
        }
    } while file == nil

    return (coordX!, coordY!, file!)
}
