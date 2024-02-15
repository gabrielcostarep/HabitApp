//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Gabriel Costa on 11/02/24.
//

import SwiftUI

enum SignUpViewRouter {
	static func makeHomeView() -> some View {
		return HomeView(viewModel: HomeViewModel())
	}
}
