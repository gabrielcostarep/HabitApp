//
//  SignInRemoteDataSource.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import Combine
import SwiftUI

class SignInRemoteDataSource {
	static var shared: SignInRemoteDataSource = .init()

	private init() {}

	func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
		return Future { promise in
			WebServices.formUrlEncoder(path: .login, params: [
				URLQueryItem(name: "username", value: request.email),
				URLQueryItem(name: "password", value: request.password)
			]) { result in
				switch result {
					case .failure(let error, let data):
						if let data = data {
							if error == .unauthorized {
								let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
								promise(.failure(AppError.response(message: response?.detail.message ?? "unknown server error")))
							}
						}
					case .success(let data):
						guard let response = try? JSONDecoder().decode(SignInResponse.self, from: data) else { return }
						promise(.success(response))
				}
			}
		}
	}
}
