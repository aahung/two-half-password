//
//  THLabel.swift
//  two-half-password
//
//  Created by Xinhong LIU on 19/6/15.
//  Copyright © 2015 ParseCool. All rights reserved.
//

import Cocoa
import PureLayout

class THLabel: NSTextField {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        bordered = false
        drawsBackground = false
        editable = false
        font = NSFont.systemFontOfSize(13.0)
        autoSetDimension(ALDimension.Height, toSize: 17.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
