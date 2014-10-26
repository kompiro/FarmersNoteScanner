//
//  AtomXML.swift
//  FarmersNoteScanner
//
//  Created by Hiroki Kondo on 2014/10/20.
//  Copyright (c) 2014年 Farms. All rights reserved.
//

import Foundation

public class BlogXML : NSObject {
    
    public func generate (content : String) -> String {
        let root = NSXMLElement(name: "entry")
        let xml:NSXMLDocument = NSXMLDocument()
        xml.characterEncoding = "utf-8"
        xml.setRootElement(root!)
        
        let title = NSXMLElement(name: "title",stringValue: "作業ノート")
        let content = NSXMLElement(name: "content",stringValue: content)
        
        let contentType: NSXMLNode = NSXMLNode.attributeWithName("type", stringValue: "text/plain") as NSXMLNode
        content!.addAttribute(contentType)
        
        root!.addChild(title!)
        root!.addChild(content!)

        return xml.XMLString
    }
    
}

public class PhotoXML : NSObject {
    
    public func generate (contentPath : String) -> String {
        let data = NSData(contentsOfFile: contentPath)

        let root = NSXMLElement(name: "entry")
        let xml:NSXMLDocument = NSXMLDocument()
        xml.characterEncoding = "utf-8"
        xml.setRootElement(root!)
        
        let title = NSXMLElement(name: "title",stringValue: contentPath)
        let encoded = data?.base64EncodedStringWithOptions(nil)
        let content = NSXMLElement(name: "content",stringValue: encoded)
        
        let contentType: NSXMLNode = NSXMLNode.attributeWithName("type", stringValue: "image/jpeg") as NSXMLNode
        content!.addAttribute(contentType)
        let mode : NSXMLNode = NSXMLNode.attributeWithName("mode", stringValue: "base64") as NSXMLNode
        content!.addAttribute(mode)
        
        root!.addChild(title!)
        root!.addChild(content!)
        
        return xml.XMLString
    }
    
}
