//
//  SignUpView.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

struct SignUpView: View {
	@ObservedObject var viewModel: SignUpViewModel
	
	@State var form    = SignUpViewStateValidate()
	@State var gender  = Gender.undefined
	
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
			state: $form.fullName,
			placeholder: "Nome Completo",
			error: "Nome precisa ter pelo menos 3 caracteres",
			failure: !form.isValidFullName()
		)
	}
}

extension SignUpView {
	var emailField: some View {
		EditFieldView(
			iconName: "envelope.fill",
			state: $form.email,
			placeholder: "E-mail",
			keyboard: .emailAddress,
			error: "E-mail inválido",
			failure: !form.isValidEmail()
		)
	}
}

extension SignUpView {
	var passwordField: some View {
		EditFieldView(
			iconName: "key",
			state: $form.password,
			placeholder: "Senha",
			error: "Precisa ter pelo menos 8 caracteres. \nPrecisa conter pelo menos uma letra maiúscula.",
			failure: !form.isValidPassword(),
			isSecure: true
		)
	}
}

extension SignUpView {
	var cpfField: some View {
		EditFieldView(
			iconName: "person.crop.artframe",
			state: $form.cpf,
			placeholder: "CPF",
			keyboard: .numberPad,
			error: "CPF inválido",
			failure: !form.isValidCPF(),
			mask: .cpf
		)
	}
}

extension SignUpView {
	var phoneField: some View {
		EditFieldView(
			iconName: "smartphone",
			state: $form.phone,
			placeholder: "Telefone",
			keyboard: .phonePad,
			error: "Entre com DDD + 9 dígitos",
			failure: !form.isValidPhoneNumber(),
			mask: .phoneNumber
		)
	}
}

extension SignUpView {
	var birthdayField: some View {
		EditFieldView(
			iconName: "calendar",
			state: $form.birthday,
			placeholder: "Data de Nascimento",
			keyboard: .asciiCapableNumberPad,
			mask: .birthday
		)
	}
}

extension SignUpView {
	var genderField: some View {
		HStack {
			createImageIcon(iconName: "figure.dress.line.vertical.figure")
				.padding(5)
			
			Picker("Gender", selection: $gender) {
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
			disabled: !form.isCompletedForm() || viewModel.uiState == SignUpUIState.loading
		)
	}
}

#Preview {
	SignUpView(viewModel: SignUpViewModel())
}
