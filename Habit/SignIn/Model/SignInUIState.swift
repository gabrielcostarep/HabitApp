//
//  SignInModel.swift
//  Habit
//
//  Created by Gabriel Costa on 29/01/24.
//

enum SignInUIState: Equatable {
	case none
	case loading
	case goToHomeScreen
	case error(String)
}
