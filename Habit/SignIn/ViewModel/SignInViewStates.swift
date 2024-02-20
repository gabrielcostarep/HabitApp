//
//  SignInViewStates.swift
//  Habit
//
//  Created by Gabriel Costa on 20/02/24.
//

import SwiftUI

struct SignInViewStates {
	var email:    String   = ""
	var password: String   = ""
	var messages: [String] = []

	var hiddenNavigation = true

	mutating func validate() -> Bool {
		messages = []

		if email.isEmpty {
			messages.append("Email precisa ser válido.")
		}

		if password.isEmpty {
			messages.append("Senha não pode estar vazia.")
		}

		return messages.count == 0
	}
}
