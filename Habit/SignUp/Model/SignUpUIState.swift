//
//  SignUpUIScreen.swift
//  Habit
//
//  Created by Gabriel Costa on 11/02/24.
//

import SwiftUI

enum SignUpUIState: Equatable {
	case none
	case loading
	case success
	case error(String)
}
