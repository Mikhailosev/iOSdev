//
//  ViewController.swift
//  Lab 5
//
//  Created by iosdev on 26/01/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var height: Double = 0
    var weight: Double = 0
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        nameTextField.delegate = self
        
        if let person = person {
            nameTextField.text = person.name
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowCharacters.isSuperset(of: characterSet)
    }
    
    @IBAction func calculateButtonClick(_ sender: UIButton) {
        let name = nameTextField.text
        let person = Person(name: name!, height:height, weight:weight)
        if let bmi = person?.getBMI() {
            if bmi.isNaN {
                bmiLabel.text = "negative value"
            }
            else{
                bmiLabel.text = String(format: "%.1f", bmi)
                changeColorOfBackground(bmi)
            }
        }
    }
    
    func changeColorOfBackground(_ bmi: Double) {
        if bmi < 18.5 {
            view.backgroundColor = UIColor.blue
        }
        else if bmi < 25 {
            view.backgroundColor = UIColor.green
        }
        else if bmi < 30 {
            view.backgroundColor = UIColor.yellow
        }
        else {
            view.backgroundColor = UIColor.red
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = nameTextField.text ?? ""
        calculateButton.isEnabled = !text.isEmpty
        saveButton.isEnabled = !text.isEmpty
        if text.isEmpty {
            let title = "Name Field"
            let message = "You can't calculate BMI without entering name"
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
            nameTextField.becomeFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Calculate button while editing.
        calculateButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        height = Double(pickerView.selectedRow(inComponent: 0))
        weight = Double(pickerView.selectedRow(inComponent: 1))
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
   
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
           fatalError("The save button is not pressed.")
        }
        
        let name = nameTextField.text ?? ""
        let height = self.height
        let weight = self.weight
        
        person = Person(name: name, height: height, weight: weight)
        
    }
}

