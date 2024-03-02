//
//  Gender.swift
//  Habit
//
//  Created by Gabriel Costa on 09/02/24.
//

import SwiftUI

enum Gender: String, CaseIterable, Identifiable {
	case male       = "Masculino"
	case female     = "Feminino"

	var id: String { rawValue }
	
	var index: Self.AllCases.Index { Self.allCases.firstIndex { self == $0} ?? 0}
}

