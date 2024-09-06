import Foundation
import FoundationNetworking

func fetchDataFromURL(from urlString: String, completion: @escaping (Result<[Shop], Error>) -> Void){
    guard let url = URL(string: urlString) else {
        
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data, let string = String(data: data, encoding: .utf8) else {
            print("Unable to decode data")
            return
        }
        if let shops = extractFromCSV(data: string) {
            completion(.success(shops));
        } 
    }

    task.resume()
}