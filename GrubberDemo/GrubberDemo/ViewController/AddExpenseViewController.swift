//
//  AddExpenseViewController.swift
//  GrubberDemo
//
//  Created by Puneet Shah on 25/12/20.
//  Copyright © 2020 Puneet Shah. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var datePicker : UIDatePicker!
    
    @IBOutlet weak var buttonDate : UIButton!
    @IBOutlet weak var textFieldTitle : UITextField!
    @IBOutlet weak var textFieldCategory : UITextField!
    @IBOutlet weak var textFieldAmount : UITextField!
    
    @IBOutlet weak var viewDatePicker : UIView!
    
    var currentSelectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
    }
    
    func configureView(){
        
        self.viewDatePicker.isHidden = true
        
        self.buttonDate.layer.borderWidth = 1
        self.buttonDate.layer.borderColor = UIColor.cyan.cgColor
        
        self.textFieldTitle.layer.borderWidth = 1
        self.textFieldTitle.layer.borderColor = UIColor.cyan.cgColor

        self.textFieldCategory.layer.borderWidth = 1
        self.textFieldCategory.layer.borderColor = UIColor.cyan.cgColor

        self.textFieldAmount.layer.borderWidth = 1
        self.textFieldAmount.layer.borderColor = UIColor.cyan.cgColor
        
        self.textFieldTitle.resignFirstResponder()
        self.textFieldCategory.resignFirstResponder()
        self.textFieldAmount.resignFirstResponder()
        
        self.addDoneButtonOnKeyboard()
        
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    //MARK: DatePicker Method
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            self.buttonDate.setTitle("\(day)-\(month)-\(year)", for: .normal)
            self.currentSelectedDate = sender.date
        }
    }

    @IBAction func buttonDateAction() {
        self.viewDatePicker.isHidden = false
    }
    @IBAction func buttonDoneAction() {
        self.viewDatePicker.isHidden = true
    }
    
    //MARK: Button Action method for saving expense
    @IBAction func buttonSaveExpense() {
        
        var isValidatedDetails = true
        var message = ""
        
        if textFieldTitle.text == "" {
            isValidatedDetails = false
            message = "Title can not be blank !!"
        }else if textFieldCategory.text == "" {
            isValidatedDetails = false
            message = "Category can not be blank !!"
        }else if textFieldAmount.text == "" || textFieldAmount.text == "0" {
            isValidatedDetails = false
            message = "Amount can not be blank !!"
        }
        
        if !isValidatedDetails {
            AppSharedData.showAlert(message: message, viewController: self)
        }else{
            
            //Saving in coredata
            CoreDataManager.saveDataInDB(date: self.currentSelectedDate, title: self.textFieldTitle.text ?? "", category: self.textFieldCategory.text ?? "", amount: Int64(self.textFieldAmount.text!)!)
            AppSharedData.showAlert(message: "Data Saved", viewController: self)
            
            //Reset all data
            self.buttonDate.setTitle("Seleect Date", for: .normal)
            self.textFieldTitle.text = ""
            self.textFieldCategory.text = ""
            self.textFieldAmount.text = ""
            
        }
        
    }
    
    //
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.textFieldTitle.inputAccessoryView = doneToolbar
        self.textFieldCategory.inputAccessoryView = doneToolbar
        self.textFieldAmount.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }



}
