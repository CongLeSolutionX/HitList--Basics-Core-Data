//
//  ViewController.swift
//  HitList
//
//  Created by Cong Le on 3/30/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    // MARK: IBOutlet/Properties
    @IBOutlet weak var tableView: UITableView!
    
    var people: [NSManagedObject] = []
    // MARK: View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a managed object context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetching the objects on Core Data that matched entity named Person
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        // returns an array of managed objects meeting the criteria specified by the fetch request
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Cound not fetch. \(error), \(error.userInfo)")
        }
    }
    // MARK: IBAction
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)

         let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in

           guard let textField = alert.textFields?.first,
             let nameToSave = textField.text else {
               return
           }

           self.save(name: nameToSave)
           self.tableView.reloadData()
         }

         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
         alert.addTextField()
         alert.addAction(saveAction)
         alert.addAction(cancelAction)

         present(alert, animated: true)
    }
    // MARK: Methods
    // save the persistent data on disk
    func save(name: String) {
        // create a managed object context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
         // create a new managed object and insert the new managed object into the managed object context
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
       
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        // set the name attribute using KVC
        person.setValue(name, forKey: "name")
        
        // commit your changes to `person` and save to disk by calling `save` on the managed object context.
        // Since `save` can throw error, we use `try` keyword in a `do-catch` block
        do {
            try managedContext.save()
            //insert the new managed object into the `people`array so it shows up when the table view reloads
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // get the name attribute from the NSManagedObject 
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
}
