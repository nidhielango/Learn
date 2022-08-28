//
//  CreateNotesViewController.swift
//  Learn
//
//  Created by Nidhi Elango on 2022-08-24.
//

import UIKit

class CreateNotesViewController: UIViewController {
    
   
    @IBOutlet weak var setDateButton: UIButton!

   // @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    var date = Date()
    
    override func viewWillAppear(_ animated: Bool) {
        updateDate()
    }
    
    func updateDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        navBar.topItem?.title = formatter.string(from: date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object:nil)
        
    }
    
    @IBAction func setDateClicked(_ sender: Any) {
        notesTextView.isHidden = false
        datePicker.isHidden = true
        setDateButton.isHidden = true
        date = datePicker.date
        updateDate()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
    }
    
   
    
    @IBAction func saveClicked(_ sender: Any) {
    }

    @IBAction func calendarClicked(_ sender: Any) {
        notesTextView.isHidden = true
        datePicker.isHidden = false
        setDateButton.isHidden = false
        datePicker.date = date
        
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
            let keyHeight = keyboardFrame.cgRectValue.height
            //bottomConstraint.constant = keyHeight + 10
            
        }
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
