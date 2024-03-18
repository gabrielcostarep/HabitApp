//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Gabriel Costa on 07/02/24.
//

import Combine
import SwiftUI

enum SignInViewRouter {
	static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
		let viewModel = SignUpViewModel(interactor: SignUpInteractor())

		viewModel.publisher = publisher

		return SignUpView(viewModel: viewModel)
	}

	static func makeHomeView() -> some View {
		return HomeView(viewModel: HomeViewModel())
	}
}
