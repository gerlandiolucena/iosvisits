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
    let backgroundSelectedPinColor = UIColor.darkGray
    let backgroundVisualizedPinColor = UIColor.lightGray
    
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
    
    override func draw(_ rect: CGRect) {
        //let color = getRealColor()
        super.draw(rect)
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
    
    func drawBellowArrowWithRect(_ rect: CGRect, color: UIColor) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: (rect.size.width / 2.0) - 4.0, y: rect.size.height - 4.0))
        bezierPath.addLine(to: CGPoint(x: (rect.size.width / 2.0), y: rect.size.height))
        bezierPath.addLine(to: CGPoint(x: (rect.size.width / 2.0) + 4.0, y: rect.size.height - 4.0))
        color.setFill()
        bezierPath.fill()
    }
    
    func sizeOfString(_ string: NSString) -> CGSize {
        let font = UIFont.systemFont(ofSize: bigFontSize)
        let size = string.size(attributes: [NSFontAttributeName: font])
        
        return CGSize(width: size.width, height: size.height)
    }
    
    func resizeString(_ value: NSMutableAttributedString, range: NSRange) -> NSMutableAttributedString {
        let fontSize: CGFloat = smallFontSize
        let boldFont = UIFont.systemFont(ofSize: bigFontSize)
        let regularFont = UIFont.systemFont(ofSize: fontSize)
        
        // Create the attributes
        let attrs = [NSFontAttributeName: boldFont]
        let subAttrs = [NSFontAttributeName: regularFont]
        
        let response = NSMutableAttributedString(string: value.string, attributes: attrs)
        response.setAttributes(subAttrs, range: range)
        
        return response
    }
    
    func formatPriceString(_ priceString: NSString) -> NSMutableAttributedString {
        var response = NSMutableAttributedString(string: priceString as String)
        
        do {
            let finalNumbersRegex = try NSRegularExpression(pattern: "\\.+[0-9]{3,3}", options: NSRegularExpression.Options.allowCommentsAndWhitespace)
            let regexResult = finalNumbersRegex.firstMatch(in: response.string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, response.string.characters.count ))
            
            if regexResult!.range.location != NSNotFound {
                response = self.resizeString(response, range: regexResult!.range)
            }
        }
        catch {}
        
        var range = response.string.range(of: "mi")
        if range?.isEmpty == false {
            let start = response.string.characters.distance(from: response.string.startIndex, to: range!.lowerBound)
            response = self.resizeString(response, range: NSMakeRange(start, 2))
        }
        
        range = response.string.range(of: "+")
        if range?.isEmpty == false  {
            let start = response.string.characters.distance(from: response.string.startIndex, to: range!.lowerBound)
            response = self.resizeString(response, range: NSMakeRange(start, 1))
        }
        
        return response
    }
    
    func configureNumberLabel(_ text: String, cornerRadius: CGFloat, isCluster: Bool) {
        if self.numberLabel == nil {
            self.numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            self.numberLabel!.textColor = UIColor(white: 1.0, alpha: 1.0)
            self.numberLabel!.textAlignment = .center
            self.numberLabel!.backgroundColor =  UIColor.clear
            self.addSubview(self.numberLabel!)
        } else {
            self.numberLabel!.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        }
        
        self.numberLabel!.font =  UIFont.systemFont(ofSize: bigFontSize)
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
            frame.size = self.sizeOfString(formatedPrice as NSString)
            configureNumberLabel(formatedPrice, cornerRadius: 5, isCluster: false)
//        }
        
        self.backgroundColor =  UIColor.clear
//        if !isCluster {
//            frame.size.width += 10.0
//        }
//        
        super.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height + 4)
        
        if self.numberLabel != nil {
            self.numberLabel!.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        }
    }
}
