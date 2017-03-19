//  SecondViewController.swift
//  Employee Management
//
//  Created by Tazeen on 10/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.

import UIKit
import CoreData

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var gender = ["Choose","Male","Female","Other"]
    var pickerView = UIPickerView()
    let image = UIImagePickerController()
    let dobPicker = UIDatePicker()
    var doneValue = String()
    
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var desgField: UITextField!
    @IBOutlet weak var addField: UITextField!
    @IBOutlet weak var hobbField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var idField: UITextField!
    
    // to change profile picture
    @IBAction func changeImage(_ sender: Any) {
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
    
    func genderPicker()
    {
        
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPicker))
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([done], animated: false)
        genderField.inputAccessoryView = toolbar
        genderField.inputView = dobPicker
    }
    func donePressedPicker()
    {
        let pick = doneValue
        genderField.text = pick
        self.view.endEditing(true)
        
        
    }
    //picker view for gender
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
            genderField.text=gender[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return gender[row]
    }
    
    //submitting the details
    @IBAction func submit(_ sender: UIButton)
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        let todaydate = formatter.string(from: date)
        let name = nameField.text!
        let designation = desgField.text!
        let address = addField.text!
        let gender = genderField.text!
        let hobbies = hobbField.text!
        let dob = dobField.text!
        let pi = UIImagePNGRepresentation(profileImage.image!)
        let id = Int(idField.text!)
        
        if (name != "" && designation != "" && address != "" && gender != "" && hobbies != "" && dob != "")
        {
            print("if")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
           
            newUser.setValue(name, forKey: "name")
            newUser.setValue(hobbies, forKey: "hobbies")
            newUser.setValue(gender, forKey: "gender")
            newUser.setValue(dob, forKey: "dob")
            newUser.setValue(designation, forKey: "designaton")
            newUser.setValue(todaydate, forKey: "dateofjoining")
            newUser.setValue(address, forKey: "address")
            newUser.setValue(pi, forKey: "pi")
            newUser.setValue(id, forKey: "id")
            do
            {
                    try context.save()
            }
            catch
            {
                let myAlert = UIAlertController(title: "Alert", message: "Couldn't save the details", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            // going back to main screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(controller, animated: true, completion: nil)
            
        
        }
        else
        {
                let myAlert = UIAlertController(title: "Alert", message: "Enter values in all fields", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
        }
    
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthDatePicker()
        genderPicker()
        // to make the uiimageview circular
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        pickerView.delegate = self
        pickerView.dataSource = self
        genderField.inputView = pickerView
        
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
        border6.frame = CGRect(x: 0, y: self.genderField.frame.size.height - width6, width:  genderField.frame.size.width, height: genderField.frame.size.height)
         border6.borderWidth = width6
         genderField.layer.addSublayer(border6)
         genderField.layer.masksToBounds = true
        let border7 = CALayer()
        let width7 = CGFloat(2.0)
        border7.borderColor = UIColor.lightGray.cgColor
        border7.frame = CGRect(x: 0, y: self.idField.frame.size.height - width7, width:  genderField.frame.size.width, height: genderField.frame.size.height)
        border7.borderWidth = width7
        idField.layer.addSublayer(border7)
        idField.layer.masksToBounds = true
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }

   
