//
//  ViewController.swift
//  Picturegram
//
//  Created by Hitesh Punjabi on 09.02.20.
//  Copyright © 2020 Hitesh Punjabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let context = CIContext()
    var orginal: UIImage?
    
    @IBOutlet var filterButtons: [UIButton]!
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func choosePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func handelSelection(_ sender: UIButton) {
        filterButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations:{
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                
            })
        
        }
        
    }
    
    
    @IBAction func Orginalpic(){
        imageView.image = orginal
    }
    
    @IBAction func applySepia() {
         if orginal == nil {
                    return
            
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }
    
    @IBAction func SavePhoto(_ sender: Any) {
        if orginal == nil {
            return
        }
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        
    }
    
    
    @IBAction func applyNoir(){
        if orginal == nil {
               return
           }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
        
    }
    
    @IBAction func applyColorInvert() {
        if orginal == nil{
            return
        }
        let filter = CIFilter(name: "CIColorInvert")
        display(filter: filter!)
    }
    
    @IBAction func applyVintage(){
        if orginal == nil {
               return
           }
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
        
    }
    
    func display (filter: CIFilter){
        filter.setValue(CIImage(image: orginal!), forKey: kCIInputImageKey)
           let output = filter.outputImage
           imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            orginal = image
        }

    }

}

