//
//  SecureFieldView.swift
//  Habit
//
//  Created by Gabriel Costa on 01/02/25.
//

import SwiftUI

struct SecureFieldView: View {
	var iconName: 			String
	@Binding var input: 	String
	var placeholder: 		String
	var keyboard: 			UIKeyboardType  = .default
	var error: 				String?         = nil
	var failure: 			Bool            = false
	var buttonShowPassword: Bool  			= false
	@Binding var isSecure:  Bool

	var body: some View {
		VStack {
			HStack {
				createImageIcon(iconName: iconName)
				
				ZStack {
					TextField(placeholder, text: $input)
						.textFieldStyle(EditFieldStyle(keyboard: keyboard))
						.opacity(isSecure ? 0 : 1)
					
					SecureField(placeholder, text: $input)
						.textFieldStyle(EditFieldStyle(keyboard: keyboard))
						.opacity(isSecure ? 1 : 0)
				}
				
				if buttonShowPassword {
					Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
						.foregroundColor(isSecure ? .gray : .orange)
						.onTapGesture { isSecure.toggle() }
				}
			}
			.padding(5)
			.overlay {
				RoundedRectangle(cornerRadius: 8)
					.stroke(input.isEmpty || !failure ? .gray : .red, lineWidth: 1)
			}
			
			if let error = error, failure == true, !input.isEmpty {
				HStack {
					Spacer()
					
					Text(error)
						.foregroundStyle(.red)
						.font(.footnote)
						.padding(0)
				}
			}
		}
	}
}
