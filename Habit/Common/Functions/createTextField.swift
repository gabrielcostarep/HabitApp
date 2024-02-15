//
//  createTextField.swift
//  Habit
//
//  Created by Gabriel Costa on 07/02/24.
//

import SwiftUI

func createTextField(iconName: String, state: Binding<String>, placeholder: String) -> some View {
	let i = iconName
	return ZStack {
		HStack {
			createImageIcon(iconName: i)

			TextField(
				"",
				text: state,
				prompt: Text(placeholder).foregroundStyle(.gray.opacity(0.5))
			)
		}
		.padding(5)
		.overlay {
			RoundedRectangle(cornerRadius: 8)
				.stroke(.gray, lineWidth: 1)
		}
	}
}
