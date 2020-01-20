//
//  ProfileViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ProfileViewController: BaseViewController {
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var btnLobin: UIButton!
    @IBOutlet weak var lblProfile: UILabel!
    
    public let disposeBag = DisposeBag()
    public let viewModel = ProfileViewModel()
    var profile: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        ivProfile.layer.cornerRadius = ivProfile.frame.size.width / 2
        btnLobin.layer.cornerRadius = 25
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: String(describing: ProfileTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileTableViewCell.self))
        profileTableView.rowHeight = 80
        profileTableView.separatorColor = .clear
        self.getProfileData()
        self.view.addSubview(emptyView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProfileData()
    }
    
    func getProfileData(){
            if NetworkUtils.checkReachable() == false {
                self.profileTableView.restore()
                self.emptyView.isHidden = false
                self.profileTableView.isHidden = true
                    return
            }else{
                self.profileTableView.restore()
                self.emptyView.isHidden = true
                self.profileTableView.isHidden = true
                activityIndicator.startAnimating()
                 viewModel.findByUserId(userId: UserDefaults.standard.string(forKey: USERDEFAULT_ID_KEY)!).observeOn(MainScheduler.instance).subscribe(onNext:{response in
                         self.ivProfile.sd_setImage(with: URL(string: response.photoUrl))
                         self.profile = response
                        self.profileTableView.isHidden = false
                         self.profileTableView.reloadData()
                         print("FirebaseResponse",response.name)
                     self.activityIndicator.stopAnimating()
                     }).disposed(by: disposeBag)
        }
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: USERDEFAULT_ID_KEY)
        let storyboard = UIStoryboard(name: LOGIN_STORYBOARD, bundle: nil)
        let vc =  storyboard.instantiateViewController(identifier: String(describing: LoginViewController.self)) as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}



extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.profile == nil {
           self.profileTableView.setGeneralEmptyView(title: NO_COMPLETE_JOB,message: "" , photo: "job_history_empty_img")
        }else{
            self.profileTableView.restore()
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTableViewCell.self), for: indexPath) as! ProfileTableViewCell
        switch indexPath.row {
        case 0:
            cell.lblKey.text = PROFILE_USER_NAME
            cell.lblValue.text = self.profile?.name
        case 1:
            cell.lblKey.text = PROFILE_USER_EMAIL
            cell.lblValue.text = self.profile?.email
        case 2:
            cell.lblKey.text = PROFILE_USER_PHNO
            cell.lblValue.text = self.profile?.phoneNo
        case 3:
            cell.lblKey.text = PROFILE_USER_DOB
            cell.lblValue.text = self.profile?.dob
        default:
            break
        }
        return cell
    }
    
    
}


extension ProfileViewController: UITableViewDelegate{
    
}


