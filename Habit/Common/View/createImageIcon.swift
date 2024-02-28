//
//  createImageIcon.swift
//  Habit
//
//  Created by Gabriel Costa on 28/02/24.
//

import SwiftUI

func createImageIcon(iconName: String) -> some View {
	Image(systemName: iconName)
		.foregroundStyle(.orange)
		.frame(width: 25, height: 20)
}
