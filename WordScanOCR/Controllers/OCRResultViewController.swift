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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //Set Text View contents
        let txt = UserDefaults.standard.string(forKey: "Text") ?? "Error"
        textView?.text = txt
    }
}
