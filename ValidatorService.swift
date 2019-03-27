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
    
    init(text: String) {
        self.text = text
    }
    
    public func required() -> ValidatorService{
        if isValid() {
            if text.isEmpty {
                valid = false
            }
        }
        return self
    }
    
    public func minLength(count: Int) -> ValidatorService {
        if isValid() {
            if text.count < count {
                valid = false
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
        }
        return self
    }
    
    public func email() -> ValidatorService {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: text) {
            valid = false
        }
        return self
    }
    
    
    public func isValid() -> Bool{
        return valid
    }
}
