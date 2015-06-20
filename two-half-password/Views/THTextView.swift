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
        
        containerView = NSScrollView(frame: frameRect)
        containerView.hasVerticalScroller = true
        containerView.hasHorizontalScroller = false
        containerView.borderType = NSBorderType.BezelBorder
        
        containerView.documentView = self
        
        autoPinEdgeToSuperviewEdge(ALEdge.Leading)
        autoPinEdgeToSuperviewEdge(ALEdge.Trailing)
        autoSetDimension(ALDimension.Height, toSize: 500.0)
        
        // containerView.autoresizingMask = NSAutoresizingMaskOptions.ViewHeightSizable
        // containerView.autoresizingMask.insert(NSAutoresizingMaskOptions.ViewWidthSizable)
        // containerView.translatesAutoresizingMaskIntoConstraints = true
        
        textContainer?.widthTracksTextView = true
        textContainer?.heightTracksTextView = false
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
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
