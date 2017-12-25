//
//  CropAreaView.swift
//  SOImgaeView
//
//  Created by 董家祎 on 2017/12/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

protocol CropAreaViewDelegate:class {
    func cropFrameChange(scale:CGFloat) -> Void
}
class CropAreaView: UIView {

   weak var delegate:CropAreaViewDelegate?
    
    var minWidth:CGFloat = 0.0
    var minHeight:CGFloat = 0.0
    
    
    var cornerHeight = 6.0
    
    
    private var beyond = 5.0
    
   private var scale:CGFloat = 1.0
    
    private var currentScale:CGFloat = 0.0
    private var cornerWidth = 40.0
    
    var pichSize:CGSize  = CGSize.zero
    
    
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
        
    bottomRight.frame = CGRect(x: Double(self.bounds.size.width - CGFloat(cornerWidth)) + beyond+layerWidth, y: Double(self.bounds.size.height) - layerWidth, width: cornerWidth, height: cornerHeight)
        
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
      
        self.addPanGesture()
        
    }
    
    func addPanGesture() -> Void {
        
        let pan_tf = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        topLeft.addGestureRecognizer(pan_tf)
        
        let pan_lt = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        
        leftTop.addGestureRecognizer(pan_lt)
        
         let pan_tr = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        topRight.addGestureRecognizer(pan_tr)
      
        let pan_rt = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        rightTop.addGestureRecognizer(pan_rt)
        let pan_lb = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        leftBottom.addGestureRecognizer(pan_lb)
        let pan_bl = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        bottomLeft.addGestureRecognizer(pan_bl)
        
         let pan_rb = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        rightBottom.addGestureRecognizer(pan_rb)
        
           let pan_br = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        bottomRight.addGestureRecognizer(pan_br)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureAction(sender:)))
        
        self.addGestureRecognizer(pinch)
        
    }

   @objc func pinchGestureAction (sender:UIPinchGestureRecognizer) -> Void {

        if sender.state == .began {
            self.pichSize = self.frame.size
            
        }
    
        if sender.state == .changed {
            self.resetScaleFactor(scale: sender.scale)
        }
    
    }
    
    
    func resetScaleFactor(scale:CGFloat) -> Void {
        let center = self.center
       
        var width = self.pichSize.width * scale
        var height = self.pichSize.height * scale
        
        width = width < minWidth ? minHeight :  (width > minWidth * 2.0 ? minWidth * 2.0 : width)
        
        height = height < minHeight ? minHeight : (height > minHeight * 2.0 ? minHeight * 2.0 : height)
        
        
        self.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        self.center = center
       // self.updateFrame()
        self.delegate?.cropFrameChange(scale: 0.0)
        
        
     
        
    }
    @objc func panGestureAction(sender:UIPanGestureRecognizer) -> Void {
        
   
        
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        for (_,view) in self.subviews.enumerated() {
            if view.frame.contains(point) {
                return view
            }
        }
        if self.bounds.contains(point) {
            return self
        }


        return nil
    }
}
