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
	}

	private static func createURLRequest(path: EndPoint) -> URLRequest? {
		guard let url = URL(string: "\(EndPoint.base.rawValue)\(path.rawValue)") else { return nil }

		return URLRequest(url: url)
	}

	static func postUser(request: SignUpRequest) {
		guard let jsonData = try? JSONEncoder().encode(request) else { return }

		guard var urlRequest = createURLRequest(path: .postUser) else { return }

		urlRequest.httpMethod = "POST"
		urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		urlRequest.httpBody = jsonData
		
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			guard let data = data, error == nil else {
				print(error as Any)
				return
			}
			
			print(String(data: data, encoding: .utf8) as Any)
			print(response as Any)
			
			if let r = response as? HTTPURLResponse {
				print(r.statusCode) 
			}
		}
		
		task.resume()
	}
}
