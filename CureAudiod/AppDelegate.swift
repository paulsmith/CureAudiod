//
//  AppDelegate.swift
//  CureAudiod
//
//  Created by Paul Smith on 7/10/17.
//  Copyright © 2017 Paul Smith. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    @objc func buttonWasPressed(sender: AnyObject) {
    }

    func sudo(command: String) {
        let source = "do shell script \"\(command)\" with administrator privileges"
        let script = NSAppleScript(source: source)
        let res = script?.executeAndReturnError(nil)
        print(res?.stringValue ?? "unknown result code")
    }
   
    @objc func restartCoreaudiod(sender: AnyObject) {
        print("coreaudiod")
        sudo(command: "killall coreaudiod")
    }
    
    @objc func restartVDCAssistant(sender: AnyObject) {
        print("vdcassistant")
        sudo(command: "killall VDCAssistant")
    }

    @objc func quit(sender: AnyObject) {
        NSApplication.shared.terminate(sender)
    }
   
    @objc func restartBoth(sender: AnyObject) {
        print("both")
        sudo(command: "killall coreaudiod && killall VDCAssistant")
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "cureaudiod"))
            button.action = #selector(buttonWasPressed)
        }
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Restart coreaudiod", action: #selector(AppDelegate.restartCoreaudiod(sender:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Restart VDCAssistant", action: #selector(AppDelegate.restartVDCAssistant(sender:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator()) 
        menu.addItem(NSMenuItem(title: "Restart both", action: #selector(AppDelegate.restartBoth(sender:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator()) 
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit(sender:)), keyEquivalent: ""))
        statusItem.menu = menu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

