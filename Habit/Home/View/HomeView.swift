//
//  HomeView.swift
//  Habit
//
//  Created by Gabriel Costa on 30/01/24.
//

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel = HomeViewModel()

	var body: some View {
		Text("HomeView")
			.background(.yellow)
	}
}

#Preview {
	HomeView()
}
