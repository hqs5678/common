//
//
//
//  Created by hqs on 16/3/5.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    var placeholder: NSString?
    var placeholderTextColor: UIColor!
    
    override func drawRect(rect: CGRect) {
        
        var color = placeholderTextColor
        if color == nil {
            color = UIColor.lightGrayColor()
        }
        placeholder?.drawAtPoint(CGPointMake(2, 8), withAttributes: [NSFontAttributeName: font!, NSForegroundColorAttributeName: color])
    }
    
}
