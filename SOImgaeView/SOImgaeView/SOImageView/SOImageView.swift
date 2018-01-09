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
    var cropImage:UIImage = UIImage(named: "IMG_3398")!
    var croCenter = CGPoint.zero
    
    var imageRatio:CGFloat{
        return cropImage.size.width / cropImage.size.height
    }
    var selfRatio:CGFloat {
        
        return self.bounds.size.width / self.bounds.size.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.stup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.stup()
    }
    func resetImageView() -> Void {
        
        if imageRatio > selfRatio {
            let paddingTopBottom = floor((self.bounds.size.height - self.bounds.size.width / imageRatio) / 2.0)
            cropImageView.frame = CGRect(x: 0, y: paddingTopBottom, width: self.bounds.size.width, height: floor(self.bounds.size.width / imageRatio))
            
            
        }else{
            let paddingLeftRight = floor((self.bounds.size.width - self.bounds.size.height * imageRatio) / 2.0)
            cropImageView.frame = CGRect(x: paddingLeftRight, y: 0, width: floor(self.bounds.size.height * imageRatio), height: self.bounds.size.height)
            
        }
        shadeView.frame = cropImageView.bounds
         croAreaView.frame = CGRect(x: (CGFloat(cropImageView.frame.size.width) - CGFloat(cro_width)) / 2.0, y: (CGFloat(cropImageView.frame.size.height) - CGFloat(cro_height)) / 2.0, width: CGFloat(cro_width), height: CGFloat(cro_height))
       
            self.resetCropArea()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.resetImageView()
        
    }
    func stup() -> Void {
        
        
        cropImageView.frame = self.bounds
        cropImageView.image = cropImage
        cropImageView.isUserInteractionEnabled = true
        cropImageView.contentMode = .scaleToFill
        self.addSubview(cropImageView)
        
        
        shadeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        cropImageView.addSubview(shadeView)
    
        
        croAreaView.minWidth    = CGFloat(cro_width)
        croAreaView.minHeight   = CGFloat(cro_width)
        croAreaView.delegate = self
        
        cropImageView.addSubview(croAreaView)
 
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panCropAreaView(sender:)))
        croAreaView.addGestureRecognizer(panGestureRecognizer)
    
        
        
    }
    @objc func panCropAreaView(sender:UIPanGestureRecognizer) -> Void {
      
        switch sender.state {
        case .began:
            croCenter = self.croAreaView.center
            break;
        case .changed:
            let translation = sender.translation(in: self.cropImageView)
            let willCenter = CGPoint(x: croCenter.x + translation.x, y: croCenter.y + translation.y)
            
            let centerMinX = croAreaView.frame.size.width / 2.0
            let centerMaxX = self.cropImageView.frame.size.width - croAreaView.frame.size.width / 2.0
            let centerMinY = croAreaView.frame.size.height / 2.0
            let centerMaxY = cropImageView.frame.size.height - croAreaView.frame.size.height / 2.0
            croAreaView.center = CGPoint(x: min(max(centerMinX, willCenter.x), centerMaxX), y: min(max(centerMinY, willCenter.y), centerMaxY))
            self.resetCropArea()
            break
        default:
            break
        }
    
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
 
    func test() -> UIImage {
        
        let scale = self.cropImageView.frame.size.width / cropImage.size.width
        
        let rect = CGRect(x: self.croAreaView.frame.minX / scale, y: self.croAreaView.frame.minY / scale, width: self.croAreaView.frame.width / scale, height: self.croAreaView.frame.size.height / scale)
      
        
        let imageRef = cropImage.cgImage?.cropping(to:rect)
        
       
        return UIImage(cgImage: imageRef!)
        
    }
    
    

}
extension SOImageView:CropAreaViewDelegate{
    func cropFrameChange(scale: CGFloat) {
        self.resetCropArea()
    }
}
