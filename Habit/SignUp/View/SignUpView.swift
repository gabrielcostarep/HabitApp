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
						EditTextFieldView(
							iconName: "person",
							state: $form.fullName,
							placeholder: "Nome Completo"
						)
						
						EditTextFieldView(
							iconName: "envelope.fill",
							state: $form.email,
							placeholder: "E-mail",
							keyboard: .emailAddress,
							error: "E-mail inválido",
							failure: !form.isValidEmail()
						)
							
						EditSecureFieldView(
							iconName: "key",
							state: $form.password,
							placeholder: "Senha",
							error: "Precisa ter pelo menos 8 caracteres. \nPrecisa conter pelo menos uma letra maiúscula. \nPrecisa conter pelo menos um dígito.",
							failure: !form.isValidPassword()
						)
						
						EditSecureFieldView(
							iconName: "key.fill",
							state: $form.passwordVerify,
							placeholder: "Repetir Senha",
							error: "Senhas precisam ser idênticas",
							failure: !form.isIdenticalPassword()
						)
							
						EditTextFieldView(
							iconName: "person.crop.artframe",
							state: $form.cpf,
							placeholder: "CPF",
							keyboard: .numberPad,
							error: "CPF inválido",
							failure: !form.isValidCPF()
						)
						
						EditTextFieldView(
							iconName: "smartphone",
							state: $form.phone,
							placeholder: "Telefone",
							keyboard: .phonePad,
							error: "Número inválido",
							failure: !form.isValidPhoneNumber()
						)
							
						genderField
							
						registerButton
					}
					.padding(.horizontal, 2)
				}
					
				if case SignUpUIState.loading = viewModel.uiState {
					VStack { ProgressView() }
						.padding()
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
		Button("Cadastrar") {
			viewModel.signUp()
		}
		.frame(width: 100, height: 40)
		.background(form.isCompletedForm() ? .orange : .orange.opacity(0.5))
		.foregroundStyle(.white)
		.cornerRadius(10)
		.padding(.top, 8)
		.disabled(!form.isCompletedForm())
	}
}

#Preview {
	SignUpView(viewModel: SignUpViewModel())
}
