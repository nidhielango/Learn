//
//  LearnTableViewController.swift
//  Learn
//
//  Created by Nidhi Elango on 2022-08-24.
//

import UIKit
import RealmSwift

class LearnTableViewController: UITableViewController {
    
   @IBOutlet weak var whiteAddButton: UIButton!
   @IBOutlet weak var whiteCameraButton: UIButton!
    
    var entries : Results<Entry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteAddButton.imageView?.contentMode = .scaleAspectFit
        whiteCameraButton.imageView?.contentMode = .scaleAspectFit
        
        
    }
    
    func getEntries() {
        if let realm = try? Realm() {
            entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEntries()
    }

    @IBAction func CameraTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNew", sender: "camera")
    }
    
    @IBAction func PlusTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNew", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNew" {
            if let text = sender as? String {
                if text == "camera" {
                    let createVC = segue.destination as? CreateNotesViewController
                    createVC?.startWithCamera = true 
                }
            }
        }
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let entries = self.entries {
            return entries?.count} else {
                return 0
            }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: <#T##IndexPath#>) as? NotesCell {
            
            if let entry = entries?[indexPath.row]{
                cell.previewTextLabel.text = entry.text
                if let image = entry.pictures.first?.thumbnail(){
                    cell.imageViewWidth.constant = 100
                    cell.ImageView.image = image
                } else {
                    cell.imageViewWidth.constant = 0
                }
                cell.monthLabel.text = entry.monthString()
                cell.dayLabel.text = entry.dayString()
                cell.yearLabel.text = entry.yearString()
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAtindexPath: IndexPath) -> CGFloat{
        return 100
    }
    
}


class NotesCell : UITableViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
}
