//
//  EditFieldStyle.swift
//  Habit
//
//  Created by Gabriel Costa on 25/02/24.
//

import SwiftUI

struct EditFieldStyle: TextFieldStyle {
	var keyboard: UIKeyboardType

	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.keyboardType(keyboard)
			.textInputAutocapitalization(.never)
			.autocorrectionDisabled(true)
	}
}
