import Foundation

public func handleProgramExecution() {
  let readRemote = getUserChoice()

  let (x, y, filename) = parseArguments()

  switch readRemote {
    case "y":
      processRemoteData(from: filename, x: x, y: y)
    case "n":
      processLocalData(from: filename, x: x, y: y)
    default:
      print("Unexpected choice. Please restart the program.")
  }
}