//
//  SignInView.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

struct SignInView: View {
	@ObservedObject var viewModel: SignInViewModel

	var body: some View {
		if case SignInUIState.goToHomeScreen = viewModel.uiState {
			viewModel.homeView()
		} else {
			NavigationStack {
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
							Alert(title: Text("Habit"), message: Text("\(error)"), dismissButton: .default(Text("ok")) {})
						}
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding(.horizontal, 32)
				.background(.white)
				.navigationBarTitle("Login", displayMode: .inline)
				.navigationBarHidden(true)
			}
			.tint(.orange)
		}
	}
}

extension SignInView {
	var emailField: some View {
		EditFieldView(
			iconName: "person",
			state: $viewModel.form.email,
			placeholder: "E-mail",
			keyboard: .emailAddress,
			error: "E-mail inválido",
			failure: !viewModel.form.isValidEmail()
		)
	}
}

extension SignInView {
	var passwordField: some View {
		EditFieldView(
			iconName: "lock",
			state: $viewModel.form.password,
			placeholder: "Senha",
			error: "Senha precisa ter pelo menos 8 caracteres",
			failure: !viewModel.form.isValidPassword(),
			isSecure: true
		)
	}
}

extension SignInView {
	var submitButton: some View {
		LoadingButtonView(
			action: { viewModel.login() },
			text: "Entrar",
			showProgress: viewModel.uiState == SignInUIState.loading,
			disabled: !viewModel.form.isCompleteLogin() || viewModel.uiState == SignInUIState.loading
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
	SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
}
