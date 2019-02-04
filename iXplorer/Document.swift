//
//  Document.swift
//  iXplorer
//
//  Created by Jahangir Kabir on 2/3/19.
//  Copyright © 2019 ZayyanSoft. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    var userText: String? = ""
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        
        if let content = userText {
            
            let length =
                content.lengthOfBytes(using: String.Encoding.utf8)
            return NSData(bytes:content, length: length)
        } else {
            return Data()
        }
        
//        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let userContent = contents as? Data {
            userText = NSString(bytes: (contents as AnyObject).bytes,
                                length: userContent.count,
                                encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
}

