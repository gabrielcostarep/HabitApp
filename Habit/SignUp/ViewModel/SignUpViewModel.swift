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

	var publisher: PassthroughSubject<Bool, Never>!

	func signUp() {
		self.uiState = .loading

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.publisher.send(true)
			self.uiState = .success
		}
	}
}
