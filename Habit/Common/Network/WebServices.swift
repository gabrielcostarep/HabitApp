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
	
	private enum ContentType: String {
		case json = "application/json"
		case formUrl = "application/x-www-form-urlencoded"
	}
	
	private static func createURLRequest(path: EndPoint) -> URLRequest? {
		guard let url = URL(string: "\(EndPoint.base.rawValue)\(path.rawValue)") else { return nil }

		return URLRequest(url: url)
	}
	
	private static func call(path: EndPoint,
	                         contentType: ContentType,
	                         data: Data?,
	                         completion: @escaping (Result) -> Void)
	{
		guard var urlRequest = createURLRequest(path: path) else { return }
		
		urlRequest.httpMethod = "POST"
		urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
		urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
		urlRequest.httpBody = data
		
		URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			guard let data = data, error == nil else {
				completion(.failure(.internalServerError, nil))
				return
			}
			
			if let r = response as? HTTPURLResponse {
				switch r.statusCode {
					case 400:
						completion(.failure(.badRequest, data))
					case 401:
						completion(.failure(.unauthorized, data))
					case 200:
						completion(.success(data))
					default:
						break
				}
			}
		}.resume()
	}
	
	private static func jsonEncoder<T: Encodable>(path: EndPoint,
	                                              body: T,
	                                              completion: @escaping (Result) -> Void)
	{
		guard let jsonData = try? JSONEncoder().encode(body) else { return }

		call(path: path,
		     contentType: .json,
		     data: jsonData,
		     completion: completion)
	}
	
	private static func formUrlEncoder(path: EndPoint,
	                                   params: [URLQueryItem],
	                                   completion: @escaping (Result) -> Void)
	{
		guard let urlRequest = createURLRequest(path: path) else { return }
		
		guard let absoluteURL = urlRequest.url?.absoluteString else { return }
		
		guard var components = URLComponents(string: absoluteURL) else { return }
		components.queryItems = params
		
		call(path: path,
		     contentType: .formUrl,
		     data: components.query?.data(using: .utf8),
		     completion: completion)
	}
	
	static func postUser(request: SignUpRequest, completion: @escaping (Bool?, ErrorResponse?) -> Void) {
		jsonEncoder(path: .postUser, body: request) { result in
			switch result {
				case .failure(let error, let data):
					if let data = data {
						if error == .badRequest {
							let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
							completion(nil, response)
						}
					}
				case .success(let data):
					completion(true, nil)
			}
		}
	}
	
	static func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
		formUrlEncoder(path: .login, params: [
			URLQueryItem(name: "username", value: request.email),
			URLQueryItem(name: "password", value: request.password)
		]) { result in
			switch result {
				case .failure(let error, let data):
					if let data = data {
						if error == .unauthorized {
							let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
							completion(nil, response)
						}
					}
				case .success(let data):
					let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
					completion(response, nil)
			}
		}
	}
}
