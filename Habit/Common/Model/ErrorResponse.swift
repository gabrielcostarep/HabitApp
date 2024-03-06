//
//  ErrorResponse.swift
//  Habit
//
//  Created by Gabriel Costa on 06/03/24.
//

import SwiftUI

struct ErrorResponse: Decodable {
	let detail: String

	enum CodingKeys: CodingKey {
		case detail
	}
}
