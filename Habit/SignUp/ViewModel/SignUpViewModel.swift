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

		WebServices.postUser(
			fullName: form.fullName,
			email: form.email,
			password: form.password,
			cpf: form.cpf,
			phone: form.phone,
			birthday: form.birthday.split(separator: "/").reversed().joined(separator: "-"),
			gender: form.gender.index
		)

//		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//			self.publisher.send(true)
//			self.uiState = .success
//		}
	}
}
