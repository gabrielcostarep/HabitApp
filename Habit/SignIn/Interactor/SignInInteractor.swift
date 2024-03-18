//
//  SignInInteractor.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import SwiftUI

class SignInInteractor {
	private let remote: SignInRemoteDataSource = .shared
}

extension SignInInteractor {
	func login(loginRequest request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
		remote.login(request: request, completion: completion)
	}
}
