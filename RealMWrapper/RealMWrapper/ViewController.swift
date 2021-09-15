//
//  ViewController.swift
//  RealMWrapper
//
//  Created by Intuz on 07/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtGender: UITextField!
    var user:UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add/Update Record"
        if user != nil {
            setData()
        }
    }
    
    private func setData() {
        txtUserName.text = user?.name ?? ""
        txtMobile.text = user?.mobileNo ?? ""
        txtGender.text = user?.gender ?? ""
    }
    
    @IBAction func clickSave(_ sender:UIButton) {
        if txtUserName.text == "" {
            self.showAlert("Please enter username", isSuccess: false)
        } else if txtMobile.text == "" {
            self.showAlert("Please enter mobile number", isSuccess: false)
        } else if txtGender.text == "" {
            self.showAlert("Please enter gender", isSuccess: false)
        } else {
            if user == nil {
                user = UserModel()
                user?.id = Int(Date().timeIntervalSince1970)
                user?.mobileNo = txtMobile.text
                user?.name = txtUserName.text
                user?.gender = txtGender.text
                RealMWrapper.shared.updateUserModelData(with: user!) { status in
                    self.showAlert(status ? "Record successfully added" : "Record failed to add" , isSuccess: status)
                }
            }
            else {
                try? RealMWrapper.shared.realm?.write {
                    user?.mobileNo = txtMobile.text
                    user?.name = txtUserName.text
                    user?.gender = txtGender.text
                }
                self.showAlert("Record updated successfully", isSuccess: true)
            }
        }
    }
    
    private func showAlert(_ message:String, isSuccess:Bool) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            if isSuccess {
                self.backtoPrevious()
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    private func backtoPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
