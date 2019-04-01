//
//  ValidatorService.swift
//  Mobile Pos
//
//  Created by Hossein Safaie on 10/13/1397 AP.
//  Copyright © 1397 RayanParsi. All rights reserved.
//

import Foundation

class ValidatorService {
    
    var text: String
    private var valid: Bool = true
    private var error: ValidatorError?
    
    init(text: String) {
        self.text = text
    }
    
    public func required() -> ValidatorService{
        if isValid() {
            if text.isEmpty {
                valid = false
                error = .required
            }
        }
        return self
    }
    
    public func minLength(count: Int) -> ValidatorService {
        if isValid() {
            if text.count < count {
                valid = false
                error = .minLength
            }
        }
        return self
    }
    
    public func mobile() -> ValidatorService {
        numberal()
        if isValid() {
            let chars = Array(text)
            if chars.count >= 2 {
                if chars[0] != "0" || chars[1] != "9" {
                    valid = false
                    error = .mobile
                }
            }
        }
        return self
    }
    
    public func numberal() -> ValidatorService{
        if isValid() {
            if let _ = Int(text) {
                return self
            }
            valid = false
            error = .numberal
        }
        return self
    }
    
    public func email() -> ValidatorService {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: text) {
            valid = false
            error = .email
        }
        return self
    }
    
    public func validCharacter() -> ValidatorService {
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_!@.")
        if text.rangeOfCharacter(from: characterset.inverted) != nil {
            valid = false
            error = .validCharacter
        }
        return self
    }
    
    public func isValid() -> Bool{
        return valid
    }
    
    public func setErrorHandler(onError: @escaping (_ error: ValidatorError) -> Void) -> ValidatorService{
        if !valid {
            onError(error!)
        }
        return self
    }
    
    public func setOnValid(onValid: @escaping () -> Void) -> ValidatorService{
        if valid {
            onValid()
        }
        return self
    }
    
    enum ValidatorError {
        case required
        case minLength
        case mobile
        case numberal
        case email
        case validCharacter
    }
}






















