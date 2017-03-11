//
//  ViewController.swift
//  Employee Management
//
//  Created by Tazeen on 10/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit
import CoreData


var name: [String] = []
var image: [UIImage] = []
var designation: [String] = []
var dob: [String] = []
var gender: [String] = []
var hobbies: [String] = []
var doj: [String] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return name.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
       
        cell.nameLabel.text = name[indexPath.row]
        cell.profileImage.image = image[indexPath.row]
        cell.genderLabel.text = gender[indexPath.row]
        cell.dobLabel.text = dob[indexPath.row]
        cell.dojLabel.text = doj[indexPath.row]
        return (cell)
    }
    
   
    
        
    
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue)
    {
        
    }
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
        do
        {
            let results = try context.fetch(request)
            if results.count>0
            {
                for result in results as! [NSManagedObject]
                {
                    
                    if let ename = result.value(forKey: "name") as? String
                    {
                        name.append(ename)
                        
                    }
                    
                    if let edesg = result.value(forKey: "designaton") as? String
                    {
                        designation.append(edesg)
                        
                    }
                    if let egend = result.value(forKey: "gender") as? String
                    {
                        gender.append(egend)
                        
                    }
                    if let edob = result.value(forKey: "dob") as? String
                    {
                        dob.append(edob)
                        
                    }
                    if let edoj = result.value(forKey: "dateofjoining") as? String
                    {
                        doj.append(edoj)
                        
                    }
                    if let photoinData = result.value(forKey: "pi") as? NSData
                    {
                        image.append(UIImage(data: photoinData as Data)!)
                    }
                    
                }
            }
        }
        catch
        {
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

