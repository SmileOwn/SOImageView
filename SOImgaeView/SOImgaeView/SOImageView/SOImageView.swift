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
        cropImageView.image = UIImage(named: "IMG_3398")
        cropImageView.contentMode = .scaleAspectFit
        self.addSubview(cropImageView)
        
        shadeView.frame = self.bounds
        shadeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        cropImageView.addSubview(shadeView)
        
        croAreaView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
        cropImageView.addSubview(croAreaView)
        croAreaView.center = cropImageView.center
       
        let path = UIBezierPath(rect: cropImageView.bounds)
        let clearPath = UIBezierPath(rect: croAreaView.frame).reversing()
        path.append(clearPath)
        var shapeLayer = shadeView.layer.mask as? CAShapeLayer
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
              shadeView.layer.mask = shapeLayer
        }
        shapeLayer?.path = path.cgPath
        
      
        
      
        
    }
    
    

}
