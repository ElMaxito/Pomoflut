import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    let window = NSApplication.shared.windows.first
    let initialSize = NSSize(width: 300, height: 436)
    
    window?.minSize = initialSize // Set minimum size
    window?.maxSize = initialSize // Set maximum size

    // Set the initial size
    window?.setFrame(NSRect(origin: window!.frame.origin, size: initialSize), display: true)
  }
}

