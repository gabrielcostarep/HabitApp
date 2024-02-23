//
//  SplashViewModel.swift
//  Habit
//
//  Created by Gabriel Costa on 28/01/24.
//

import SwiftUI

class SplashViewModel: ObservableObject {
	@Published var uiState: SplashUIState = .loading

	func onAppear() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			self.uiState = .goToSignInScreen
		}
	}
}

extension SplashViewModel {
	func signInView() -> some View {
		return SplashViewRouter.makeSignInView()
	}

	func homeView() -> some View {
		return SplashViewRouter.makeHomeView()
	}
}
