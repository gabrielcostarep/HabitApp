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
	case undefined  = "Indefinido"

	var id: String { rawValue }
}
