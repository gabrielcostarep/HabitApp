//
//  SplashView.swift
//  Habit
//
//  Created by Gabriel Costa on 26/01/24.
//

import SwiftUI

struct SplashView: View {
	@StateObject var viewModel = SplashViewModel()

	var body: some View {
		Group {
			switch viewModel.uiState {
				case .loading:
					loadingView()
				case .goToSignInScreen:
					viewModel.signInView()
				case .goToHomeScreen:
					viewModel.homeView()
				case .error(let errorMsg):
					loadingView(error: errorMsg)
			}
		}.onAppear(perform: viewModel.onAppear)
	}
}

extension SplashView {
	func loadingView(error: String? = nil) -> some View {
		ZStack {
			Image("logo")
				.resizable()
				.scaledToFit()
				.frame(maxHeight: .infinity)
				.padding(20)
				.background(.white)
				.ignoresSafeArea(.all)

			if let error = error {
				VStack {}.alert(isPresented: .constant(true)) {
					Alert(title: Text("Tente novamente mais tarde"), message: Text("\(error)"), dismissButton: .default(Text("ok")) {})
				}
			}
		}
	}
}

#Preview {
	SplashView()
}
