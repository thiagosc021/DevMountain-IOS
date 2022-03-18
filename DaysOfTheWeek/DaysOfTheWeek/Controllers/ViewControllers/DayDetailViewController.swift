//
//  DayDetailViewController.swift
//  DaysOfTheWeek
//
//  Created by Thiago Costa on 3/17/22.
//

import UIKit

class DayDetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayOriginLabel: UILabel!
    
    //MARK: - Properties
    var day: Day?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let day = day else { return }
        dayNameLabel.text = day.name
        dayOriginLabel.text = day.origin
    }
}
