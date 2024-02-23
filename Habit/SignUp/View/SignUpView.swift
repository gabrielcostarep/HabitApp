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
							failure: form.notValidEmail()
						)
							
						EditSecureFieldView(
							iconName: "key",
							state: $form.password,
							placeholder: "Senha",
							error: "Senha inválida",
							failure: form.notValidPassword()
						)
						
						EditSecureFieldView(
							iconName: "key.fill",
							state: $form.passwordVerify,
							placeholder: "Repetir Senha",
							error: "Senha não idêntica",
							failure: form.notIdenticalPassword()
						)
							
						EditTextFieldView(
							iconName: "person.crop.artframe",
							state: $form.cpf,
							placeholder: "CPF",
							keyboard: .numberPad
						)
						
						EditTextFieldView(
							iconName: "smartphone",
							state: $form.phone,
							placeholder: "Telefone",
							keyboard: .phonePad
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
		.background(.orange)
		.foregroundStyle(.white)
		.cornerRadius(10)
		.padding(.top, 8)
	}
}

#Preview {
	SignUpView(viewModel: SignUpViewModel())
}
