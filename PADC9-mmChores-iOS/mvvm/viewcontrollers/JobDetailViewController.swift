//
//  JobDetailViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 11/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage
import RxCocoa
class JobDetailViewController: UIViewController {
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var viewComponent: UIView!
    @IBOutlet weak var collectionViewJobApplyPerson: UICollectionView!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFullDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var ivJobPic:
    UIImageView!
    @IBOutlet weak var lblListApplicant: UILabel!
    
    @IBOutlet weak var viewAfterApply: UIView!
    @IBOutlet weak var lblCurrentlyHired: UILabel!
    
    @IBOutlet weak var ivApplyJobPic: UIImageView!
    @IBOutlet weak var btnJobFinished: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    
    
    @IBOutlet weak var ivApplyPhoto: UIImageView!
    @IBOutlet weak var lblNameApply: UILabel!
    
    
    var result : JobVO?
    let bag = DisposeBag()
    var mViewModel : JobDetailViewModel = JobDetailViewModel()
    var applicant : [User] = []
    var chosenUserId : String = ""
    var phone : String?
    
    
    
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let ui = UIActivityIndicatorView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.startAnimating()
        ui.style = UIActivityIndicatorView.Style.medium
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupCollectionView()
        bindData(data: result!)
        self.activityIndicator.stopAnimating()

        self.mViewModel.requestAppliedFreelancers(id: result?.id ?? "")
        {
            self.collectionViewJobApplyPerson.reloadData()
        }
        
        self.mViewModel.requestData(jobID: result?.id ?? "")
        
        
        if (result?.appliedFreelancersArray.isEmpty == true) {
            lblListApplicant.text = "အလုပ်လျှောက်ထားသူ မရှိသေးပါ"
        }
        
        if (result?.postedEmployersArray[0] !=  UserDefaults.standard.string(forKey: "ID"))
        {
            lblListApplicant.isHidden = true
            collectionViewJobApplyPerson.isHidden = true
        }
        
        
        
    }
    
    fileprivate func setUpView(){
        viewComponent.layer.cornerRadius = 20
        btnJobFinished.layer.cornerRadius = 10
        btnCall.layer.cornerRadius = 10
        ivApplyJobPic.layer.cornerRadius = 8
    }
    
    fileprivate func bindData(data : JobVO){
        
        ivJobPic.sd_setImage(with: URL(string: data.photoUrl ), completed: nil)
        lblShortDesc.text = data.shortDescription
        lblFullDesc.text = data.fullDescription
        lblPrice.text = "\(data.price)  MMK"
        lblLocation.text = data.location
        lblDate.text = data.jobDate
        lblTime.text = data.jobTime
        
        
        if (self.result!.chosenFreelancerArray.count ) > 0 {
            
            getChosenFreelancer()
            //
            
        }
        else
        {
            
            
            
            self.collectionViewJobApplyPerson.isHidden = false
            self.viewAfterApply.isHidden = true
            self.lblListApplicant.isHidden = false
            self.lblCurrentlyHired.isHidden = true
        }
        
        
    }
    
    fileprivate func getChosenFreelancer(){
        
        self.mViewModel.findChosenApplicant(jobId: result?.id ?? "")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext : { response in
                self.applicant = response
                self.ivApplyPhoto.sd_setImage(with: URL(string: self.applicant[0].photoUrl), completed: nil)
                self.lblNameApply.text = self.applicant[0].name
                self.phone = self.applicant[0].phoneNo
                self.lblEmail.text = self.applicant[0].email
                
            },onError : { err in
                print(err.localizedDescription)
                
            }).disposed(by: bag)
        //
        
        self.collectionViewJobApplyPerson.isHidden = true
        self.viewAfterApply.isHidden = false
        self.lblListApplicant.isHidden = true
        self.lblCurrentlyHired.isHidden = false
    }
    
    @IBAction func onTapDimiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    fileprivate func setupCollectionView() {
        collectionViewJobApplyPerson.delegate = self
        collectionViewJobApplyPerson.dataSource = self
        collectionViewJobApplyPerson.registerForCollectionCell(strID: String(describing: ProfilePicCollectionViewCell.self))
        
        let layout = collectionViewJobApplyPerson.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 80)
    }
    
    
    
    @IBAction func onTapCallApplicant(_ sender: Any) {
        
        
        guard let number = URL(string: "tel://\(self.phone ?? "")") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func onTapJobFinished(_ sender: Any) {
        
        let alert = UIAlertController(title: "Is Job Finished", message: "Are you finish working?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            self.mViewModel.finishJobPost(jobId: self.result?.id ?? "")
            self.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {
            action in
            
        }))
        present(alert,animated: true,completion: nil)
    }
    
    
    
    fileprivate func chooseApplicantForProcesss(userId : String){
        
        self.mViewModel.confirmApplicantFromList(userId: userId, jobId: self.result?.id ?? ""){ [weak self] in
            self?.getChosenFreelancer()
        }
        
    }
    
}



extension JobDetailViewController : JobDetailDelegate {
    func onTapApplyApplicant(userId : String) {
        
        let alert = UIAlertController(title: "Chosen Applicant", message: "Are you sure you really want to apply for this person ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            
            
            self.chooseApplicantForProcesss(userId: userId)
            self.chosenUserId = userId
            
            
            
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {
            action in
            print("NO")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}


extension JobDetailViewController : HomeScreenDelegate {
    func showJobDetail(data: JobVO) {
        self.result = data
        self.activityIndicator.startAnimating()
    }
    
    func addJobPost() {
        return
    }
    
    
    
    
}

extension JobDetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mViewModel.applicant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfilePicCollectionViewCell.self), for: indexPath) as! ProfilePicCollectionViewCell
        cell.mData = mViewModel.applicant[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
}
extension JobDetailViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
