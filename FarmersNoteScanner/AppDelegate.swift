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
    
    let client : HatenaClient!
    
    override init() {
        client = HatenaClient()
    }


    func applicationDidFinishLaunching(aNotification: NSNotification) {
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(NSApplication!) -> Bool {
        return true
    }
    
    func application(sender: NSApplication, openFiles filenames: [AnyObject]) {
        NSLog("start FarmersNoteScanner")
        let sema = dispatch_semaphore_create(0)
        /*
        client.requestMyInformation { (task, responseObject) -> Void in
            NSLog("complete \(responseObject)")
            dispatch_semaphore_signal(sema)
            return
        }
*/
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER)
        client.uploadFotolife(filenames,{ (response, responseObject, error) in
            NSLog("response \(response)")
            NSLog("object \(responseObject)")
            NSLog("error \(error)")
            dispatch_semaphore_signal(sema)
            return
        })
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER)
        sender.terminate(nil)
    }

}

