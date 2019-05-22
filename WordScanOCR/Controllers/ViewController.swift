//
//  OCRResultViewController.swift
//  WordScanOCR
//
//  Created by Isaac Raval on 5/21/19.
//  Copyright © 2019 Isaac Raval. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  //Properties
  var numTimesViewAppeared = 0
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
//    navigationController?.pushViewController(LoadingIndicatorViewController(), animated: true)

    //Display camera interface
    let vc = UIImagePickerController()
    vc.sourceType = .camera
    vc.allowsEditing = true
    vc.delegate = self
    if(numTimesViewAppeared == 0) {
      numTimesViewAppeared += 1
      present(vc, animated: true)
    }
    else { //Show OCRResultVC after first time view has loaded
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "OCRResVC") as! OCRResultViewController
      self.present(vc, animated: true, completion: nil)
    }
  }
}

extension ViewController {
  /* Take image and get its OCR reading. Called after image is taken. */
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    print("aaa")
    //Get image taken
    guard let image = info[.editedImage] as? UIImage else {
      print("No image found") //Terminate if no image found
      return
    }
    
    //Do OCR on image
    performOCR(withImage: image)
    
  }
}

extension ViewController {
  /* Handle cancel option for camera screen */
  internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
    dismiss(animated: true, completion: nil)
  }
}

/* Helper functions */
extension ViewController {
  /* Perform OCR on image */
  func performOCR(withImage image:UIImage) {

    //Perform OCR in the background in a dispatch queue so the app does not appear to freeze up
    DispatchQueue.main.async {
      //Create tesseract G8Tesseract object
      if let tesseract = G8Tesseract(language: "eng") {
        tesseract.engineMode = .tesseractCubeCombined
        tesseract.pageSegmentationMode = .auto
        
        tesseract.image = image
        tesseract.recognize()
        
        //Save recognized text
        let OCROutput = tesseract.recognizedText as! String
        UserDefaults.standard.set(OCROutput, forKey: "Text")
        
      }
    }
  }
}
