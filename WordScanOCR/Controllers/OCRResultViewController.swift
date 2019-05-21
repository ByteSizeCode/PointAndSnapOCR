//
//  OCRResultViewController.swift
//  WordScanOCR
//
//  Created by Isaac Raval on 5/21/19.
//  Copyright © 2019 Isaac Raval. All rights reserved.
//

import UIKit

class OCRResultViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    //Singleton for access to ViewController's properties
    let mainVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //Set Text View contents
        textView?.text = mainVC.OCROutput
    }
}
