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
        let xml:NSXMLDocument = NSXMLDocument()
        xml.characterEncoding = "utf-8"

        let entry = NSXMLElement(name: "entry")
        let entryNS = NSXMLNode.attributeWithName("xmlns", stringValue: "http://www.w3.org/2005/Atom") as NSXMLNode
        let entryNSApp = NSXMLNode.attributeWithName("xmlns:app", stringValue: "http://www.w3.org/2007/app") as NSXMLNode
        entry!.addAttribute(entryNS)
        entry!.addAttribute(entryNSApp)
        xml.setRootElement(entry!)
        
        let title = NSXMLElement(name: "title",stringValue: "作業ノート")
        entry!.addChild(title!)

        let author = NSXMLElement(name: "author")
        let authorName = NSXMLElement(name: "name",stringValue: "kompiro")
        author!.addChild(authorName!)
        entry!.addChild(author!)

        let content = NSXMLElement(name: "content",stringValue: content)
        let contentType = NSXMLNode.attributeWithName("type", stringValue: "text/plain") as NSXMLNode
        content!.addAttribute(contentType)
        entry!.addChild(content!)
        
        let category = NSXMLElement(name: "category")
        let categoryTerm = NSXMLNode.attributeWithName("term", stringValue: "作業ノート") as NSXMLNode
        category!.addAttribute(categoryTerm)
        entry!.addChild(category!)
        
        let control = NSXMLElement(name: "app:control")
        let draft = NSXMLElement(name:"app:draft",stringValue: "no")
        control!.addChild(draft!)
        entry!.addChild(control!)

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
