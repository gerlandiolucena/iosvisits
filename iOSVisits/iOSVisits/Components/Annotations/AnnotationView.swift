//
//  AnnotationView.swift
//  iOSVisits
//
//  Created by Gerlandio da Silva Lucena on 6/3/16.
//  Copyright © 2016 ZAP Imóveis. All rights reserved.
//

//
//  PriceAnnotationView.swift
// QuantoVale
//
//  Created by Caio Cezar Lopes on 7/6/15.
//  Copyright (c) 2015 Zap Imóveis. All rights reserved.
//

import UIKit
import MapKit

class AnnotationView: MKAnnotationView {
    var title = ""
    var numberLabel: UILabel?
    let bigFontSize: CGFloat = 14.0
    let smallFontSize: CGFloat = 12.0
    let backgroundPinColor = UIColor(red: 58.0 / 255.0, green: 130.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
    let backgroundSelectedPinColor = UIColor.darkGrayColor()
    let backgroundVisualizedPinColor = UIColor.lightGrayColor()
    
    override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        if let offerAnnotation = self.annotation as? PlaceAnnotation {
            title = offerAnnotation.title ?? ""
        }
        
        self.resizeToFitText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        //let color = getRealColor()
        super.drawRect(rect)
//        if !isCluster {
//            self.drawBellowArrowWithRect(rect, color: color)
//        }
    }
    
    func getRealColor() -> UIColor {
//        switch(self.atualState) {
//        case .Selected:
//            return backgroundSelectedPinColor
//        case .Visualized:
//            return backgroundVisualizedPinColor
//        case .None:
            return backgroundPinColor
//        }
    }
    
    func drawBellowArrowWithRect(rect: CGRect, color: UIColor) {
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake((rect.size.width / 2.0) - 4.0, rect.size.height - 4.0))
        bezierPath.addLineToPoint(CGPointMake((rect.size.width / 2.0), rect.size.height))
        bezierPath.addLineToPoint(CGPointMake((rect.size.width / 2.0) + 4.0, rect.size.height - 4.0))
        color.setFill()
        bezierPath.fill()
    }
    
    func sizeOfString(string: NSString) -> CGSize {
        let font = UIFont.systemFontOfSize(bigFontSize)
        let size = string.sizeWithAttributes([NSFontAttributeName: font])
        
        return CGSizeMake(size.width, size.height)
    }
    
    func resizeString(value: NSMutableAttributedString, range: NSRange) -> NSMutableAttributedString {
        let fontSize: CGFloat = smallFontSize
        let boldFont = UIFont.systemFontOfSize(bigFontSize)
        let regularFont = UIFont.systemFontOfSize(fontSize)
        
        // Create the attributes
        let attrs = [NSFontAttributeName: boldFont]
        let subAttrs = [NSFontAttributeName: regularFont]
        
        let response = NSMutableAttributedString(string: value.string, attributes: attrs)
        response.setAttributes(subAttrs, range: range)
        
        return response
    }
    
    func formatPriceString(priceString: NSString) -> NSMutableAttributedString {
        var response = NSMutableAttributedString(string: priceString as String)
        
        do {
            let finalNumbersRegex = try NSRegularExpression(pattern: "\\.+[0-9]{3,3}", options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
            let regexResult = finalNumbersRegex.firstMatchInString(response.string, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, response.string.characters.count ))
            
            if regexResult!.range.location != NSNotFound {
                response = self.resizeString(response, range: regexResult!.range)
            }
        }
        catch {}
        
        var range = response.string.rangeOfString("mi")
        if range?.isEmpty == false {
            let start = response.string.startIndex.distanceTo(range!.startIndex)
            response = self.resizeString(response, range: NSMakeRange(start, 2))
        }
        
        range = response.string.rangeOfString("+")
        if range?.isEmpty == false  {
            let start = response.string.startIndex.distanceTo(range!.startIndex)
            response = self.resizeString(response, range: NSMakeRange(start, 1))
        }
        
        return response
    }
    
    func configureNumberLabel(text: String, cornerRadius: CGFloat, isCluster: Bool) {
        if self.numberLabel == nil {
            self.numberLabel = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
            self.numberLabel!.textColor = UIColor(white: 1.0, alpha: 1.0)
            self.numberLabel!.textAlignment = .Center
            self.numberLabel!.backgroundColor =  UIColor.clearColor()
            self.addSubview(self.numberLabel!)
        } else {
            self.numberLabel!.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        }
        
        self.numberLabel!.font =  UIFont.systemFontOfSize(bigFontSize)
        self.numberLabel!.text = text
        self.numberLabel!.backgroundColor = getRealColor()
        self.numberLabel!.layer.cornerRadius = cornerRadius
        self.numberLabel!.clipsToBounds = true
    }
    
    func resizeToFitText() {
        let formatedPrice = ""
        var frame = self.frame
        
//        if let annotation = self.annotation as? OfferAnnotation {
//            isCluster = annotation.offersDetail.count > 1
//        }
        
//        if isCluster {
//            if let offerAnnotation = self.annotation as? OfferAnnotation {
//                let defaultSize = self.sizeOfString(String(offerAnnotation.offersDetail.count))
//                frame.size = CGSizeMake(defaultSize.height + 6, defaultSize.height + 6)
//                configureNumberLabel(String(offerAnnotation.offersDetail.count), cornerRadius: frame.size.height / 2, isCluster: true)
//            }
//        } else {
            frame.size = self.sizeOfString(formatedPrice)
            configureNumberLabel(formatedPrice, cornerRadius: 5, isCluster: false)
//        }
        
        self.backgroundColor =  UIColor.clearColor()
//        if !isCluster {
//            frame.size.width += 10.0
//        }
//        
        super.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 4)
        
        if self.numberLabel != nil {
            self.numberLabel!.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        }
    }
}
