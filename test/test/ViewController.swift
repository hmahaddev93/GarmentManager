//
//  ViewController.swift
//  test
//
//  Created by Khateeb H. on 12/1/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let people = ["john": 23, "james": 24, "vincent": 34, "louis": 29]
        let sorted = people.sorted({$1.1 < $1.0}).map({$0.0})
        
        let newOrder = people.sort({$1.1<$1.0}).map({$0.0})

        print(sorted)
    }


}

