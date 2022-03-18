//
//  DayListTableViewController.swift
//  DaysOfTheWeek
//
//  Created by Thiago Costa on 3/17/22.
//

import UIKit

class DayListTableViewController: UITableViewController {
    
    //MARK: = LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayController.daysOfTheWeek.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)

        let day = DayController.daysOfTheWeek[indexPath.row]
        
        cell.textLabel?.text = day.name

        return cell
    }
   
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DayDetailViewController,
              let index = tableView.indexPathForSelectedRow else {
            return
        }
        
        let day = DayController.daysOfTheWeek[index.row]
       
        destination.day = day
    }

}
