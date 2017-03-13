//
//  ThirdViewController.swift
//  Employee Management
//
//  Created by Tazeen on 11/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
    var passedValue: Int!
    var id: Int = 0
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var desgLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var hobbLabel: UILabel!
    @IBOutlet weak var gendLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    func displayDetail()
    {
        idLabel.text = String(id)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            if results.count>0
            {
                for result in results as! [NSManagedObject]
                {
                    
                    if let name = result.value(forKey: "name") as? String
                    {
                        nameLabel.text = name
                    }
                    if let add = result.value(forKey: "address") as? String
                    {
                        addLabel.text = add
                    }
                    
                    if let desg = result.value(forKey: "designaton") as? String
                    {
                        desgLabel.text = desg
                    }
                    if let gend = result.value(forKey: "gender") as? String
                    {
                        gendLabel.text = gend
                    }
                    if let dob = result.value(forKey: "dob") as? String
                    {
                        dobLabel.text = dob
                    }
                    if let hobb = result.value(forKey: "hobbies") as? String
                    {
                        hobbLabel.text = hobb
                    }
                    if let photoinData = result.value(forKey: "pi") as? NSData
                    {
                       let  image = UIImage(data: photoinData as Data)
                       profileImage.image = image
                    }
                  
                }
                
            }
            else
            {
                // no data
            }
           
        }
        catch
        {
            //error
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = passedValue
        displayDetail()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
