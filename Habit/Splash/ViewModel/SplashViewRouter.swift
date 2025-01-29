//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

import SwiftUI

enum SplashViewRouter {
	static func makeSignInView() -> some View {
		return SignInView()
	}

	static func makeHomeView() -> some View {
		return HomeView()
	}
}
