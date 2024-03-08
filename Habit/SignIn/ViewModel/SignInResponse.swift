//
//  SignInResponse.swift
//  Habit
//
//  Created by Gabriel Costa on 08/03/24.
//

import SwiftUI

struct SignInResponse: Decodable {
	let accessToken: String
	let refreshToken: String
	let expires: Int
	let tokenType: String

	enum CodingKeys: String, CodingKey {
		case accessToken =  "access_token"
		case refreshToken = "refresh_token"
		case expires
		case tokenType = "token_type"
	}
}

struct SignInErrorResponse: Decodable {
	let detail: SignInDetailErrorResponse

	enum CodingKeys: CodingKey {
		case detail
	}
}

struct SignInDetailErrorResponse: Decodable {
	let message: String

	enum CodingKeys: CodingKey {
		case message
	}
}
