//
//  SignUpStateValidate.swift
//  Habit
//
//  Created by Gabriel Costa on 23/02/24.
//

import SwiftUI

struct SignUpViewStateValidate {
	var fullName        = ""
	var email           = ""
	var password        = ""
	var passwordVerify  = ""
	var cpf             = ""
	var phone           = ""

	func isValidEmail() -> Bool {
		let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
		return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
	}

	func isValidPassword() -> Bool {
		let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$", options: [])
		return regex.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.utf16.count)) != nil
	}
	
	func isIdenticalPassword() -> Bool {
		return password == passwordVerify
	}
	
	func isValidCPF() -> Bool {
		let cpfRegex = "^(\\d{3})\\.?(\\d{3})\\.?(\\d{3})-?(\\d{2})$"
		let cpfTest = NSPredicate(format: "SELF MATCHES %@", cpfRegex)
		let isValid = cpfTest.evaluate(with: cpf)
			
		guard isValid else { return false }
			
		let numbers = cpf.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
		guard numbers.count == 11 else { return false }
			
		let set = NSCountedSet(array: Array(numbers))
		guard set.count != 1 else { return false }
			
		let sum1 = stride(from: 10, to: 1, by: -1).enumerated().reduce(0) {
			$0 + ($1.element * Int(String(numbers[String.Index(utf16Offset: $1.offset, in: numbers)]))!)
		}
			
		let digit1 = (sum1 % 11 < 2) ? 0 : (11 - (sum1 % 11))
			
		let sum2 = stride(from: 11, to: 1, by: -1).enumerated().reduce(0) {
			$0 + ($1.element * Int(String(numbers[String.Index(utf16Offset: $1.offset, in: numbers)]))!)
		}
			
		let digit2 = (sum2 % 11 < 2) ? 0 : (11 - (sum2 % 11))
			
		return digit1 == Int(String(numbers[String.Index(utf16Offset: 9, in: numbers)])) &&
			digit2 == Int(String(numbers[String.Index(utf16Offset: 10, in: numbers)]))
	}
}
