//
//  SignInViewStateValidate.swift
//  Habit
//
//  Created by Gabriel Costa on 23/02/24.
//

import SwiftUI

struct SignInViewStateValidate {
	var email:    String   = ""
	var password: String   = ""

	func isValidEmail() -> Bool {
		let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
		return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
	}

	func isValidPassword() -> Bool {
		return password.count >= 8
	}

	func isCompleteLogin() -> Bool {
		return isValidEmail() && isValidPassword()
	}
}
