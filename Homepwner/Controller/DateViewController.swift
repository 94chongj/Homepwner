//
//  DateViewController.swift
//  Homepwner
//
//  Created by Jonathan Chong on 8/28/18.
//  Copyright © 2018 Jonathan Chong. All rights reserved.
//

import UIKit

class DateViewController: UIViewController, UITextFieldDelegate {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var item: Item! {
        
        didSet {
            navigationItem.title = dateFormatter.string(from: item.dateCreated)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dateFormatter.string(from: item.dateCreated))
    }
    
}
