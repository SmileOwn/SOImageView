//
//  CropAreaView.swift
//  SOImgaeView
//
//  Created by 董家祎 on 2017/12/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

class CropAreaView: UIView {

    var cornerHeight = 6.0
   private var beyond = 5.0
    
    private var cornerWidth = 40.0
    
    var layerWidth = 0.5
    
    var topLeft:UIView = UIView()
    var leftTop:UIView = UIView()
    var topRight:UIView = UIView()
    var rightTop:UIView = UIView()
    var leftBottom:UIView = UIView()
    var bottomLeft:UIView = UIView()
    var rightBottom:UIView = UIView()
    var bottomRight:UIView = UIView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.stup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.stup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    func updateFrame() -> Void {
        
    topLeft.frame = CGRect(x: -beyond, y: -(cornerHeight-layerWidth), width: cornerWidth, height: cornerHeight)
        
    leftTop.frame = CGRect(x: -(beyond), y: 0, width: cornerHeight, height: cornerWidth)
        
    topRight.frame = CGRect(x: Double(self.bounds.size.width - CGFloat(cornerWidth)) + beyond+layerWidth, y: -(cornerHeight-layerWidth), width: cornerWidth, height: cornerHeight)
        
    rightTop.frame = CGRect(x: Double(self.bounds.size.width)-layerWidth, y: 0, width: cornerHeight, height: cornerWidth)
        
     leftBottom.frame = CGRect(x: -beyond, y: Double(self.bounds.size.height)-cornerWidth+beyond, width: cornerHeight, height: cornerWidth)
        
    bottomLeft.frame = CGRect(x: -beyond, y: Double(self.bounds.size.height) - layerWidth, width: cornerWidth, height: cornerHeight)
        
    rightBottom.frame = CGRect(x: Double(self.bounds.size.width) - layerWidth, y: Double(self.bounds.size.height) - cornerWidth + beyond, width: cornerHeight, height: cornerWidth)
        
    bottomRight.frame = CGRect(x:  Double(self.bounds.size.width - CGFloat(cornerWidth)), y: Double(self.bounds.size.height) - layerWidth, width: cornerWidth, height: cornerHeight)
        
    }
    func stup() -> Void {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = CGFloat(layerWidth)
        topLeft.backgroundColor = UIColor.white
        self.addSubview(topLeft)
        
        leftTop.backgroundColor = UIColor.white
        self.addSubview(leftTop)
        
        topRight.backgroundColor = UIColor.white
        self.addSubview(topRight)
        
        rightTop.backgroundColor = UIColor.white
        self.addSubview(rightTop)
        
        leftBottom.backgroundColor = UIColor.white
        self.addSubview(leftBottom)
        bottomLeft.backgroundColor = UIColor.white
        self.addSubview(bottomLeft)
        
        rightBottom.backgroundColor = UIColor.white
        self.addSubview(rightBottom)
        
        bottomRight.backgroundColor = UIColor.white
        self.addSubview(bottomRight)
    }

}
