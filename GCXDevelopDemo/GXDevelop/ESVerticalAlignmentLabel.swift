//
//  ESVerticalAlignmentLabel.swift
//  EarthSpirit
//
//  Created by alpha on 2018/8/9.
//  Copyright © 2018年 KarlSW. All rights reserved.
//

import UIKit

enum VerticalAlignment {
    case top
    case center
}
class ESVerticalAlignmentLabel: UILabel {

    private var verticalAlignment = VerticalAlignment.top
    
    init(frame: CGRect, verticalAlignment: VerticalAlignment) {
        super.init(frame: frame)
        self.verticalAlignment = verticalAlignment
    }
    
    init(verticalAlignment: VerticalAlignment) {
        super.init(frame: .zero)
        self.verticalAlignment = verticalAlignment
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let actualRect = textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        switch verticalAlignment {
        case .top:
            textRect.origin.y = bounds.origin.y;
        default:break
        }
        return textRect
    }
}
