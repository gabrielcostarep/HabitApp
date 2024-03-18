//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import Combine
import SwiftUI

class SignUpRemoteDataSource {
	static var shared: SignUpRemoteDataSource = .init()

	private init() {}

	func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
		return Future { promise in
			WebServices.jsonEncoder(path: .postUser, body: request) { result in
				switch result {
				case .failure(let error, let data):
					if let data = data {
						if error == .badRequest {
							let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
							promise(.failure(AppError.response(message: response?.detail ?? "unknown server error")))
						}
					}
				case .success:
					promise(.success(true))
				}
			}
		}
	}
}
