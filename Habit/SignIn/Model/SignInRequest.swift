//
//  SignInRequest.swift
//  Habit
//
//  Created by Gabriel Costa on 04/03/24.
//

import SwiftUI

struct SignInRequest: Encodable {
	let email: String
	let password: String

	enum CodingKeys: String, CodingKey {
		case email = "username"
		case password
	}
}
