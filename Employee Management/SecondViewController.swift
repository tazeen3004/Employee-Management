//  SecondViewController.swift
//  Employee Management
//
//  Created by Tazeen on 10/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.

import UIKit
class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var gender = ["Male","Female"]
    var picker = UIPickerView()
    
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var desgField: UITextField!
    @IBOutlet weak var addField: UITextField!
    @IBOutlet weak var hobbField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    
   
    @IBAction func submit(_ sender: UIButton)
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        print(result)
        let name = nameField.text!
        print(name)
        let designation = desgField.text!
        print(designation)
        let address = addField.text!
        let gender = genderField.text!
        print(gender)
        let hobbies = hobbField.text!
        print(hobbies)
        let dob = dobField.text!
        
        if (name != "" && designation != "" && address != "" && gender != "" && hobbies != "" && dob != "")
        {
        
            self.performSegue(withIdentifier: "unwindToViewController", sender: self)
        
        }
        else
        {
                let myAlert = UIAlertController(title: "Alert", message: "Enter values in all fields", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
        }
    
    
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
        genderField.text=gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return gender[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to make the uiimageview circular
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        picker.delegate = self
        picker.dataSource = self
        genderField.inputView = picker
        
        
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
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

   
