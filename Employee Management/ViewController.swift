//
//  ViewController.swift
//  Employee Management
//
//  Created by Tazeen on 10/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//
// This is the main screen of the app

import UIKit
import CoreData
import Foundation

var name: [String] = []
var image: [UIImage] = []
var designation: [String] = []
var dob: [String] = []
var gender: [String] = []
var hobbies: [Int : String] = [:]
var doj: [String] = []
var id: [Int] = []
//main dictionary containing details of all employee's
var emp: [Int: [String]] = [:]
//contains sorted employees
var sortedEmp: [Int: [String]] = [:]
//to check if sorting is on or not
var sortSelected = 0
//filtered employees
var filterid:[Int] = []
var filterEmp: [Int : [String]] = emp

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate  {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    var objectArray = [String]()
    var searchController = UISearchController()
    var arrayfilter = [String]()
    //to exit search
    @IBAction func exit(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController, animated: true , completion: nil)
    }
    // to display monitor values
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
    //gives out filtered array
    //user can search on the basis of all employee's details
    //for each employee it takes in the vlue array from emp disctionary and checks if it contains the user input
    func filterResult(searchText: String)
    {
       filterEmp.removeAll()
        filterid.removeAll()
        for (k,v) in emp
        {
            arrayfilter = v
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
            let array = (self.arrayfilter as NSArray).filtered(using: searchPredicate)
            let values = array as! [String]
            if values .isEmpty
            {
                print("no match")
            }
            else
            {
                    filterid.append(k)
            }
        }
        let mySet = Set<Int>(filterid)
        filterid = Array(mySet)
        id.removeAll()
        image.removeAll()
        for i in filterid
        {
            for (k,v) in emp
            {
                if i == k
                {
                    let arr = v
                    filterEmp[k] = [arr[0],arr[1],arr[2],arr[3],arr[4]]
                    id.append(k)
                    getProfile()
                }
            }
        }
        tableView.reloadData()
    }

    //on click it displays a list in actionsheet where user can choose the method by which he wants to sort the employees
    @IBAction func sort(_ sender: Any)
    {
    let method = UIAlertController(title: "SORT", message: "by", preferredStyle: .actionSheet)
    
    let names = UIAlertAction(title: "Name", style: UIAlertActionStyle.default) {
        UIAlertAction in
        self.sortByName()
        
    }
    let dateOfBirth = UIAlertAction(title: "Date Of Birth", style: UIAlertActionStyle.default) {
        UIAlertAction in
       self.sortByDob()
        
    }
    let desgnatn = UIAlertAction(title: "Designation", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.sortByDesgnation()
            
    }
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) {
        UIAlertAction in
        print ("Cancel Pressed")
    }
    
    method.addAction(names)
    method.addAction(dateOfBirth)
    method.addAction(desgnatn)
    method.addAction(cancel)
    
    present(method, animated: true, completion: nil)
    }
    //functions for the method choosen by the user to sort
    //another dictionary is used to keep the sorted values
    func sortByName()
    {
        sortSelected = 1
        let reesult = emp.sorted { (first: (key: Int, value: [String]), second: (key: Int, value: [String])) -> Bool in
            return first.value[0] < second.value[0]
        }
        sortedEmp.removeAll()
        var i = 0
        for (k,v) in reesult
        {
            let valueArray = v
            print(v)
            let index = String(i)
            sortedEmp[k] = [index,valueArray[0],valueArray[1],valueArray[2],valueArray[3],valueArray[4]]
            i = i+1
        }
        tableView.reloadData()
        
        
    }
    
    func calcAge(birthday:String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd,YYYY"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let now: NSDate! = NSDate()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now as Date, options: [])
        let age = calcAge.year
        return age!
    }
    func sortByDob()
    {
        sortSelected = 1
        let reesult = emp.sorted { (first: (key: Int, value: [String]), second: (key: Int, value: [String])) -> Bool in
           
            let age1 = calcAge(birthday: first.value[2])
            let age2 = calcAge(birthday: second.value[2])
            return age1 < age2
        }
        sortedEmp.removeAll()
        var i = 0
        for (k,v) in reesult
        {
            let valueArray = v
            print(v)
            let index = String(i)
            sortedEmp[k] = [index,valueArray[0],valueArray[1],valueArray[2],valueArray[3],valueArray[4]]
            i = i+1
        }
        tableView.reloadData()
        

    }
    func sortByDesgnation()
    {
        sortSelected = 1
        let reesult = emp.sorted { (first: (key: Int, value: [String]), second: (key: Int, value: [String])) -> Bool in
            return first.value[1] < second.value[1]
        }
        sortedEmp.removeAll()
        var i = 0
        for (k,v) in reesult
        {
            let valueArray = v
            print(v)
            let index = String(i)
            sortedEmp[k] = [index,valueArray[0],valueArray[1],valueArray[2],valueArray[3],valueArray[4]]
            i = i+1
        }
        tableView.reloadData()
   
    }
    //profile picture is fetched when sorting is used as sorted dictionary contains only string values
    func getProfile()
    {
        image.removeAll()
        for i in id
        {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            fetchRequest.predicate = NSPredicate(format: "id == %i", i)
            fetchRequest.returnsObjectsAsFaults = false
            do{
                print(i)
                let results = try context.fetch(fetchRequest)
                if results.count>0
                {
                    for result in results as! [NSManagedObject]
                    {
                        
                        if let photoinData = result.value(forKey: "pi") as? NSData
                        {
                            image.append(UIImage(data: photoinData as Data)!)
                            
                        }
                        
                    }
                    
                }
                else
                {
                    print("no result")
                }
            }
            catch
            {
                //error
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return id.count
    }
   //for displays cells conditions are checked first whether the user is sorting , searching etc and accordingly cells are displayed
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        if (searchController.isActive && searchController.searchBar.text != " ")
        {
            let object = Array(filterEmp.values)[indexPath.row]
            cell.nameLabel.text = object[0]
            cell.profileImage.image = image[indexPath.row]
            cell.genderLabel.text = object[3]
            cell.dobLabel.text = object[2]
            cell.dojLabel.text = object[4]
            cell.idLabel.text = String(id[indexPath.row])
            return (cell)
        }
        
        else if sortSelected == 1
        {
            name.removeAll()
            dob.removeAll()
            gender.removeAll()
            doj.removeAll()
            id.removeAll()
            var c = 0
            for i in sortedEmp
            {
                for (k,v) in sortedEmp
                {
                    let arr = v
                    let counter = String(c)
                    if counter == arr[0]
                    {
                        let object = v
                        id.append(k)
                        name.append(object[1])
                        dob.append(object[3])
                        gender.append(object[4])
                        doj.append(object[5])
                    }
                }
               c = c+1
                
            }
        getProfile()
        cell.nameLabel.text = name[indexPath.row]
        cell.genderLabel.text = gender[indexPath.row]
        cell.dobLabel.text = dob[indexPath.row]
        cell.idLabel.text = String(id[indexPath.row])
        cell.dojLabel.text = doj[indexPath.row]
        cell.profileImage.image = image[indexPath.row]
       return(cell)
            
        }
        else if sortSelected == 0
        {
            let object = Array(emp.values)[indexPath.row]
            print(object)
        
        cell.nameLabel.text = object[0]
        cell.profileImage.image = image[indexPath.row]
        cell.genderLabel.text = object[3]
        cell.dobLabel.text = object[2]
        cell.dojLabel.text = object[4]
        cell.idLabel.text = String(id[indexPath.row])
        
        return (cell)
        }
      
        else { preconditionFailure ("unexpected cell type")}
    }
    //to delete an employee
    
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
            details()
        }
    }
    //to move to another view controller to view all details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!) as! CustomTableViewCell!;
        var value = 0
        if searchController.isActive && searchController.searchBar.text != ""
        {
        value = filterid[(indexPath?.row)!]
            searchController.isActive = false
        }
        else
        {
         value = Int((currentCell?.idLabel.text)!)!
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        
        viewController.passedValue =  value
        self.present(viewController, animated: true , completion: nil)
    }
  
       override func viewDidLoad() {
        super.viewDidLoad()
        self.searchController.loadViewIfNeeded()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        details()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.returnsObjectsAsFaults = false
        sortSelected = 0
        name.removeAll()
        image.removeAll()
        designation.removeAll()
        gender.removeAll()
        doj.removeAll()
        dob.removeAll()
        id.removeAll()
        emp.removeAll()
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
                        
                       
                        if let ename = result.value(forKey: "name") as? String
                        {

                            
                            if let edesg = result.value(forKey: "designaton") as? String
                            {
                               
                                if let egend = result.value(forKey: "gender") as? String
                                {
                                   
                                    if let edob = result.value(forKey: "dob") as? String
                                    {
                                       
                                        if let edoj = result.value(forKey: "dateofjoining") as? String
                                        {
                                            emp[eid] = [ename,edesg,edob,egend,edoj]
                                            if let photoinData = result.value(forKey: "pi") as? NSData
                                            {
                                                image.append(UIImage(data: photoinData as Data)!)
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
            let myAlert = UIAlertController(title: "Alert", message: "Unexpectd error, try again later!", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if searchController.isActive == true {
            
            searchController.isActive = false
            
        }    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterResult(searchText: searchController.searchBar.text!)
    }
}
