//
//  Models.swift
//  Learn
//
//  Created by Nidhi Elango on 2022-08-29.
//

import UIKit
import RealmSwift
import Toucan


class Entry : Object {
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    let pictures = List<Picture>()
}

class Picture : Object {
    @objc dynamic var fullImage = ""
    @objc dynamic var thumbnail = ""
    @objc dynamic var entry : Entry?
    
    convenience init(image : UIImage) {
        self.init()
        fullImage = imageToURLString(image: image)
        if let smallImage = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .crop).image {
            thumbnail
        }
    }
    
    
    func imageToURLString(image:UIImage) -> String{
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let fileName = UUID().uuidString + ".png"
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path.appendPathComponent(fileName)
            try? imageData.write(to: path)
            return fileName
        }
        return ""
    }
    
    func Image() -> UIImage {
        
    }
    
    func thumbnail() -> UIImage {
        
    }
    
    func imageWithFile(fileName: String) {
        
    }
}
