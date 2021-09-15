//
//  RecordDetailVC.swift
//  RealMWrapper
//
//  Created by Intuz on 14/09/21.
//

import UIKit
import RealmSwift
import Realm

class RecordDetailVC: UIViewController {
    
    @IBOutlet var tblList: UITableView!
    var userList      =  [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Record List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecordList()
    }
    
    func getRecordList() {
        RealMWrapper.shared.getAllData { results in
            if let res = results {
                self.userList = res.filter({ (model) -> Bool in
                    return true
                })
                self.tblList.reloadData()
            }
        }
    }
    
    @IBAction func clickAddRecord() {
        addEditRecord(nil)
    }
    
    func addEditRecord(_ userDetail:UserModel?) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let objRecord = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        objRecord.user = userDetail
        self.navigationController?.pushViewController(objRecord, animated: true)
    }
}

extension RecordDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: RecordCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        cell.lblUserName.text = self.userList[indexPath.row].name
        cell.lblMobileNo.text = self.userList[indexPath.row].mobileNo
        cell.lblGender.text = self.userList[indexPath.row].gender
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func btnDeleteClicked(_ sender:UIButton) {
        RealMWrapper.shared.delete(object: self.userList[sender.tag]) { status in
            if status {
                self.getRecordList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.userList.count > indexPath.row {
            self.addEditRecord(self.userList[indexPath.row])
        }
    }
}
