//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import Combine
import SwiftUI

class SignUpViewModel: ObservableObject {
	@Published var uiState: SignUpUIState = .none
	@Published var form = SignUpViewStateValidate()

	var publisher: PassthroughSubject<Bool, Never>!

	func signUp() {
		uiState = .loading

		WebServices.postUser(request: SignUpRequest(fullName: form.fullName,
		                                            email: form.email,
		                                            password: form.password,
		                                            cpf: form.cpf,
		                                            phone: form.phone,
		                                            birthday: form.birthday.split(separator: "/").reversed().joined(separator: "-"),
		                                            gender: form.gender.index))
		{ successResponse, errorResponse in
			if let error = errorResponse {
				DispatchQueue.main.async {
					self.uiState = .error(error.detail)
				}
			}

			if let success = successResponse {
				WebServices.login(request: SignInRequest(email: self.form.email,
				                                         password: self.form.password))
				{ successResponse, errorResponse in

					if let errorSignIn = errorResponse {
						DispatchQueue.main.async {
							self.uiState = .error(errorSignIn.detail.message)
						}
					}

					if let successSignIn = successResponse {
						DispatchQueue.main.async {
							print(successSignIn)
							self.uiState = .success
							self.publisher.send(success)
						}
					}
				}
			}
		}
	}
}
