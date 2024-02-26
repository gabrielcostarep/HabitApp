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
	var mask:           Mask            = .none

	var body: some View {
		VStack {
			HStack {
				createImageIcon(iconName: iconName)

				if isSecure {
					SecureField(placeholder, text: $state)
						.textFieldStyle(EditFieldStyle(keyboard: keyboard))
				} else if mask == .none {
					TextField(placeholder, text: $state)
						.textFieldStyle(EditFieldStyle(keyboard: keyboard))
				} else {
					TextField(placeholder, text: $state)
						.onChange(of: state) { newValue in
							self.state = self.maskedValue(for: newValue)
						}
						.textFieldStyle(EditFieldStyle(keyboard: keyboard))
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

extension EditFieldView {
	private func maskedValue(for value: String) -> String {
		switch mask {
		case .cpf:
			return applyCPFFormat(cpf: value)
		case .phoneNumber:
			return applyPhoneNumberFormat(phoneNumber: value)
		default:
			return value
		}
	}

	private func applyCPFFormat(cpf: String) -> String {
		var formattedCPF = cpf
		if cpf.count == 3 {
			formattedCPF.insert(".", at: formattedCPF.index(formattedCPF.startIndex, offsetBy: 3))
		}
		if cpf.count == 7 {
			formattedCPF.insert(".", at: formattedCPF.index(formattedCPF.startIndex, offsetBy: 7))
		}
		if cpf.count == 11 {
			formattedCPF.insert("-", at: formattedCPF.index(formattedCPF.startIndex, offsetBy: 11))
		}
		return String(formattedCPF.prefix(14))
	}

	private func applyPhoneNumberFormat(phoneNumber: String) -> String {
		var formattedPhoneNumber = phoneNumber
		if phoneNumber.count == 2 {
			formattedPhoneNumber.insert("(", at: formattedPhoneNumber.startIndex)
		}
		if phoneNumber.count == 3 {
			formattedPhoneNumber.insert(")", at: formattedPhoneNumber.index(formattedPhoneNumber.startIndex, offsetBy: 3))
		}
		if phoneNumber.count == 9 {
			formattedPhoneNumber.insert("-", at: formattedPhoneNumber.index(formattedPhoneNumber.startIndex, offsetBy: 9))
		}
		return String(formattedPhoneNumber.prefix(14))
	}
}

#Preview {
	EditFieldView(iconName: "person", state: .constant("11116708469"), placeholder: "CPF", mask: .cpf)
}
