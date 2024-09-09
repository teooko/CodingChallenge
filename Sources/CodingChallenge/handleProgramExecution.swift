import Foundation

public func handleProgramExecution() {
  let readRemote = getUserChoice()

  // The arguments used to be parsed together with the run command, but I changed it
  // to a friendlier user interaction. 
  let (x, y, filename) = parseArguments()
  
  // I kept the option to get the data from a local file stored in CSVFiles
  switch readRemote {
    case "y":
      processRemoteData(from: filename, x: x, y: y)
    case "n":
      processLocalData(from: filename, x: x, y: y)
    default:
      print("Unexpected choice. Please restart the program.")
  }
}