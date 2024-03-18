//
//  SignInRemoteDataSource.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import SwiftUI

class SignInRemoteDataSource {
	static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
	
	private init() {
		
	}
	
	func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void){
		WebServices.formUrlEncoder(path: .login, params: [
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
