//
//  ViewController.swift
//  Employee Management
//
//  Created by Tazeen on 10/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit
import CoreData


var name: [Int : String] = [:]
var image: [Int : UIImage] = [:]
var designation: [Int : String] = [:]
var dob: [Int : String] = [:]
var gender: [Int : String] = [:]
var hobbies: [Int : String] = [:]
var doj: [String] = []
var id: [Int] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    var objectArray = [String]()
    
    func details()
    {
        
        
    var i = 0
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    let todayDate = formatter.string(from: date)
    for date in doj
    {
            if date == todayDate
            {
               i += 1
            }
    }
    totalLabel.text = String(id.count)
    todayLabel.text = String(i)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return id.count
    }
   
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        
        cell.nameLabel.text = Array(name.values)[indexPath.row]
        cell.profileImage.image = Array(image.values)[indexPath.row]
        cell.genderLabel.text = Array(gender.values)[indexPath.row]
        cell.dobLabel.text = Array(dob.values)[indexPath.row]
        cell.dojLabel.text = doj[indexPath.row]
        cell.idLabel.text = String(id[indexPath.row])
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            fetchRequest.predicate = NSPredicate(format: "id == %i", id[indexPath.row])
            fetchRequest.returnsObjectsAsFaults = false
            do{
                let fetchResults = try context.fetch(fetchRequest)
                if fetchResults.count>0
                {
                    context.delete(fetchResults[0] as! NSManagedObject)
                }
                else
                {
                    // no data
                }
                try context.save()
            }
            catch
            {
                //error
            }
           
            id.remove(at: indexPath.row)
           
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!) as! CustomTableViewCell!;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        let value = Int((currentCell?.idLabel.text)!)
        viewController.passedValue =  value
            print("df")
        self.present(viewController, animated: true , completion: nil)
    }
  
  
  //  @IBAction func prepareForUnwind(segue: UIStoryboardSegue)
    //{
        
    //}
       override func viewDidLoad() {
        super.viewDidLoad()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.returnsObjectsAsFaults = false
        name.removeAll()
        image.removeAll()
        designation.removeAll()
        gender.removeAll()
        doj.removeAll()
        dob.removeAll()
        id.removeAll()
        do
        {
            let results = try context.fetch(request)
            if results.count>0
            {
                for result in results as! [NSManagedObject]
                {
                    if let eid = result.value(forKey: "id") as? Int
                    {
                         id.append(eid)
                        print (eid)
                       
                        if let ename = result.value(forKey: "name") as? String
                        {
                            name.updateValue(ename, forKey: eid)
                            print (ename)
                            if let edesg = result.value(forKey: "designaton") as? String
                            {
                               designation.updateValue(edesg, forKey: eid)
                                if let egend = result.value(forKey: "gender") as? String
                                {
                                    gender.updateValue(egend, forKey: eid)
                                    if let edob = result.value(forKey: "dob") as? String
                                    {
                                        dob.updateValue(edob, forKey: eid)
                                        if let edoj = result.value(forKey: "dateofjoining") as? String
                                        {
                                            doj.append(edoj)
                                            if let photoinData = result.value(forKey: "pi") as? NSData
                                            {
                                                image.updateValue((UIImage(data: photoinData as Data)!), forKey: eid)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
         
                }
                
            }
        }
        catch
        {
            
        }
      
        details()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

