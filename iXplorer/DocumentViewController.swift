//
//  DocumentViewController.swift
//  iXplorer
//
//  Created by Jahangir Kabir on 2/3/19.
//  Copyright © 2019 ZayyanSoft. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var documentSaveButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var document: Document?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        detailTextView.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        document?.open(completionHandler: { (success) in
            if success {
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                let pathString = self.document?.fileURL.lastPathComponent
                print("file PATH : " + pathString!)
                if self.document?.fileType == "public.png" || self.document?.fileType == "public.jpg" || self.document?.fileType == "public.jpeg" {
                    
                    self.detailTextView.isHidden = true
                    self.saveButton.isHidden = true
                    self.documentImage.isHidden = false
                    
                    self.documentImage.image = UIImage(data: (self.document?.fileData)!)
                } else if self.document?.fileType == "public.plain-text" {
                    
                    self.detailTextView.isHidden = false
                    self.saveButton.isHidden = false
                    self.documentImage.isHidden = true
                    
                    self.detailTextView.text = self.document?.filesText!
                }
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func save(_ sender: Any) {
        self.document?.filesText = self.detailTextView.text
        print("Save to: \(String(describing: self.document?.fileURL.path))!")
        
        self.document?.save(to: (self.document?.fileURL)!, for: .forOverwriting,
                            completionHandler: {(success: Bool) -> Void in
                                if success {
                                    print("File created OK")
                                    self.dismissDocumentViewController()
                                } else {
                                    print("Failed to save file.")
                                    self.detailTextView.backgroundColor = UIColor.red
                                }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
}
