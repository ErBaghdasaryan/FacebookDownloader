//
//  HomeViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppModel
import Combine

public protocol IHomeViewModel {
    func doCall<T: Decodable>(
        from urlString: String,
        httpMethod: String,
        urlParam: [String: String]?,
        responseModel: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    func addRecently(model: RecentlyModel)
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }

    public func doCall<T: Decodable>(
        from urlString: String,
        httpMethod: String = "GET",
        urlParam: [String: String]? = nil,
        responseModel: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var components = URLComponents(string: urlString)
        if let urlParams = urlParam {
            components?.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let finalURL = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = httpMethod
        print("###########3")
        print(finalURL)
        print("###########3")

        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 1
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 120

        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(responseModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    public func addRecently(model: RecentlyModel) {
        do {
            _ = try self.homeService.addRecently(model)
        } catch {
            print(error)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
