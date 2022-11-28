//
//  APICaller.swift
//  Netflix Movies
//
//  Created by Khanh on 18/11/2022.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.themoviedb.org"
    static let urlImage = "https://image.tmdb.org/t/p/w500/"
}

final class APICaller {
    static let shared = APICaller()
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    static var API_KEY: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "API-Keys", ofType: "plist") else {
                return "Couldn't find key"
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                return "Couldn't find key"
            }
            return value
        }
    }
    
    func getJSON<T: Codable>(urlApi: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlApi) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = MethodRequest.get.rawValue
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, RequestError.badResponse)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(nil, RequestError.badStatusCode(httpResponse.statusCode))
                return
            }
            
            guard let data = data else {
                completion(nil, RequestError.badData)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(results, nil)
            }
            catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
