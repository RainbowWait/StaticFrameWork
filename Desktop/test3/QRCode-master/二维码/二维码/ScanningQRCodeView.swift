//
//  ScanningQRCodeView.swift
//  二维码
//
//  Created by 郑小燕 on 2017/7/4.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit
import AVFoundation

class ScanningQRCodeView: UIView {
    var basedLayer: CALayer!
    let scanContent_Y: CGFloat = UIScreen.main.bounds.size.height * 0.24
    let scanContent_X: CGFloat = UIScreen.main.bounds.size.width * 0.15
    let animation_line_H: CGFloat = 12
    var animation_line: UIImageView!
    var timer: Timer!
    let timer_animation_Duration: TimeInterval = 0.05
    let scanBorderOutsideViewAlpha: CGFloat = 0.4
    
    var device:AVCaptureDevice!
    var flag = true
    
    
    
    
    
    
    
    init(frame: CGRect, outsidelayer: CALayer) {
        self.basedLayer = outsidelayer
        super.init(frame: frame)
        self.setupScanningQRCodeEdging()
    }
    
//    convenience init(frame: CGRect, outside: CALayer) {
//        self.init(frame: frame, outsidelayer: outside)
//    }
    func setupScanningQRCodeEdging() {
        let scanContent_layer: CALayer = CALayer()
        let scanContent_layerW: CGFloat = UIScreen.main.bounds.width - 2 * scanContent_X
        let scanContent_layerH: CGFloat = scanContent_layerW
        scanContent_layer.frame = CGRect(x: scanContent_X, y: scanContent_Y, width: scanContent_layerW, height: scanContent_layerH)
        scanContent_layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        scanContent_layer.borderWidth = 0.7
        scanContent_layer.backgroundColor = UIColor.clear.cgColor
        self.basedLayer.addSublayer(scanContent_layer)
        
        //扫面动画添加
        self.animation_line = UIImageView.init(image: UIImage.init(named: "QRCodeLine"))
        self.animation_line.frame = CGRect(x: scanContent_X * 0.5, y: scanContent_Y, width: self.bounds.width - scanContent_X, height: animation_line_H)
        self.addSubview(self.animation_line)
        
        //添加定时器
        self.timer = Timer.scheduledTimer(timeInterval: timer_animation_Duration, target: self, selector: #selector(animation_line_action), userInfo: nil, repeats: true)
        
        //扫面外部View的创建
        let top_layer: CALayer = CALayer()
        let top_layerX: CGFloat = 0
        let top_layerY: CGFloat = 0
        let top_layerW = self.frame.size.width
        let top_layerH: CGFloat = scanContent_Y
        top_layer.frame = CGRect(x: top_layerX, y: top_layerY, width: top_layerW, height: top_layerH)
        top_layer.backgroundColor = UIColor.black.withAlphaComponent(scanBorderOutsideViewAlpha).cgColor
        self.layer.addSublayer(top_layer)
        
        
        //左侧layer的创建
        let left_layer: CALayer = CALayer()
        let left_layerX: CGFloat = 0
        let left_layerY: CGFloat = scanContent_Y
        let left_layerW = scanContent_X
        let left_layerH = scanContent_layerH
        left_layer.frame = CGRect(x: left_layerX, y: left_layerY, width: left_layerW, height: left_layerH)
        left_layer.backgroundColor = UIColor.black.withAlphaComponent(scanBorderOutsideViewAlpha).cgColor
        self.layer.addSublayer(left_layer)
        
        //右侧layer的创建
        let right_layer: CALayer = CALayer()
        let right_layerX: CGFloat = scanContent_layer.frame.maxX
        let right_layerY: CGFloat = scanContent_Y
        let right_layerW: CGFloat = scanContent_X
        let right_layerH: CGFloat = scanContent_layerH
        right_layer.frame = CGRect(x: right_layerX, y: right_layerY, width: right_layerW, height: right_layerH)
        right_layer.backgroundColor = UIColor.black.withAlphaComponent(scanBorderOutsideViewAlpha).cgColor
        self.layer.addSublayer(right_layer)
        
        //下面layer的创建
        let bottom_layer: CALayer = CALayer()
        let bottom_layerX: CGFloat = 0
        let bottom_layerY: CGFloat = scanContent_layer.frame.maxY
        let bottom_layerW = self.frame.size.width
        let bottom_layerH = self.frame.size.height - bottom_layerY
        bottom_layer.frame = CGRect(x: bottom_layerX, y: bottom_layerY, width: bottom_layerW, height: bottom_layerH)
        bottom_layer.backgroundColor = UIColor.black.withAlphaComponent(scanBorderOutsideViewAlpha).cgColor
        self.layer.addSublayer(bottom_layer)
        
        //提示label
        let promptLabel: UILabel = UILabel.init()
        promptLabel.backgroundColor = UIColor.clear
        let promptLabelX: CGFloat = 0
        let promptLabelY: CGFloat = scanContent_layer.frame.maxY + 30
        let promptLabelW = self.frame.size.width
        let promptLabelH: CGFloat = 25
        promptLabel.frame = CGRect(x:promptLabelX , y: promptLabelY, width: promptLabelW, height: promptLabelH)
        promptLabel.textAlignment = .center
        promptLabel.font = UIFont.boldSystemFont(ofSize: 13)
        promptLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        promptLabel.text = "将二维码/条码放入框内, 即可自动扫描"
        self.addSubview(promptLabel)
        
        let light_button: UIButton = UIButton.init(type: .custom)
        let light_buttonX: CGFloat = 0
        let light_buttonY: CGFloat = promptLabel.frame.maxY + scanContent_X * 0.5
        let light_buttonW = self.frame.size.width
        let light_buttonH: CGFloat = 25
        light_button.frame = CGRect(x: light_buttonX, y: light_buttonY, width: light_buttonW, height: light_buttonH)
        light_button.setTitle("打开照明灯", for: .normal)
        light_button.setTitle("关闭照明灯", for: .selected)
    light_button.setTitleColor(promptLabel.textColor, for: .normal)
        light_button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        light_button.addTarget(self, action: #selector(light_buttonAction(button:)), for: .touchUpInside)
        self.addSubview(light_button)
        
        //左上侧的image
        let margin: CGFloat = 7
        let left_image =  UIImage.init(named: "QRCodeTopLeft")
        let left_imageView: UIImageView = UIImageView.init(image: left_image)
        let left_imageViewX = scanContent_layer.frame.minX - (left_image?.size.width ?? 0.0) * 0.5 + margin
        let left_imageViewY: CGFloat = scanContent_layer.frame.minY - (left_image?.size.width ?? 0.0) * 0.5 + margin
        let left_imageViewW = left_image?.size.width
        let left_imageViewH: CGFloat = (left_image?.size.height)!
        left_imageView.frame = CGRect(x: left_imageViewX, y: left_imageViewY, width: left_imageViewW!, height: left_imageViewH)
        left_imageView.image = left_image
        self.basedLayer.addSublayer(left_imageView.layer)
        
        //右上侧的image
        let right_image =  UIImage.init(named: "QRCodeTopRight")
        let right_imageView: UIImageView = UIImageView.init(image: right_image)
        let right_imageViewX = scanContent_layer.frame.maxX - (right_image?.size.width)! * 0.5 - margin
        let right_imageViewY: CGFloat = left_imageView.frame.origin.y
        let right_imageViewW = left_image?.size.width
        let right_imageViewH: CGFloat = (left_image?.size.height)!
        right_imageView.frame = CGRect(x: right_imageViewX, y: right_imageViewY, width: right_imageViewW!, height: right_imageViewH)
        right_imageView.image = right_image
        self.basedLayer.addSublayer(right_imageView.layer)
        
        //左下侧的image
        let left_image_down =  UIImage.init(named: "QRCodebottomLeft")
        let left_imageView_down: UIImageView = UIImageView.init(image: left_image_down)
        let left_imageView_downX = left_imageView.frame.origin.x
        let left_imageView_downY: CGFloat = scanContent_layer.frame.maxY - (left_image_down?.size.width)! * 0.5 - margin
        let left_imageView_downW = left_image?.size.width
        let left_imageView_downH: CGFloat = (left_image?.size.height)!
        left_imageView_down.frame = CGRect(x: left_imageView_downX, y: left_imageView_downY, width: left_imageView_downW!, height: left_imageView_downH)
        left_imageView_down.image = left_image_down
        self.basedLayer.addSublayer(left_imageView_down.layer)
        
        
        
        //右下侧的image
        let right_image_down =  UIImage.init(named: "QRCodebottomRight")
        let right_imageView_down: UIImageView = UIImageView.init(image: right_image_down)
        let right_imageView_downX = right_imageView.frame.origin.x
        let right_imageView_downY: CGFloat = left_imageView_down.frame.origin.y
        let right_imageView_downW = left_image?.size.width
        let right_imageView_downH: CGFloat = (left_image?.size.height)!
        right_imageView_down.frame = CGRect(x: right_imageView_downX, y: right_imageView_downY, width: right_imageView_downW!, height: right_imageView_downH)
        right_imageView_down.image = right_image_down
        self.basedLayer.addSublayer(right_imageView_down.layer)
        

        
        
        
    
        
    }
    
    func light_buttonAction(button: UIButton) {
        button.isSelected = !button.isSelected
        turnOnLight(on: button.isSelected)

    }
    
    func turnOnLight(on: Bool) {
        self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if self.device.hasTorch {
           try?self.device.lockForConfiguration()
            if on {
                device.torchMode = .on
            } else {
                device.torchMode = .off
            }
            device.unlockForConfiguration()
        }
    }
    
    func animation_line_action() {
        var frame: CGRect = self.animation_line.frame
       
        if flag {
            frame.origin.y = scanContent_Y
            flag = false
            UIView.animate(withDuration: timer_animation_Duration, animations: { 
                frame.origin.y += 5
                self.animation_line.frame = frame
            })
        } else {
            if animation_line.frame.origin.y >= scanContent_Y {
                let scanContent_MaxY = scanContent_Y + self.frame.size.width - 2 * scanContent_X
                if self.animation_line.frame.origin.y >= scanContent_MaxY - 10 {
                    frame.origin.y = scanContent_Y
                    self.animation_line.frame = frame
                    flag = true
                } else {
                UIView.animate(withDuration: timer_animation_Duration, animations: { 
                    frame.origin.y += 5
                    self.animation_line.frame = frame
                })
                    
                }
                
            } else {
                flag = !flag
            }
            
            
        }
    }
    
    func removeTimer() {
        self.timer.invalidate()
        self.animation_line.removeFromSuperview()
        self.animation_line = nil
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
