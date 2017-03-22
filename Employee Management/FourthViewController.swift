//
//  FourthViewController.swift
//  Employee Management
//
//  Created by Tazeen on 13/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit
import CoreData

class FourthViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var gender = ["Choose","Male","Female","Other"]
    var pickerView = UIPickerView()
    let image = UIImagePickerController()
    let dobPicker = UIDatePicker()
    var passedValue: Int!
    var id: Int = 0
    var doneValue = String()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var desgField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var hobbField: UITextField!
    @IBOutlet weak var gendField: UITextField!
    @IBOutlet weak var addField: UITextField!
    //change profile picture
    @IBAction func change(_ sender: Any)
    {
        image.delegate = self
        let method = UIAlertController(title: "Profile Picture", message: "Choose the method to change the image", preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "Photo library", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.image.sourceType = .photoLibrary
            self.present(self.image, animated: true)
        }
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) {
            UIAlertAction in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                self.image.sourceType = .camera
                self.present(self.image, animated: true)
                
            }
            else
            {
                print("camera not found")
            }
            
        }
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            print ("Cancel Pressed")
        }
        
        method.addAction(gallery)
        method.addAction(camera)
        method.addAction(cancel)
        
        present(method, animated: true, completion: nil)
        
    
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            profileImage.image = image
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    func birthDatePicker()
    {
        dobPicker.datePickerMode = .date
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([done], animated: false)
        dobField.inputAccessoryView = toolbar
        dobField.inputView = dobPicker
    }
    func donePressed()
    {
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        dobField.text = format.string(from: dobPicker.date)
        self.view.endEditing(true)
        
    }
    //picker view for gender
    func genderPicker()
    {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPicker))
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([done], animated: false)
        gendField.inputAccessoryView = toolbar
        gendField.inputView = pickerView
    }
    func donePressedPicker()
    {
        let pick = doneValue
        gendField.text = pick
        self.view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return gender.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        doneValue = gender[row]
        gendField.text=gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return gender[row]
    }
    
    @IBAction func update(_ sender: Any)
    {
        let name = nameField.text!
        let designation = desgField.text!
        let address = addField.text!
        let gender = gendField.text!
        let hobbies = hobbField.text!
        let dob = dobField.text!
        let pi = UIImagePNGRepresentation(profileImage.image!)
      
        
        if (name != "" && designation != "" && address != "" && gender != "" && hobbies != "" && dob != "")
        {
            
            let del = UIApplication.shared.delegate as! AppDelegate
            let contxt = del.persistentContainer.viewContext
            let Request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            Request.predicate = NSPredicate(format: "id == %i", id)
            Request.returnsObjectsAsFaults = false
            do
            {
                let result = try contxt.fetch(Request)
                if result.count > 0
                {
                    for res in result as! [NSManagedObject]
                    {
                        res.setValue(name, forKey: "name")
                        res.setValue(designation, forKey: "designaton")
                        res.setValue(dob, forKey: "dob")
                        res.setValue(gender, forKey: "gender")
                        res.setValue(address, forKey: "address")
                        res.setValue(hobbies, forKey: "hobbies")
                        res.setValue(pi, forKey: "pi")
                    }
                    do
                    {
                        try contxt.save()
                    }
                    catch
                    {
                        
                    }
                }
            }
            catch
            {
                
            }
            
            
        }
        else
        {
            let myAlert = UIAlertController(title: "Alert", message: "Enter values in all fields", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(controller, animated: true, completion: nil)
        
    
    }
    
    func savedImage()
    {
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
                    
                    if let photoinData = result.value(forKey: "pi") as? NSData
                    {
                        let  image = UIImage(data: photoinData as Data)
                        profileImage.image = image
                    }
                
                }
                
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
        idLabel.text = String(id)
        savedImage()
        birthDatePicker()
        genderPicker()
        
        
        // to make the uiimageview circular
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        pickerView.delegate = self
        pickerView.dataSource = self
        gendField.inputView = pickerView
        
        //to add bottom border in text field
        let border1 = CALayer()
        let width1 = CGFloat(2.0)
        border1.borderColor = UIColor.lightGray.cgColor
        border1.frame = CGRect(x: 0, y: self.nameField.frame.size.height - width1, width:  nameField.frame.size.width, height: nameField.frame.size.height)
        border1.borderWidth = width1
        nameField.layer.addSublayer(border1)
        nameField.layer.masksToBounds = true
        let border2 = CALayer()
        let width2 = CGFloat(2.0)
        border2.borderColor = UIColor.lightGray.cgColor
        border2.frame = CGRect(x: 0, y: self.desgField.frame.size.height - width2, width:  desgField.frame.size.width, height: addField.frame.size.height)
        border2.borderWidth = width2
        desgField.layer.addSublayer(border2)
        desgField.layer.masksToBounds = true
        let border3 = CALayer()
        let width3 = CGFloat(2.0)
        border3.borderColor = UIColor.lightGray.cgColor
        border3.frame = CGRect(x: 0, y: self.addField.frame.size.height - width3, width:  addField.frame.size.width, height: addField.frame.size.height)
        border3.borderWidth = width3
        addField.layer.addSublayer(border3)
        addField.layer.masksToBounds = true
        let border4 = CALayer()
        let width4 = CGFloat(2.0)
        border4.borderColor = UIColor.lightGray.cgColor
        border4.frame = CGRect(x: 0, y: self.hobbField.frame.size.height - width4, width:  hobbField.frame.size.width, height: hobbField.frame.size.height)
        border4.borderWidth = width4
        hobbField.layer.addSublayer(border4)
        hobbField.layer.masksToBounds = true
        let border5 = CALayer()
        let width5 = CGFloat(2.0)
        border5.borderColor = UIColor.lightGray.cgColor
        border5.frame = CGRect(x: 0, y: self.dobField.frame.size.height - width5, width:  dobField.frame.size.width, height: dobField.frame.size.height)
        border5.borderWidth = width4
        dobField.layer.addSublayer(border5)
        dobField.layer.masksToBounds = true
        let border6 = CALayer()
        let width6 = CGFloat(2.0)
        border6.borderColor = UIColor.lightGray.cgColor
        border6.frame = CGRect(x: 0, y: self.gendField.frame.size.height - width6, width:  gendField.frame.size.width, height: gendField.frame.size.height)
        border6.borderWidth = width6
        gendField.layer.addSublayer(border6)
        gendField.layer.masksToBounds = true
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(FourthViewController.tapFunction))
        idLabel.isUserInteractionEnabled = true
        idLabel.addGestureRecognizer(tap)
    }
    
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        
        let mg = idLabel.text!
        print(mg)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
