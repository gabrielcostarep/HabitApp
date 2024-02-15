//
//  FieldStyle.swift
//  Habit
//
//  Created by Gabriel Costa on 07/02/24.
//

import SwiftUI

struct FieldStyle: TextFieldStyle {
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.frame(maxWidth: .infinity)
			.padding(5)
			.overlay {
				RoundedRectangle(cornerRadius: 5)
					.stroke(.gray, lineWidth: 1)
			}
	}
}
