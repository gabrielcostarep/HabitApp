//
//  SignUpView.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

struct SignUpView: View {
	@ObservedObject var viewModel: SignUpViewModel
	@State var isSecure: Bool = true

	var body: some View {
		ZStack {
			ScrollView(showsIndicators: false) {
				Spacer(minLength: 130)

				VStack(alignment: .leading) {
					Text("Cadastro")
						.foregroundStyle(.black)
						.font(.title.bold())

					VStack(alignment: .center, spacing: 16) {
						fullNameField

						emailField

						passwordField

						cpfField

						phoneField

						birthdayField

						genderField

						registerButton
					}
					.padding(.horizontal, 2)
				}

				if case SignUpUIState.error(let error) = viewModel.uiState {
					VStack {}.alert(isPresented: .constant(true)) {
						Alert(title: Text("Habit"), message: Text("\(error)"), dismissButton: .default(Text("ok")) {})
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.padding(.horizontal, 32)
			.background(.white)
		}
	}
}

extension SignUpView {
	var fullNameField: some View {
		EditFieldView(
			iconName: "person",
			input: $viewModel.form.fullName,
			placeholder: "Nome Completo",
			error: "Nome precisa ter pelo menos 3 caracteres",
			failure: !viewModel.form.isValidFullName(),
			isSecure: .constant(false)
		)
	}
}

extension SignUpView {
	var emailField: some View {
		EditFieldView(
			iconName: "envelope.fill",
			input: $viewModel.form.email,
			placeholder: "E-mail",
			keyboard: .emailAddress,
			error: "E-mail inválido",
			failure: !viewModel.form.isValidEmail(),
			isSecure: .constant(false)
		)
	}
}

extension SignUpView {
	var passwordField: some View {
		EditFieldView(
			iconName: "key",
			input: $viewModel.form.password,
			placeholder: "Senha",
			error: "Precisa conter ao menos 8 caracteres. \nPrecisa conter pelo menos uma letra maiúscula.",
			failure: !viewModel.form.isValidPassword(),
			buttonShowPassword: true,
			isSecure: $isSecure
		)
	}
}

extension SignUpView {
	var cpfField: some View {
		EditFieldView(
			iconName: "person.crop.artframe",
			input: $viewModel.form.cpf,
			placeholder: "CPF",
			keyboard: .numberPad,
			error: "CPF inválido",
			failure: !viewModel.form.isValidCPF(),
			mask: .cpf,
			isSecure: .constant(false)
		)
	}
}

extension SignUpView {
	var phoneField: some View {
		EditFieldView(
			iconName: "smartphone",
			input: $viewModel.form.phone,
			placeholder: "Telefone",
			keyboard: .asciiCapableNumberPad,
			error: "Entre com DDD + 9 dígitos",
			failure: !viewModel.form.isValidPhoneNumber(),
			mask: .phoneNumber,
			isSecure: .constant(false)
		)
	}
}

extension SignUpView {
	var birthdayField: some View {
		EditFieldView(
			iconName: "calendar",
			input: $viewModel.form.birthday,
			placeholder: "Data de Nascimento",
			keyboard: .asciiCapableNumberPad,
			error: "Digite uma data no formato dd/MM/yyyy",
			failure: !viewModel.form.isValidBirthday(),
			mask: .birthday,
			isSecure: .constant(false)
		)
	}
}

extension SignUpView {
	var genderField: some View {
		HStack {
			createImageIcon(iconName: "figure.dress.line.vertical.figure")
				.padding(5)

			Picker("Gender", selection: $viewModel.form.gender) {
				ForEach(Gender.allCases) { genderValue in
					Text(genderValue.rawValue)
						.tag(genderValue)
				}
			}
			.pickerStyle(SegmentedPickerStyle())
		}
		.overlay {
			RoundedRectangle(cornerRadius: 8)
				.stroke(.gray, lineWidth: 1)
		}
	}
}

extension SignUpView {
	var registerButton: some View {
		LoadingButtonView(
			action: { viewModel.signUp() },
			text: "Cadastrar",
			showProgress: viewModel.uiState == SignUpUIState.loading,
			disabled: !viewModel.form.isCompletedForm() || viewModel.uiState == SignUpUIState.loading
		)
	}
}

#Preview {
	SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
}
