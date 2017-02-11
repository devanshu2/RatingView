//
//  RatingView.swift
//  RatingView
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

/**
 Usage:
 let ratingV = RatingView()
 ratingV.text = "4.5+"
 ratingV.cornerRadius = 8.0
 ratingV.updateUIElements()
 ratingV.frame = CGRect(x: 30, y: 230.0, width: ratingV.viewWidth, height: 16.0)
 self.view.addSubview(ratingV)
 
 
 or
 
 
 
 let ratingV = RatingView()
 
 ratingV.text = "4.5+"
 
 ratingV.textFont = UIFont(name: Constants.FontNames.ProximaSemiBold, size: Constants.FontSize.Small)!
 
 ratingV.rightImage = #imageLiteral(resourceName: "notification")
 
 ratingV.borderColor = UIColor.red
 
 ratingV.borderWidth = 2.0
 
 ratingV.backgroundColor = Constants.Colors.Teal
 
 ratingV.cornerRadius = 5.0
 
 ratingV.renderChanges()
 
 ratingV.frame = CGRect(x: 30, y: 30.0, width: ratingV.viewSize.width, height: ratingV.viewSize.height)
 
 self.view.addSubview(ratingV)
 */

public enum RatingViewType {
    //need to set fixed height, vertical padding will be useless
    case fixed
    
    //need to set flexible width, vertical padding will in role
    case flexible
}

class RatingView: UIView {
    
    public var type:RatingViewType = .fixed
    
    public var text:String = ""
    
    public var textColor = UIColor.white
    
    public var textFont = UIFont.systemFont(ofSize: 14.0)
    
    public var borderColor:UIColor?
    
    public var borderWidth:CGFloat = 0.0
    
    public var cornerRadius:CGFloat = 0.0
    
    public var rightImage:UIImage? =  #imageLiteral(resourceName: "star")
    
    public var rightImageCustomSize:CGSize?
    
    public var verticalPadding:Double = 3.0
    
    public var horizontalPadding:Double = 7.0
    
    public var horizontalSpaceBetweenLabelAndImage:Double = 3.0
    
    var textLabel = UILabel()
    
    var rightImageView = UIImageView()
    
    var _viewSize = CGSize.zero
    
    public var viewSize:CGSize {
        get {
            return self._viewSize
        }
    }
    
    public var viewWidth:CGFloat {
        get {
            self.setNeedsLayout()
            self.layoutIfNeeded()
            if self.rightImage == nil {
                return (self.textLabel.frame.size.width + self.textLabel.frame.origin.x + CGFloat(self.horizontalPadding))
            }
            else {
                return (self.rightImageView.frame.size.width + self.rightImageView.frame.origin.x + CGFloat(self.horizontalPadding))
            }
        }
    }
    
    var selfContraints:Array<NSLayoutConstraint> = []
    var labelContraints:Array<NSLayoutConstraint> = []
    var imageContraints:Array<NSLayoutConstraint> = []
    
    public func updateUIElements() {
        self.textLabel.text = self.text
        self.textLabel.textColor = self.textColor
        self.textLabel.font = self.textFont
        
        self.layer.borderColor = self.borderColor?.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
        
        self.removeConstraints(self.selfContraints)
        self.textLabel.removeConstraints(self.labelContraints)
        self.rightImageView.removeConstraints(self.imageContraints)
        
        self.selfContraints.removeAll()
        self.labelContraints.removeAll()
        self.imageContraints.removeAll()
        
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelLeading = NSLayoutConstraint(item: self.textLabel,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: CGFloat(self.horizontalPadding))
        self.selfContraints.append(labelLeading)
        
        let labelTop = NSLayoutConstraint(item: self.textLabel,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .top,
                                          multiplier: 1.0,
                                          constant: 0.0)
        self.selfContraints.append(labelTop)
        
        let labelBottom = NSLayoutConstraint(item: self.textLabel,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .bottom,
                                             multiplier: 1.0,
                                             constant: 0.0)
        self.selfContraints.append(labelBottom)
        
        
        let labelWidth = NSLayoutConstraint(item: self.textLabel,
                                            attribute: .width,
                                            relatedBy: .greaterThanOrEqual,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: 1.0)
        labelWidth.priority = UILayoutPriorityRequired
        self.labelContraints.append(labelWidth)
        
        NSLayoutConstraint.activate([labelLeading, labelTop, labelBottom, labelWidth])
        
        if self.rightImage == nil {
            self.rightImageView.isHidden = true
            self.rightImageView.image = nil
        }
        else {
            self.rightImageView.isHidden = false
            self.rightImageView.image = self.rightImage
            
            self.rightImageView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageLeading = NSLayoutConstraint(item: self.rightImageView,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: self.textLabel,
                                                  attribute: .right,
                                                  multiplier: 1.0,
                                                  constant: CGFloat(self.horizontalSpaceBetweenLabelAndImage))
            self.selfContraints.append(imageLeading)
            
            let centerVertically = NSLayoutConstraint(item: self.rightImageView,
                                                      attribute: .centerY,
                                                      relatedBy: .equal,
                                                      toItem: self,
                                                      attribute: .centerY,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            self.selfContraints.append(centerVertically)
            
            var imageHeight:NSLayoutConstraint?
            if self.rightImageCustomSize != nil {
                imageHeight = NSLayoutConstraint(item: self.rightImageView,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: (self.rightImageCustomSize?.height)! )
                self.imageContraints.append(imageHeight!)
            }
            else {
                imageHeight = NSLayoutConstraint(item: self.rightImageView,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: floor(self.textFont.capHeight) )
                self.imageContraints.append(imageHeight!)
            }
            
            
            let imageAspectRatio = NSLayoutConstraint(item: self.rightImageView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: self.rightImageView,
                                                      attribute: .width,
                                                      multiplier: ((self.rightImage?.size.height)!/(self.rightImage?.size.width)!),
                                                      constant: 0.0)
            self.imageContraints.append(imageAspectRatio)
            
            NSLayoutConstraint.activate([imageLeading, centerVertically, /*imageTrailing,*/ imageHeight!, imageAspectRatio])
        }
    }
    
    public func renderChanges() {
        self.textLabel.text = self.text
        self.textLabel.textColor = self.textColor
        self.textLabel.font = self.textFont
        let minimumTextFrame = self.textLabel.text?.textRect(withFont: self.textLabel.font)
        var height = Double((minimumTextFrame?.size.height)!)
        var width = Double((minimumTextFrame?.size.width)!)
        let oldWidth = width
        if self.rightImage == nil {
            self.rightImageView.image = nil
            self.rightImageView.isHidden = true
        }
        else {
            self.rightImageView.image = self.rightImage
            self.rightImageView.isHidden = false
            var imageSize = CGSize.zero
            if self.rightImageCustomSize != nil {
                height = max(height, Double(self.rightImageCustomSize!.height))
                width =  width + self.horizontalSpaceBetweenLabelAndImage + Double(self.rightImageCustomSize!.width)
                imageSize = self.rightImageCustomSize!
            }
            else {
                height = max(height, Double(self.rightImage!.size.height))
                width =  width + self.horizontalSpaceBetweenLabelAndImage + Double(self.rightImage!.size.width)
                imageSize = self.rightImage!.size
            }
            var imageY = 0.0
            if Double(imageSize.height) < height {
                imageY = (height - Double(imageSize.height))/2
            }
            imageY += self.verticalPadding
            let imageX = self.horizontalPadding + oldWidth + self.horizontalSpaceBetweenLabelAndImage
            self.rightImageView.frame = CGRect(x: CGFloat(imageX), y: CGFloat(imageY), width: imageSize.width, height: imageSize.height)
        }
        height = height + (2 * self.verticalPadding)
        width = width + (2 * self.horizontalPadding)
        
        self._viewSize = CGSize(width: width, height: height)
        
        self.textLabel.frame = CGRect(x: self.horizontalPadding, y: 0.0, width: oldWidth, height: height)
        
        self.layer.borderColor = self.borderColor?.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
    }
    
    init() {
        super.init(frame: .zero)
        self.rightImageView.contentMode = .scaleAspectFit
        self.rightImageView.clipsToBounds = true
        self.addSubview(self.rightImageView)
        self.addSubview(self.textLabel)
        self.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

