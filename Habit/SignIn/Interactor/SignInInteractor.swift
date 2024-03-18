//
//  SignInInteractor.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import Combine
import SwiftUI

class SignInInteractor {
	private let remote: SignInRemoteDataSource = .shared
}

extension SignInInteractor {
	func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
		return remote.login(request: request)
	}
}
