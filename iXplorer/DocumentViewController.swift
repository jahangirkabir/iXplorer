//
//  DocumentViewController.swift
//  iXplorer
//
//  Created by Jahangir Kabir on 2/3/19.
//  Copyright © 2019 ZayyanSoft. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var documentText: UITextField!
    
    var document: Document? //UIDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
        
                if self.document?.fileType == "public.png" || self.document?.fileType == "public.jpeg" {
                    self.documentText.isHidden = true
                    self.documentImage.isHidden = false
                    self.documentImage.image = UIImage(data: (self.document?.fileData)!)
                } else if self.document?.fileType == "public.plain-text" {
                    self.documentText.isHidden = false
                    self.documentImage.isHidden = true
                    self.documentText.text = self.document?.filesText!
                }
                
//                let string = self.document?.fileURL.lastPathComponent
//                if string!.contains(".txt"){
//
//                    self.documentText.text = self.document?.fileURL.!
//                } else {
//                    self.documentText.isHidden = false
//                    self.documentImage.isHidden = true
//
//                    self.documentImage.image = UIImage(data: (self.document?.fileData)!)
//                }
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
