//
//  AddPlacesTableViewController.swift
//  Assignment5
//
//  Created by Student on 2018-03-12.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

protocol  AddPlacesVCDelegate:class {
    
    func PlaceVC(_ controller: AddPlacesTableViewController, didAddPlace place:Place)
    func PlaceVC(_ controller: AddPlacesTableViewController, didEditPlace place:Place)
    func PlaceVCCancel()
    
    
}

class AddPlacesTableViewController: UITableViewController {
    
    
    @IBOutlet weak var placeNameTextField: UITextField!
    
    @IBOutlet weak var locationNameTextField: UITextField!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    weak var delegate: AddPlacesVCDelegate?
    var managedObjectContext: NSManagedObjectContext!
    
    var place:Place?
    
    var editPlace : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        if !editPlace {
            place = Place(context: managedObjectContext)
        }
        place!.placename = placeNameTextField.text
        place!.placelocation = locationNameTextField.text
        place!.rating = sliderValue.value
        do {
            try managedObjectContext.save()
        } catch {
            print("Core Data Error")
        }
        if editPlace {
            delegate?.PlaceVC(self, didEditPlace: place!)
        } else {
            delegate?.PlaceVC(self, didAddPlace: place!)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        
        delegate?.PlaceVCCancel()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
   /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
