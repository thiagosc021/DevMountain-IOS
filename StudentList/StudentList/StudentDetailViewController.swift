//
//  StudentDetailViewController.swift
//  StudentList
//
//  Created by Thiago Costa on 3/10/22.
//

import UIKit

class StudentDetailViewController: UIViewController {

    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!

    private func updateView() {
        
        guard let student = student, isViewLoaded else {
            return
        }
        
        firstNameLabel.text = student.firstName
        lastNameLabel.text = student.lastName
        ageLabel.text = "\(student.age)"
    }
    
    var student: Student? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
}


