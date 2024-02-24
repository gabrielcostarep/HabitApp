//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Gabriel Costa on 24/02/24.
//

import SwiftUI

struct LoadingButtonView: View {
	var action: () -> Void
	var text: String
	var showProgress: Bool = false
	var disabled:     Bool = false

	var body: some View {
		ZStack {
			Button(action: {
				action()
			}, label: {
				Text(showProgress ? " " : text)

			}).disabled(disabled || showProgress)

			ProgressView()
				.opacity(showProgress ? 1 : 0)
		}
		.frame(maxWidth: 130, minHeight: 40)
		.background(disabled ? .orange.opacity(0.5) : .orange)
		.foregroundStyle(.white)
		.cornerRadius(10)
		.padding(.top, 8)
	}
}

#Preview {
	LoadingButtonView(action: { print("Olá") }, text: "Entrar", showProgress: true, disabled: true)
}
