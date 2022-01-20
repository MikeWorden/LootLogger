//
//  DateViewController.swift
//  LootLogger
//
//  Created by Michael Worden on 1/19/22.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet var itemDate: UIDatePicker!
    
    var item: Item!
    
    override func viewDidLoad() {
        var defaultDate: Date
        
        defaultDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        itemDate.date = defaultDate
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = itemDate.date
        // "Save" changes to item
    }
}
