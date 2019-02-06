//
//  DocumentBrowserViewController.swift
//  iXplorer
//
//  Created by Jahangir Kabir on 2/3/19.
//  Copyright © 2019 ZayyanSoft. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = true
        
        // Update the style of the UIDocumentBrowserViewController
         browserUserInterfaceStyle = .dark
         view.tintColor = .red
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view, typically from a nib.
        let containingText = "This is a test from Snap app Lab. inc and this is a test file text of this file managet test file creation."
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path + "/" + "dummyTextFile.txt"
        let rawData: Data? = containingText.data(using: .utf8)
        let status = FileManager.default.createFile(atPath: filePath, contents: rawData, attributes: nil)
        
        if status {
            print("file write successfull")
        } else{
            print("file write failed")
        }
        
    }
    
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
//        let newDocumentURL: URL? = nil
        
        let newDocumentURL: URL? = Bundle.main.url(forResource:
            "textTemplate", withExtension: "txt")
        
        if newDocumentURL != nil {
            importHandler(newDocumentURL, .copy)
        } else {
            importHandler(nil, .none)
        }
        // Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
        // Make sure the importHandler is always called, even if the user cancels the creation request.
//        if newDocumentURL != nil {
//            importHandler(newDocumentURL, .move)
//        } else {
//            importHandler(nil, .none)
//        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentViewController = storyBoard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        documentViewController.document = Document(fileURL: documentURL)
        
        present(documentViewController, animated: true, completion: nil)
    }
}

