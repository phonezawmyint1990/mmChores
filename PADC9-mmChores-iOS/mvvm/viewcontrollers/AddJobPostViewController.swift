//
//  AddJobPostViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 11/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseFirestore

class AddJobPostViewController: UIViewController {
    
    @IBOutlet weak var viewShortDesc: UIView!
    @IBOutlet weak var viewFullDesc: UIView!
    @IBOutlet weak var viewPickPhoto: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewPrice: UIView!
    @IBOutlet weak var lblTakePicture: UILabel!
    @IBOutlet weak var ivCamera: UIImageView!
    @IBOutlet weak var ivJobPicture: UIImageView!
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfShortDesc: UITextField!
   
    @IBOutlet weak var tvFullDesc: UITextView!
    @IBOutlet weak var tfPrice: UITextField!
    
    var mViewModel : AddJobPostViewModel = AddJobPostViewModel()
    var datePicker : UIDatePicker?

    
    var timePicker : UIDatePicker?
    
    lazy var activityIndicator : UIActivityIndicatorView = {
             let ui = UIActivityIndicatorView()
             ui.translatesAutoresizingMaskIntoConstraints = false
             ui.startAnimating()
          ui.style = UIActivityIndicatorView.Style.medium
             return ui
         }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    @IBAction func onTapApply(_ sender: Any) {
        
     
            
        if let fulldesc = tvFullDesc.text, !fulldesc.isEmpty,
                let jobDate = tfDate.text,!jobDate.isEmpty,
                let jobTime = tfTime.text,!jobTime.isEmpty,
                let location = tfLocation.text,!location.isEmpty,
                let price = tfPrice.text,!price.isEmpty,
                let shortDesc = tfShortDesc.text,!shortDesc.isEmpty
            {
                
                mViewModel.addJobPost(fullDesc: fulldesc, jobDate: jobDate, jobTime: jobTime, location: location, photoUrl: "", price: price, shortDesc: shortDesc, isActive: true)
                self.dismiss(animated: true, completion: nil)

        } else {
            
            let alert = UIAlertController(title: "Error", message: "Please enter every single information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
       
      
        

        
        
    }
    fileprivate func setupView(){
        
        makeBorderWidth(view: viewShortDesc)
        makeBorderWidth(view: viewFullDesc)
        makeBorderWidth(view: viewPrice)
        makeBorderWidth(view: viewPickPhoto)
        makeBorderWidth(view: viewLocation)
        makeBorderWidth(view: viewDate)
        makeBorderWidth(view: viewTime)
        btnApply.layer.cornerRadius = 8
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewPickPhoto.isUserInteractionEnabled = true
        viewPickPhoto.addGestureRecognizer(tap)
        
        
        datePicker = UIDatePicker()
               datePicker?.datePickerMode = .date
               datePicker?.addTarget(self, action: #selector(selectedDate(datePicker:)), for: .valueChanged)
               tfDate.inputView = datePicker
        
        timePicker = UIDatePicker()
                     timePicker?.datePickerMode = .time
                     timePicker?.addTarget(self, action: #selector(selectedDate(timePicker:)), for: .valueChanged)
                     tfTime.inputView = timePicker
        
    }
    
    @objc func selectedDate(datePicker: UIDatePicker){
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           tfDate.text = dateFormatter.string(from: datePicker.date)
           view.endEditing(true)
       }
    
    @objc func selectedDate(timePicker: UIDatePicker){
              let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
              tfTime.text = dateFormatter.string(from: timePicker.date)
              view.endEditing(true)
          }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        ImagePickerManager().pickImage(self) { (image) in
            self.ivJobPicture.image = image
            self.ivJobPicture.isHidden = false
            self.mViewModel.uploadImageToCloud(ivImage: self.ivJobPicture)
            
            
        }
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    fileprivate func makeBorderWidth(view : UIView) {
        view.layer.borderColor = UIColor.separator.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
    }
}
