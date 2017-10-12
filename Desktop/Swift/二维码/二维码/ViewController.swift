//
//  ViewController.swift
//  二维码
//
//  Created by 郑小燕 on 2017/7/4.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController {

    var scanningView: ScanningQRCodeView!
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.scanningView = ScanningQRCodeView.init(frame: self.view.frame, outsidelayer: self.view.layer)
        self.view.addSubview(self.scanningView)
        self.setupScanningQRCode()
        //相册授权
        let status: PHAuthorizationStatus = PHAuthorizationStatus.authorized
        if status == .authorized {
            print("授权")
        } else if status == .denied {
        print("拒绝")
        } else if status == .restricted {
        print("拒绝")
        } else if status == .notDetermined {
        print("notDetermined")
        }
        
        
        
        
    }

    func setupScanningQRCode() {
        session = AVCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer.init(session: session)
        //实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.frame = self.view.frame
        // 1、获取摄像设备
        let device: AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if authStatus == .restricted || authStatus == .denied {
            self.alertView()
            return
        }
        
        // 2、创建输入流
        let input: AVCaptureDeviceInput = try!AVCaptureDeviceInput.init(device: device)
        //3、创建输出流
        let output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
  output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
        // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
        output.rectOfInterest = CGRect(x: 0.05, y: 0.2, width: 0.7, height: 0.6)
        session.sessionPreset = AVCaptureSessionPresetHigh
        session.addInput(input)
        session.addOutput(output)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        self.view.layer.insertSublayer(previewLayer, at: 0)
        session.startRunning()
    }
    
    func alertView() {
        let alertAction: UIAlertAction = UIAlertAction.init(title: "好", style: .default) { (alert) in
            print("不登录")
        }
        let alertController: UIAlertController = UIAlertController.init(title: "请在iPhone的\"设置-隐私-相机\"选项中,允许上游新闻访问你的相机", message: nil, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        self.session.stopRunning()
        if metadataObjects.count > 0 {
            let object: AVMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            var string = object.stringValue
            
            
        }
    }
}

