//
//  SignInView.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

struct SignInView: View {
	@ObservedObject var viewModel: SignInViewModel

	@State var form = SignInViewStateValidate()

	@State var hiddenNavigation = true

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

						emailField

						passwordField

						submitButton

						registerLink
					}
					.padding(.horizontal, 2)

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
				.navigationBarHidden(hiddenNavigation)
			}
		}
	}
}

extension SignInView {
	var emailField: some View {
		TextFieldView(
			iconName: "person",
			state: $form.email,
			placeholder: "E-mail",
			keyboard: .emailAddress,
			error: "E-mail inválido",
			failure: !form.isValidEmail()
		)
	}
}

extension SignInView {
	var passwordField: some View {
		SecureFieldView(
			iconName: "lock",
			state: $form.password,
			placeholder: "Senha",
			error: "Senha precisa ter pelo menos 8 caracteres",
			failure: !form.isValidPassword()
		)
	}
}

extension SignInView {
	var submitButton: some View {
		LoadingButtonView(
			action: { viewModel.login(email: form.email, password: form.password) },
			text: "Entrar",
			showProgress: self.viewModel.uiState == SignInUIState.loading,
			disabled: !form.isCompleteLogin() || self.viewModel.uiState == SignInUIState.loading
		)
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
