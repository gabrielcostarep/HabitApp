//
//  HabitApp.swift
//  Habit
//
//  Created by Gabriel Costa on 26/01/24.
//

import SwiftUI

@main
struct HabitApp: App {
	var body: some Scene {
		WindowGroup {
			SplashView(viewModel: SplashViewModel())
		}
	}
}
