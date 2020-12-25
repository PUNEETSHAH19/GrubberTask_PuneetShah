//
//  HomeViewController.swift
//  GrubberDemo
//
//  Created by Puneet Shah on 25/12/20.
//  Copyright © 2020 Puneet Shah. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!

    @IBOutlet weak var buttonAdd : UIButton!
    
    var arrayOfExpenseData = [ExpenseData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.fetchDataFromCoreDataAndShow()
    }
    
    func configureView(){
        self.buttonAdd.layer.cornerRadius = 35.0
    }
    
    func fetchDataFromCoreDataAndShow(){
        arrayOfExpenseData.removeAll()
        arrayOfExpenseData = CoreDataManager.fetchExpenseData()
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    //MARK: TableView delegate/Datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfExpenseData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCellIdentifier", for: indexPath) as! CustomTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        cell.labelDate.text = formatter.string(from: arrayOfExpenseData[indexPath.row].date!)
        
        cell.labelTitle.text = arrayOfExpenseData[indexPath.row].title ?? ""
        cell.labelCategory.text = arrayOfExpenseData[indexPath.row].category ?? ""
        cell.labelAmount.text = "\(arrayOfExpenseData[indexPath.row].amount)"
        
        return cell
    }
    
    //Add new expense
    @IBAction func buttonAddExpenseAction() {
        DispatchQueue.main.async {
            let nextViewController = AppSharedData.storyBoard.instantiateViewController(withIdentifier: "AddExpenseViewController") as! AddExpenseViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

}
