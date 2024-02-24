//
//  EditFieldView.swift
//  Habit
//
//  Created by Gabriel Costa on 23/02/24.
//

import SwiftUI

struct EditFieldView: View {
	var iconName:       String
	@Binding var state: String
	var placeholder:    String
	var keyboard:       UIKeyboardType  = .default
	var error:          String?         = nil
	var failure:  			Bool            = false
	var isSecure: 			Bool            = false

	var body: some View {
		VStack {
			HStack {
				createImageIcon(iconName: iconName)

				if isSecure {
					SecureField(
						"",
						text: $state,
						prompt: Text(placeholder).foregroundStyle(.gray.opacity(0.5))
					)
					.keyboardType(keyboard)
					.textInputAutocapitalization(.never)
					.autocorrectionDisabled(true)
				} else {
					TextField(
						"",
						text: $state,
						prompt: Text(placeholder).foregroundStyle(.gray.opacity(0.5))
					)
					.keyboardType(keyboard)
					.textInputAutocapitalization(.never)
					.autocorrectionDisabled(true)
				}
			}
			.padding(5)
			.overlay {
				RoundedRectangle(cornerRadius: 8)
					.stroke(state.isEmpty || !failure ? .gray : .red, lineWidth: 1)
			}

			if let error = error, failure == true, !state.isEmpty {
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

#Preview {
	EditFieldView(iconName: "person", state: .constant("texto"), placeholder: "E-mail", error: "Texto inválido", failure: true, isSecure: false)
}
