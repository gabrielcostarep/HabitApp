//
//  SignInView.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

struct SignInView: View {
	@ObservedObject var viewModel: SignInViewModel

	@State var FormStates = SignInViewStates()

	var body: some View {
		if case SignInUIState.goToHomeScreen = viewModel.uiState {
			viewModel.homeView()
		} else {
			NavigationView {
				ScrollView(showsIndicators: false) {
					Spacer(minLength: 130)

					VStack(alignment: .center, spacing: 16) {
						Image("logo")
							.resizable()
							.scaledToFit()
							.padding(.horizontal, 10)

						Text("Login")
							.foregroundStyle(.orange)
							.font(.title.bold())

						createTextField(iconName: "person", state: $FormStates.email, placeholder: "Email")

						createSecureField(iconName: "lock", state: $FormStates.password, placeholder: "Senha")

						enterButton

						registerLink
					}
					.padding(.horizontal, 2)

					if case SignInUIState.loading = viewModel.uiState {
						VStack { ProgressView() }
					}

					if case SignInUIState.error(let error) = viewModel.uiState {
						VStack {}.alert(isPresented: .constant(true)) {
							Alert(title: Text("Tente novamente mais tarde"), message: Text("\(error)"), dismissButton: .default(Text("ok")) {})
						}
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding(.horizontal, 32)
				.background(.white)
				.navigationBarTitle("Login", displayMode: .inline)
				.navigationBarHidden(FormStates.hiddenNavigation)
			}
		}
	}
}

extension SignInView {
	var enterButton: some View {
		Button("Entrar") {
			viewModel.login(email: FormStates.email, password: FormStates.password)
		}
		.frame(width: 80, height: 40)
		.background(FormStates.validate() ? .orange : .orange.opacity(0.4))
		.disabled(!FormStates.validate())
		.foregroundStyle(.white)
		.cornerRadius(10)
		.padding(.top, 8)
	}
}

extension SignInView {
	var registerLink: some View {
		VStack {
			Text("Ainda não possui um login ativo?")
				.foregroundStyle(.gray)
				.font(.subheadline)

			NavigationLink {
				viewModel.signUpView()
			} label: {
				Text("Realize seu Cadastro")
					.foregroundStyle(.orange)
					.font(.subheadline)
			}

		}.padding(.top, 48)
	}
}

#Preview {
	SignInView(viewModel: SignInViewModel())
}
