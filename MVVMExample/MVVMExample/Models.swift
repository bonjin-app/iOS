//
//  Models.swift
//  MVVMExample
//
//  Created by gigas on 2021/04/27.
//

import Foundation

enum Gender {
    case male, female, unspecified
}

struct Person {
    let name: String
    let birthdate: Data?
    let middleName: String?
    let address: String?
    let gender: Gender
    
    init(name: String, birthdate: Data? = nil, middleName: String? = nil, address: String? = nil, gender: Gender = .unspecified) {
        self.name = name
        self.birthdate = birthdate
        self.middleName = middleName
        self.address = address
        self.gender = gender
    }
}
