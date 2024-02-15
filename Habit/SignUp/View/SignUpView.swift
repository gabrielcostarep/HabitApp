//
//  SignUpView.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

struct SignUpView: View {
	@ObservedObject var viewModel: SignUpViewModel
	
	@State var fullName        = ""
	@State var email           = ""
	@State var password        = ""
	@State var passwordVerify  = ""
	@State var document        = ""
	@State var phone           = ""
	@State var birthday        = ""
	@State var gender          = Gender.undefined
	
	var body: some View {
		ZStack {
			ScrollView(showsIndicators: false) {
				Spacer(minLength: 130)
					
				VStack(alignment: .leading) {
					Text("Cadastro")
						.foregroundStyle(.black)
						.font(.title.bold())
						
					VStack(spacing: 16) {
						createTextField(iconName: "person", state: $fullName, placeholder: "Nome Completo")
							
						createTextField(iconName: "envelope.fill", state: $email, placeholder: "Email")
							
						createSecureField(iconName: "key", state: $password, placeholder: "Senha")
							
						createSecureField(iconName: "key.fill", state: $passwordVerify, placeholder: "Repetir Senha")
							
						createTextField(iconName: "person.crop.artframe", state: $document, placeholder: "CPF")
							
						createTextField(iconName: "smartphone", state: $phone, placeholder: "Telefone")
							
						createTextField(iconName: "calendar", state: $birthday, placeholder: "Data de Nascimento")
							
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
				ForEach(Gender.allCases) {genderValue in
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
