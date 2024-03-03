//
//  SignUpRequest.swift
//  Habit
//
//  Created by Gabriel Costa on 02/03/24.
//

import SwiftUI

struct SignUpRequest: Encodable {
	let fullName: String
	let email: String
	let password: String
	let cpf: String
	let phone: String
	let birthday: String
	let gender: Int

	enum CodingKeys: String, CodingKey {
		case fullName = "name"
		case email
		case password
		case cpf = "document"
		case phone
		case birthday
		case gender
	}
}
