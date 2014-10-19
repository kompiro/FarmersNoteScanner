//
//  AppDelegate.swift
//  FarmersNoteScanner
//
//  Created by Hiroki Kondo on 2014/10/19.
//  Copyright (c) 2014年 Farms. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        window.close()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(NSApplication!) -> Bool {
        return true
    }
    
    func application(sender: NSApplication, openFiles filenames: [AnyObject]) {
        var text = ""
        for object in filenames {
            let filename = object as String
            text += filename + "\n"
        }
        text.writeToFile("/tmp/output.txt", atomically: true, encoding: NSUTF8StringEncoding)
    }

}

