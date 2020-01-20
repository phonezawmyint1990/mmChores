//
//  RegisterViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class RegisterViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUserName: MDCTextField!
    @IBOutlet weak var txtEmail: MDCTextField!
    @IBOutlet weak var txtPhoneNo: MDCTextField!
    @IBOutlet weak var txtDOB: MDCTextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lblRegister: UILabel!
    
    var datePicker : UIDatePicker?
    var usernameTextFieldController = MDCTextInputControllerOutlined()
    var emailTextFieldController = MDCTextInputControllerOutlined()
    var phoneNoTextFieldController = MDCTextInputControllerOutlined()
    var dobTextFieldController = MDCTextInputControllerOutlined()
    
    public let disposeBag = DisposeBag()
    public let viewModel = RegisterViewModel()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPhoneNo.delegate =  self
        txtDOB.delegate = self
        setUpUI()
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        if validation() {
           self.user?.name = txtUserName.text ?? ""
                   self.user?.email =  txtEmail.text ?? ""
                   self.user?.phoneNo = txtPhoneNo.text ?? ""
                   self.user?.dob = txtDOB.text ?? ""
                   viewModel.requestRegisterData(user: self.user!).observeOn(MainScheduler.instance).subscribe(onNext: { response in
                      let isEqual = (response == REGISTER_SUCCESS)
                       if isEqual {
                           self.goHomeMessage(message: REGISTER_SUCCESS_MSG)
                       }
                   }).disposed(by: self.disposeBag)
        }
    }
    
    private func validation() -> Bool {
        var result: Bool = true
       if txtPhoneNo.text!.isEmpty {
        self.showMessage(message: PHONE_NO_REQUIRED)
            result = false
       }else if txtPhoneNo.text!.count < 11 {
        self.showMessage(message: PHONE_NO_INVALID)
            result = false
       }else if txtDOB.text!.isEmpty {
        self.showMessage(message: DOB_REQUIRED)
            result = false
       }
        return result
    }
    
    
    
    private func setUpUI(){
        self.navigationController?.isNavigationBarHidden = true
        
        txtUserName.isEnabled = false
        txtEmail.isEnabled = false
        
        txtUserName.placeholder = USER_NAME
        txtUserName.translatesAutoresizingMaskIntoConstraints = false
        txtUserName.clearButtonMode = .whileEditing
        txtUserName.leadingViewMode = .always
        txtUserName.leftView = UIImageView(image: UIImage(named: "person_img"))
        usernameTextFieldController = MDCTextInputControllerOutlined(textInput: txtUserName)
        
        
        txtEmail.placeholder = USER_EMAIL
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        txtEmail.clearButtonMode = .whileEditing
        txtEmail.leadingViewMode = .always
        txtEmail.leftView = UIImageView(image: UIImage(named: "email_img"))
        emailTextFieldController = MDCTextInputControllerOutlined(textInput: txtEmail)
        
        txtPhoneNo.placeholder = USER_PHONE_NO
        txtPhoneNo.translatesAutoresizingMaskIntoConstraints = false
        txtPhoneNo.clearButtonMode = .whileEditing
        txtPhoneNo.leadingViewMode = .always
        txtPhoneNo.leftView = UIImageView(image: UIImage(named: "phone_no_img"))
        phoneNoTextFieldController = MDCTextInputControllerOutlined(textInput: txtPhoneNo)
        
        txtDOB.placeholder = USER_DOB
        txtDOB.translatesAutoresizingMaskIntoConstraints = false
        txtDOB.clearButtonMode = .whileEditing
        txtDOB.leadingViewMode = .always
        txtDOB.leftView = UIImageView(image: UIImage(named: "dob_img"))
        dobTextFieldController = MDCTextInputControllerOutlined(textInput: txtDOB)
        
        btnRegister.layer.cornerRadius = 25
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(selectedDate(datePicker:)), for: .valueChanged)
        txtDOB.inputView = datePicker
        
        if let getUser = self.user {
            txtUserName.text = getUser.name
            txtEmail.text = getUser.email
        }
    }
    
    @objc func selectedDate(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtDOB.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    fileprivate func goHomeMessage(message: String){
           let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
                    let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
                    let vc =  storyboard.instantiateViewController(identifier: String(describing: MyTabBarCtrl.self)) as! MyTabBarCtrl
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = txtPhoneNo.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 11
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDOB {
            IQKeyboardManager.shared.enableAutoToolbar = false
        }else{
            IQKeyboardManager.shared.enableAutoToolbar = true
        }
    }
}
