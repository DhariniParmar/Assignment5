//
//  TouristPlacesTableViewController.swift
//  Assignment5
//
//  Created by Student on 2018-03-12.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

class TouristPlacesTableViewController: UITableViewController, AddPlacesVCDelegate {
   

    
    @IBOutlet weak var add: UIBarButtonItem!
    var managedObjectContext: NSManagedObjectContext!
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = places[indexPath.row].placename

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let place = places.remove(at: indexPath.row)
            managedObjectContext.delete(place)
            do {
                try managedObjectContext.save()
            } catch {
                print("Core data saving error")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
            
    }
    

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as! AddPlacesTableViewController
        controller.managedObjectContext = managedObjectContext
        controller.delegate = self
        if segue.identifier == "EditItem" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let place = places[indexPath.row]
                controller.place = place
                controller.editPlace = true
            }
        }
    
    
    }
    
    func PlaceVC(_ controller: AddPlacesTableViewController, didAddPlace place: Place) {
        let row = places.count;
        places.append(place)
        let indexPath = IndexPath(row: row, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func PlaceVC(_ controller: AddPlacesTableViewController, didEditPlace place: Place) {
        if let row = places.index(of: place) {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.textLabel?.text = place.placename
          
        }
    }

    func PlaceVCCancel() {
        navigationController?.popViewController(animated: true)
    }
}
    



