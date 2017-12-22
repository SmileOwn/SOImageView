//
//  SOImageView.swift
//  SOImgaeView
//
//  Created by 董家祎 on 2017/12/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

class SOImageView: UIView {

    var cropImageView:UIImageView = UIImageView()
    var shadeView:UIView      = UIView()
    var croAreaView:CropAreaView = CropAreaView()
    
    var cro_width = 100.0
    var cro_height = 100.0
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.stup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.stup()
    }
    func stup() -> Void {
        cropImageView.frame = self.bounds
        cropImageView.isUserInteractionEnabled = true
        cropImageView.image = UIImage(named: "IMG_3398")
        cropImageView.contentMode = .scaleAspectFit
        self.addSubview(cropImageView)
        
        shadeView.frame = self.bounds
        shadeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        cropImageView.addSubview(shadeView)
        
        croAreaView.frame = CGRect(x: 0, y: 0, width: cro_width, height: cro_height)
        
        
        cropImageView.addSubview(croAreaView)
        croAreaView.center = cropImageView.center
       
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panCropAreaView(sender:)))
        croAreaView.addGestureRecognizer(panGestureRecognizer)
        
        self.resetCropArea()
        
    }
    @objc func panCropAreaView(sender:UIPanGestureRecognizer) -> Void {
      
        let translation = sender.translation(in: self.cropImageView)
     
        var point = CGPoint(x: (sender.view?.center.x)! + translation.x, y: (sender.view?.center.y)! + translation.y)
        
        point.y = max((sender.view?.frame.size.height)!/2, point.y)
        
        point.y = min(self.cropImageView.frame.size.height - (sender.view?.frame.size.height)! / 2,point.y)
        
        point.x = max((sender.view?.frame.size.width)! / 2, point.x)
        
        point.x = min(self.cropImageView.frame.size.width - (sender.view?.frame.size.width)! / 2,point.x)
        
        
        sender.view?.center = point
        
        
        sender.setTranslation(CGPoint.zero, in: self.cropImageView)
        
        
        self.resetCropArea()
        
        
        
    }
    func resetCropArea() -> Void {
        let path = UIBezierPath(rect: cropImageView.bounds)
        let clearPath = UIBezierPath(rect:croAreaView.frame).reversing()
        
        path.append(clearPath)
        var shapeLayer = shadeView.layer.mask as? CAShapeLayer
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shadeView.layer.mask = shapeLayer
        }
        shapeLayer?.path = path.cgPath
    }
    
    

}
