//
//  StudentController.swift
//  StudentList
//
//  Created by Thiago Costa on 3/10/22.
//

import Foundation

struct StudentController{
    
    static var students: [Student] {
        return [
            Student(firstName: "Thiago", lastName: "Costa", age: 39),
            Student(firstName: "Maria Clara", lastName: "da Costa", age: 11),
            Student(firstName: "Juliana", lastName: "da Costa", age: 38)
        ]
    }
}
