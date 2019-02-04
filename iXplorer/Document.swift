//
//  Document.swift
//  iXplorer
//
//  Created by Jahangir Kabir on 2/3/19.
//  Copyright © 2019 ZayyanSoft. All rights reserved.
//

import UIKit

class Document: UIDocument {
    var fileData: Data?
    var filesText: String?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        
        if typeName == "public.plain-text" {
            if let content = filesText {
                let data = content.data(using: .utf8)
                return data!
            } else {
                return Data()
            }
        } else {
            return Data()
        }
        
//        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let fileType = typeName {
        
            if fileType == "public.png" || fileType == "public.jpeg" {
                if let fileContents = contents as? Data {
                    fileData = fileContents
                }
                
            } else if fileType == "public.plain-text" {
                if let fileContents = contents as? Data {
                    filesText = String(data: fileContents, encoding: .utf8)
                }
                
            } else {
                print("File type unsupported.")
            }
            
        }
    }
}

