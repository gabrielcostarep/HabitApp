//
//  AppError.swift
//  Habit
//
//  Created by Gabriel Costa on 18/03/24.
//

import SwiftUI

enum AppError: Error {
	case response(message: String)

	public var message: String {
		switch self {
		case .response(let message):
			return message
		}
	}
}
