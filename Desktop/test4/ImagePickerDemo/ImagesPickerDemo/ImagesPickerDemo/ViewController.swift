//
//  ViewController.swift
//  ImagesPickerDemo
//
//  Created by 郑小燕 on 2017/6/26.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var textCollectionView: UICollectionView!
    var  arrayImage = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textCollectionView.register(UINib.init(nibName: "TestCell", bundle: nil), forCellWithReuseIdentifier: "TestCell")
        let user = User()
       
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == arrayImage.count {
            var config = Configuration()
            config.doneButtonTitle = "完成"
            config.noImagesTitle = "对不起,这儿没有图片"
            config.recordLocation = true
            config.cancelButtonTitle = "取消"
            let imagePicker = ImagePickerController()
            imagePicker.configuration = config
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 10 * 2 - 5 * 3) / 4.0, height: (self.view.bounds.width - 10 * 2 - 5 * 3) / 4.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImage.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TestCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        if indexPath.item < arrayImage.count {
            cell.imgView.image = arrayImage[indexPath.item]
        }
        return cell
    }

}
extension ViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else {
            return
        }
        let lightboxImages = images.map{
        
        return LightboxImage(image: $0)
        }
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        lightbox.dynamicBackground = true
        lightbox.statusBarHidden = true
        imagePicker.present(lightbox, animated: true, completion: nil)
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.arrayImage += images
        print(images)
        
        self.textCollectionView.reloadData()
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
       imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
class User {
    fileprivate var name = "private"
}
extension User{
    var accessPrivate: String {
        return name
    }
}

