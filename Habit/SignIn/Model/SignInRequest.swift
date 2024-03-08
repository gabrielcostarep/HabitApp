//
//  SignInRequest.swift
//  Habit
//
//  Created by Gabriel Costa on 04/03/24.
//

import SwiftUI

struct SignInRequest {
	let email: String
	let password: String

	enum CodingKeys: CodingKey {
		case email
		case password
	}
}
