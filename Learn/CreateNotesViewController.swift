//
//  CreateNotesViewController.swift
//  Learn
//
//  Created by Nidhi Elango on 2022-08-24.
//

import UIKit
import RealmSwift


class CreateNotesViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
   
    @IBOutlet weak var setDateButton: UIButton!

   // @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var notesTextView: UITextView!
    

    var imagePicker = UIImagePickerController()
    var images: [UIImage] = []
    var startWithCamera = false
    var entry = Entry()
    
    override func viewWillAppear(_ animated: Bool) {
        updateDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if startWithCamera {
            startWithCamera = false
            cameraClicked("")
        }
    }
    
    func updateDate() {
        navBar.topItem?.title = entry.dateString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object:nil)
        
        imagePicker.delegate = self
        
    }
    
    @IBAction func setDateClicked(_ sender: Any) {
        notesTextView.isHidden = false
        datePicker.isHidden = true
        setDateButton.isHidden = true
        entry.date = datePicker.date
        updateDate()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let realm = try? Realm(){
            entry.text = notesTextView.text
            for image in images {
                let picture = Picture()
            }
        }
    }

    @IBAction func calendarClicked(_ sender: Any) {
        notesTextView.isHidden = true
        datePicker.isHidden = false
        setDateButton.isHidden = false
        datePicker.date = entry.date
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            images.append(chosenImage)
            
            // image properties
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
            imageView.image = chosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true){
                // change image
            }
        }
    }
    
   
    
    @objc func KeyboardWillHide(notification:Notification){
        changeKeyboardHeight(notification:notification)
        
    }
    
    @objc func KeyboardWillShow(notification:Notification){
        changeKeyboardHeight(notification:notification)
        
    }
    

    func changeKeyboardHeight(notification:Notification){
        if let keyboardFrame =
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            _ = keyboardFrame.cgRectValue.height
            //bottomConstraint.constant = keyHeight + 10
            
        }
    }
     

}
