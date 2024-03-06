//
//  EditFieldView.swift
//  Habit
//
//  Created by Gabriel Costa on 23/02/24.
//

import SwiftUI

struct EditFieldView: View {
	enum Mask {
		case none
		case cpf
		case phoneNumber
		case birthday
	}

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
		case .birthday:
			return applyBirthdayFormat(birthday: value)
		default:
			return value
		}
	}

	private func applyCPFFormat(cpf: String) -> String {
		var formattedCPF = cpf
		if cpf.count == 4 && !formattedCPF.contains(".") {
			formattedCPF.insert(".", at: formattedCPF.index(formattedCPF.startIndex, offsetBy: 3))
		}
		if cpf.count == 8 && formattedCPF[formattedCPF.index(formattedCPF.startIndex, offsetBy: 7)] != "." {
			formattedCPF.insert(".", at: formattedCPF.index(formattedCPF.startIndex, offsetBy: 7))
		}
		if cpf.count == 12 && !formattedCPF.contains("-") {
			formattedCPF.insert("-", at: formattedCPF.index(formattedCPF.startIndex, offsetBy: 11))
		}
		return String(formattedCPF.prefix(14))
	}

	private func applyPhoneNumberFormat(phoneNumber: String) -> String {
		var formattedPhoneNumber = phoneNumber
		if phoneNumber.count == 3 && !formattedPhoneNumber.contains("(") {
			formattedPhoneNumber.insert("(", at: formattedPhoneNumber.startIndex)
		}
		if phoneNumber.count == 4 && !formattedPhoneNumber.contains(")") {
			formattedPhoneNumber.insert(")", at: formattedPhoneNumber.index(formattedPhoneNumber.startIndex, offsetBy: 3))
		}
		if phoneNumber.count == 10 && !formattedPhoneNumber.contains("-") {
			formattedPhoneNumber.insert("-", at: formattedPhoneNumber.index(formattedPhoneNumber.startIndex, offsetBy: 9))
		}
		return String(formattedPhoneNumber.prefix(14))
	}

	private func applyBirthdayFormat(birthday: String) -> String {
		var formattedBirthday = birthday
		if birthday.count == 3 && !formattedBirthday.contains("/") {
			formattedBirthday.insert("/", at: formattedBirthday.index(formattedBirthday.startIndex, offsetBy: 2))
		}
		if birthday.count == 6 && formattedBirthday[formattedBirthday.index(formattedBirthday.startIndex, offsetBy: 5)] != "/" {
			formattedBirthday.insert("/", at: formattedBirthday.index(formattedBirthday.startIndex, offsetBy: 5))
		}

		return String(formattedBirthday.prefix(10))
	}
}

#Preview {
	EditFieldView(iconName: "person", state: .constant("28-02-2023"), placeholder: "CPF", mask: .cpf)
}
