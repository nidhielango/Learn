//
//  ImageCollectionViewController.swift
//  Learn
//
//  Created by Nidhi Elango on 2022-08-24.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pictures : Results<Picture>?
    
    override func viewWillAppear(_ animated: Bool) {
        getImages()
    }
    
    func getImages(){
        if let realm = try? Realm(){
            entries = realm.objects(Image.self)
            collectionView.reloadData()
        }
    }

   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = self.images {
            return images.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell {

            
            if let image = images?[indexPath.row]{
                cell.previewImageView.image = image.thumbnail()
                cell.dayLabel.text = picture.entry?.dayString()
                cell.monthYearLabel.text = picture.entry?.monthYearString()
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
}


class imageCell: UICollectionView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    
    
}
