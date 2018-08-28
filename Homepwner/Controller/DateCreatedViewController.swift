//
//  DateCreatedViewController.swift
//  Homepwner
//
//  Created by Jonathan Chong on 8/28/18.
//  Copyright © 2018 Jonathan Chong. All rights reserved.
//

import UIKit

class DateCreatedViewController: UIViewController {
    
    var datePicker: UIDatePicker!
    var item: Item!
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Date Created"
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
