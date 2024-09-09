public func getUserChoice() -> Character {
    var choice: Character?
    
   repeat {
    print("Do you want to read data from a remote file? (y/n)")
    if let input = readLine(), input.count == 1, let firstChar = input.first, firstChar == "y" || firstChar == "n" {
        choice = firstChar
    } else {
        print("Invalid input. Please try again.")
    }
} while choice != "y" && choice != "n"

return choice!
}