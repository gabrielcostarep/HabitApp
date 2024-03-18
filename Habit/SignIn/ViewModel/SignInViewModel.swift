//
//  SignInViewModel.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import Combine
import SwiftUI

class SignInViewModel: ObservableObject {
	@Published var uiState: SignInUIState = .none
	@Published var form = SignInViewStateValidate()
	
	private var cancellable: AnyCancellable?
	private var cancellableRequest: AnyCancellable?
	
	private let publisher = PassthroughSubject<Bool, Never>()
	private let interactor: SignInInteractor
	
	init(interactor: SignInInteractor) {
		self.interactor = interactor
		
		cancellable = publisher.sink { value in
			if value {
				self.uiState = .goToHomeScreen
			}
		}
	}
	
	deinit {
		cancellable?.cancel()
		cancellableRequest?.cancel()
	}
	
	func login() {
		uiState = .loading
		
		cancellableRequest = interactor.login(loginRequest: SignInRequest(email: form.email,
		                                                                  password: form.password))
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .failure(let error):
					self.uiState = .error(error.message)
				case .finished:
					break
				}
			}, receiveValue: { success in
				print(success)
				self.uiState = .goToHomeScreen
			})
	}
}

extension SignInViewModel {
	func signUpView() -> some View {
		return SignInViewRouter.makeSignUpView(publisher: publisher)
	}

	func homeView() -> some View {
		return SignInViewRouter.makeHomeView()
	}
}
