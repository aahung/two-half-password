//
//  THTextView.swift
//  two-half-password
//
//  Created by Xinhong LIU on 19/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import PureLayout

class THTextView: NSTextView {
    
    var containerView: NSScrollView!
    
    override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
        super.init(frame: frameRect, textContainer: container)
        font = NSFont.systemFontOfSize(13.0)
        verticallyResizable = true
        horizontallyResizable = true
        allowsUndo = true
        smartInsertDeleteEnabled = true
        
        autoresizingMask.insert(NSAutoresizingMaskOptions.ViewHeightSizable)
        autoresizingMask.insert(NSAutoresizingMaskOptions.ViewWidthSizable)
        
        containerView = NSScrollView(frame: frameRect)
        containerView.hasVerticalScroller = true
        containerView.hasHorizontalScroller = false
        containerView.usesPredominantAxisScrolling = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.borderType = NSBorderType.BezelBorder
        
        containerView.documentView = self
        
        containerView.contentView.autoresizingMask.insert(NSAutoresizingMaskOptions.ViewHeightSizable)
        containerView.contentView.autoresizingMask.insert(NSAutoresizingMaskOptions.ViewWidthSizable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        containerView.removeFromSuperview()
        super.removeFromSuperview()
    }
    
    func resetString(_string: String) {
        self.string = ""
        insertText(_string) // seems directly assign string = will not responding
                            // if string is too long
        self.undoManager?.removeAllActions()
    }
}
