//
//  NadelLayer.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 05.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class NadelLayer: CALayer {
    
    override func draw(in ctx: CGContext){
        
        ctx.saveGState()
        var myCenter: CGPoint = CGPoint()
        myCenter.x = self.frame.size.width / 2.0
        myCenter.y = self.frame.size.height / 2.0
        let myPt1: CGPoint = CGPoint(x: self.frame.size.width - 10.0, y: myCenter.y)
        let myPt2: CGPoint = CGPoint(x: myCenter.x, y: myCenter.y + 20.0)
        let myPt3: CGPoint = CGPoint(x: self.frame.origin.x, y: myCenter.y)
        let myPt4: CGPoint = CGPoint(x: myCenter.x, y: myCenter.y - 20.0)
        let myPts = [myPt1, myPt2, myPt2, myPt3, myPt3, myPt4, myPt4, myPt1]
        var myRect: CGRect = CGRect(x: myCenter.y - 25.0, y: myCenter.y - 25.0, width: 50.0, height: 50.0)
        var myPath: CGMutablePath = CGMutablePath()
        myPath.addLines(between: [myPt1, myPt2, myPt2, myPt4, myPt4, myPt1])
        ctx.setFillColor(UIColor.brown.cgColor)
        ctx.addPath(myPath)
        ctx.fillPath()
        
        myPath = CGMutablePath()
        myPath.addLines(between: [myPt2, myPt3, myPt3, myPt4, myPt4, myPt2])
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addPath(myPath)
        ctx.strokePath()
        ctx.setLineWidth(3.0)
        ctx.setStrokeColor(UIColor.darkGray.cgColor)
        ctx.strokeLineSegments(between: myPts)
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.setLineWidth(6.0)
        ctx.fillEllipse(in: myRect)
        ctx.strokeEllipse(in: myRect)
        
        myRect.origin.x = myCenter.x - 15.0
        myRect.origin.y = myCenter.y - 15.0
        myRect.size.width = 30.0
        myRect.size.height = 30.0
        
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillEllipse(in: myRect)
        ctx.strokeEllipse(in: myRect)
        ctx.restoreGState()
    }

}
