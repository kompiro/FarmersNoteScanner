//
//  HatenaClient.swift
//  OauthTest
//
//  Created by Hiroki Kondo on 2014/10/26.
//  Copyright (c) 2014年 Farms. All rights reserved.
//

import Foundation
import Cocoa

class HatenaClient {
    
    let basePath = NSURL(string: "https://www.hatena.com/")
    let requestTokenPath = "/oauth/initiate"
    let accessTokenPath = "/oauth/token"
    let callbackURL = NSURL(string:"oob")
    let consumerKey = "dU6YkLr6uAps7w=="
    let consumerSecret = "SfAME0BwJkS7xQRGn+u5rCNakPs="
    
    let SCOPE = "read_private,write_private,read_public,write_public"
    
    let manager: BDBOAuth1SessionManager!
    var requestToken: BDBOAuthToken!

    init() {
        manager = BDBOAuth1SessionManager(baseURL: basePath,consumerKey: consumerKey,consumerSecret: consumerSecret)
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    }
    
    func requestRequestToken() {
        manager.fetchRequestTokenWithPath(requestTokenPath,
            method: "POST",
            callbackURL: callbackURL,
            scope: SCOPE,
            success: {
                (requestToken: BDBOAuthToken!) in
                self.requestToken = requestToken
                let url = NSURL(string: "https://www.hatena.ne.jp/oauth/authorize?oauth_token=\(requestToken.token)")
                NSWorkspace.sharedWorkspace().openURL(url!)
            },
            failure: {(error: NSError!) in
                println(error)
            }
        )
    }
    
    func requestAccessToken(verifier: String, successBlock: (accessToken: BDBOAuthToken!) -> Void) {
        println(verifier)
        requestToken.verifier = verifier
        manager.fetchAccessTokenWithPath(accessTokenPath,
            method: "POST",
            requestToken: requestToken,
            success: successBlock,
            failure: {(error: NSError!) in
                println(error)
            }
        )
    }
    
    func requestMyInformation(successBlock: (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void) {
        manager.GET(
            "http://n.hatena.com/applications/my.json",
            parameters: nil,
            success: successBlock,
            failure: { (task: NSURLSessionDataTask!, error: NSError!) in
                println(error)
            }
        )
    }
    
    func uploadFotolife(filenames: [AnyObject], completionHandler: (response: NSURLResponse!, responseObject: AnyObject!, error: NSError!) -> Void) {
        for object in filenames {
            let filename = object as String
            let atom = PhotoXML()
            let text = atom.generate(filename)
            let url = NSURL(string:"http://f.hatena.ne.jp/atom/post")
            let request = NSMutableURLRequest()
            request.URL = url
            request.HTTPMethod = "POST"
            request.HTTPBody = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            request.setValue("application/xml", forHTTPHeaderField: "Content-Type")
            let serializer = manager.requestSerializer
            let header = serializer.OAuthAuthorizationHeaderForMethod("POST", URLString: "http://f.hatena.ne.jp/atom/post", parameters: nil,error: nil)
            NSLog(header)
            request.setValue(header, forHTTPHeaderField: "Authorization")
            let dataTask = manager.dataTaskWithRequest(
                request,
                completionHandler: completionHandler
            )
            dataTask.resume()
            
        }
    }
}
