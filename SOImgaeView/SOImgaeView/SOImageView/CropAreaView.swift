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
    var pichCenter:CGPoint = CGPoint.zero
    
    
    var layerWidth = 0.5
    
    var topLeft:UIView = UIView()
    var leftTop:UIView = UIView()
    var topRight:UIView = UIView()
    var rightTop:UIView = UIView()
    var leftBottom:UIView = UIView()
    var bottomLeft:UIView = UIView()
    var rightBottom:UIView = UIView()
    var bottomRight:UIView = UIView()
    
    var cornerLTView = UIView()
    
    var cornerRTView = UIView()
    
    var cornerLBView = UIView()
    
    var cornerRBView = UIView()
    
    
    
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
        
        
        cornerLTView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cornerRTView.frame = CGRect(x: self.bounds.size.width-40, y: 0, width: 40, height: 40)
        
        cornerLBView.frame = CGRect(x: 0, y: self.bounds.size.height - 40, width: 40, height: 40)
        cornerRBView.frame = CGRect(x: self.bounds.size.width-40, y: self.bounds.size.width-40, width: 40, height: 40)
        
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
      
        self.addSubview(cornerLBView)
        self.addSubview(cornerLTView)
        self.addSubview(cornerRTView)
        self.addSubview(cornerRBView)
        
        self.addPanGesture()
        
    }
    
    func addPanGesture() -> Void {
        
        
        //左上
        let pan_tf = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        cornerLTView.tag = 1001
        cornerLTView.addGestureRecognizer(pan_tf)
        
         let pan_tr = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        cornerRTView.tag = 1002
        cornerRTView.addGestureRecognizer(pan_tr)
      
        let pan_lb = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        cornerLBView.tag = 1003
        cornerLBView.addGestureRecognizer(pan_lb)
        
        
        let pan_rb = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        
        cornerRBView.addGestureRecognizer(pan_rb)
        
        
        
    }


    @objc func panGestureAction(sender:UIPanGestureRecognizer) -> Void {
        let offPoint = sender.translation(in: self)

        
        if sender.state == .began {
            self.pichSize = self.frame.size
            self.pichCenter = self.center
          
        }
        if sender.state == .changed {
            var x  = offPoint.x
            var y = offPoint.y
            
            let centerAvg = (offPoint.x + offPoint.y) / 2
            
            if sender.view?.tag == 1001 {
                x = -(offPoint.x)
                y = -(offPoint.y)
            }
            
            if sender.view?.tag == 1002 || sender.view?.tag == 1003{
                if offPoint.x > 0 && offPoint.y < 0{
                    x = -(offPoint.x)
                    y = offPoint.y
                }
                
                if offPoint.x < 0 && offPoint.y > 0{
                    x = offPoint.x
                    y = -(offPoint.y)
                }
               
               
            }

            
            let avg = (x + y) / 2
            var width = self.pichSize.width + avg
            var height = self.pichSize.height + avg
            
            width = width < minWidth ? minHeight :  (width > minWidth * 2.0 ? minWidth * 2.0 : width)
            
            height = height < minHeight ? minHeight : (height > minHeight * 2.0 ? minHeight * 2.0 : height)
            
            
            self.frame.size = CGSize(width: width, height: height)
            
            if sender.view?.tag == 1003 || sender.view?.tag == 1002 {
                self.center = CGPoint(x: self.pichCenter.x + offPoint.x/2, y: self.pichCenter.y + offPoint.y/2)
               
            }else{
                
                self.center = CGPoint(x: self.pichCenter.x + centerAvg/2, y: self.pichCenter.y + centerAvg / 2)
            }
            
            self.delegate?.cropFrameChange(scale: 0.0)
        }
        
        
        
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
