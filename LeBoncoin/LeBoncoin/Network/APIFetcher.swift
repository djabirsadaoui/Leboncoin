//
//  AnnoucementFetcher.swift
//  LeBoncoin
//
//  Created by dsadaoui on 21/10/2020.
//

import Foundation

protocol APIFetchable {
    func fetchAnnoucements(completion: @escaping (Result<[Announcement],APIError>) -> Void)
    func fetchCategories(completion: @escaping (Result<[Category],APIError>) -> Void)
}

class APIFetcher: APIFetchable {
    private let session: URLSession
    static let shared = APIFetcher()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCategories(completion: @escaping (Result<[Category], APIError>) -> Void) {
        let url = API.gatigoryURL.request()
        guard let finalUrl = url else {
            completion(Result.failure(.invalidURL))
            return
        }
        self.request(with: finalUrl) { (result: Result<[Category], APIError>) in
            completion(result)
        }
    }
    func fetchAnnoucements(completion: @escaping (Result<[Announcement], APIError>) -> Void) {
        let url = API.annoucementURL.request()
        guard let finalUrl = url else {
            completion(Result.failure(.invalidURL))
            return
        }
        self.request(with: finalUrl) { (result: Result<[Announcement], APIError>) in
            completion(result)
        }
    }
}

private extension APIFetcher {
    func request<T>(with url: URL , completion: @escaping (Result<T,APIError>) -> Void) where T: Decodable {
        let taskData = self.session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.failure(.network(description: error.localizedDescription)))
                }
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(Result.failure(.invalidResponse))
                }
                return
            }
            guard let data = data, response.statusCode == 200 else {
                print("Failure response from Leboncoin: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            let result: Result<T, APIError> = decode(data)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        taskData.resume()
    }
}
