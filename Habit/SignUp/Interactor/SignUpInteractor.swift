//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import Combine
import SwiftUI

class SignUpInteractor {
	private let remoteSignUp: SignUpRemoteDataSource = .shared
	private let remoteSignIn: SignInRemoteDataSource = .shared
}


extension SignUpInteractor {
	func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
		return remoteSignUp.postUser(request: request)
	}
	
	func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
		return remoteSignIn.login(request: request)
	}
}
