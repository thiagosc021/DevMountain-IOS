//
//  StudentTableViewController.swift
//  StudentList
//
//  Created by Thiago Costa on 3/10/22.
//

import UIKit

class StudentTableViewController: UITableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return StudentController.students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        let student = StudentController.students[indexPath.row]
        
        cell.textLabel?.text = student.firstName        

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        
        let student = StudentController.students[index.row]
        
        if let vc = segue.destination as? StudentDetailViewController {
            vc.student = student            
        }
    }
    

}
