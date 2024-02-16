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

	private var cancellable: AnyCancellable?
	private let publisher = PassthroughSubject<Bool, Never>()

	init() {
		cancellable = publisher.sink { value in
			if value {
				self.uiState = .goToHomeScreen
			}
		}
	}

	deinit {
		cancellable?.cancel()
	}

	func login(email: String, password: String) {
		uiState = .loading

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.uiState = .goToHomeScreen
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
