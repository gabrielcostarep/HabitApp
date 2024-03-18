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
	}
	
	func login() {
		uiState = .loading
		
		interactor.login(loginRequest: SignInRequest(email: form.email,
		                                         password: form.password))
		{ successResponse, errorResponse in
			
			if let error = errorResponse {
				DispatchQueue.main.async {
					self.uiState = .error(error.detail.message)
				}
			}
			
			if let success = successResponse {
				DispatchQueue.main.async {
					print(success)
					self.uiState = .goToHomeScreen
				}
			}
		}
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
