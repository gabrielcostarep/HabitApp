//
//  WebServices.swift
//  Habit
//
//  Created by Gabriel Costa on 29/02/24.
//

import SwiftUI

enum WebServices {
	private enum EndPoint: String {
		case base = "https://habitplus-api.tiagoaguiar.co"
		case postUser = "/users"
		case login = "/auth/login"
	}
	
	private enum NetworkError {
		case badRequest
		case notFound
		case unauthorized
		case internalServerError
	}
	
	private enum Result {
		case success(Data)
		case failure(NetworkError, Data?)
	}
	
	private static func createURLRequest(path: EndPoint) -> URLRequest? {
		guard let url = URL(string: "\(EndPoint.base.rawValue)\(path.rawValue)") else { return nil }

		return URLRequest(url: url)
	}
	
	private static func call<T: Encodable>(path: EndPoint, body: T, completion: @escaping (Result) -> Void) {
		guard var urlRequest = createURLRequest(path: path) else { return }
		
		guard let jsonData = try? JSONEncoder().encode(body) else { return }
		
		urlRequest.httpMethod = "POST"
		urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		urlRequest.httpBody = jsonData
		
		URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			guard let data = data, error == nil else {
				print(error)
				completion(.failure(.internalServerError, nil))
				return
			}
			
			if let r = response as? HTTPURLResponse {
				switch r.statusCode {
					case 400:
						completion(.failure(.badRequest, data))
					case 200:
						completion(.success(data))
					default:
						break
				}
			}
		}.resume()
	}

	static func postUser(request: SignUpRequest, completion: @escaping (Bool?, ErrorResponse?) -> Void) {
		call(path: .postUser, body: request) { result in
			switch result {
				case .failure(let error, let data):
					if let data = data {
						if error == .badRequest {
							let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
							completion(nil, response)
						}
					}
				case .success(let data):
					let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
					completion(true, response)
			}
		}
	}
	
//	static func login(request: SignInRequest) {
//		call(path: .login, body: request) { result in
//			switch result {
//				case .failure(let error, let data):
//					if let data = data {
//						print(String(data: data, encoding: .utf8))
//					}
//				case .success(let data):
//					print(String(data: data, encoding: .utf8))
//			}
//		}
//	}
}
