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
	
	private var cancellablePostUser: AnyCancellable?
	private var cancellableLogin: AnyCancellable?
	
	var publisher: PassthroughSubject<Bool, Never>!
	private let interactor: SignUpInteractor
	
	init(interactor: SignUpInteractor) {
		self.interactor = interactor
	}
	
	deinit {
		cancellablePostUser?.cancel()
		cancellableLogin?.cancel()
	}
	
	func signUp() {
		uiState = .loading
		
		cancellablePostUser = interactor.postUser(request: SignUpRequest(fullName: form.fullName,
		                                                                 email: form.email,
		                                                                 password: form.password,
		                                                                 cpf: form.cpf,
		                                                                 phone: form.phone,
		                                                                 birthday: form.birthday.split(separator: "/").reversed().joined(separator: "-"),
		                                                                 gender: form.gender.index))
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .failure(let error):
					self.uiState = .error(error.message)
				case .finished:
					break
				}
			}, receiveValue: { created in
				
				if created {
					self.cancellableLogin = self.interactor.login(request: SignInRequest(email: self.form.email,
					                                                                     password: self.form.password))
						.receive(on: DispatchQueue.main)
						.sink(receiveCompletion: { completion in
							switch completion {
							case .failure(let error):
								self.uiState = .error(error.message)
							case .finished:
								break
							}
						}, receiveValue: { successSignIn in
							print(successSignIn)
							self.uiState = .success
							self.publisher.send(created)
						})
				}
			})
	}
}
