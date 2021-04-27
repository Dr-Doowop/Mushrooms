//
//  KompassLayer.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 05.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit

class KompassLayer: CALayer {
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        var ellipseRect = self.frame
        ellipseRect.size.width -= 10.0
        ellipseRect.size.height -= 10.0
        //Grafik zeichen
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: ellipseRect)
        ctx.setStrokeColor(UIColor.brown.cgColor)
        ctx.strokeEllipse(in: ellipseRect)
        //Ein Kreuz zeichen
        drawSharp(ctx)
        //Die beschriftung der Himmelsrichtung einzeichnen
        drawChars(ctx)
        ctx.restoreGState()
    }
    
    func drawSharp(_ ctx: CGContext){
        let abstand: CGFloat = 40.0
        var myPoint1 = CGPoint(x: abstand, y: self.frame.size.width / 2.0)
        var myPoint2 = CGPoint(x: self.frame.width - abstand, y: self.frame.size.width / 2.0)
        var myPoints = [myPoint1, myPoint2]
        
        ctx.setLineWidth(3.0)
        ctx.strokeLineSegments(between: myPoints)
        
        myPoint1 = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.origin.y + abstand)
        myPoint2 = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height - abstand)
        myPoints = [myPoint1, myPoint2]
        
        ctx.strokeLineSegments(between: myPoints)
    }
    
    func createTextLayer(_ text: String, rect: CGRect, angle: CGFloat) -> CATextLayer {
        let myTextLayer = CATextLayer()
        myTextLayer.frame = rect
        myTextLayer.font = UIFont(name: "Times new Roman", size: 32.0)
        myTextLayer.foregroundColor = UIColor.brown.cgColor
        myTextLayer.alignmentMode = .center
        myTextLayer.setAffineTransform(CGAffineTransform(rotationAngle: .pi / 180.0 * angle))
        myTextLayer.string = text
        return myTextLayer
    }
    
    func drawChars(_ ctx: CGContext){
        let textWidth: CGFloat = self.frame.size.width / 6.0
        let textRand: CGFloat = 2.0
        let mitteOben: CGPoint = CGPoint(x: self.frame.width / 2.0, y: self.frame.origin.y)
        var myRect: CGRect = CGRect(x: mitteOben.x - textWidth / 2.0, y: mitteOben.y, width: textWidth, height: textWidth)
        
        self.addSublayer(createTextLayer("N", rect: myRect, angle: 0.0))
        
        myRect.origin.y = self.frame.size.height - textWidth - textRand
        myRect.origin.x = mitteOben.x - textWidth / 2.0
        self.addSublayer(createTextLayer("S", rect: myRect, angle: 180.0))
        
        myRect.origin.y = self.frame.size.height / 2.0 - textWidth / 2.0
        myRect.origin.x = self.frame.size.width - textWidth - textRand
        self.addSublayer(createTextLayer("O", rect: myRect, angle: 90.0))
        
        myRect.origin.y = self.frame.size.height / 2.0 - textWidth / 2.0
        myRect.origin.x = textRand
        self.addSublayer(createTextLayer("W", rect: myRect, angle: -90.0))
    }
}
