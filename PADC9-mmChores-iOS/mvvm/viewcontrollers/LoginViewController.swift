//
//  LoginViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import MaterialComponents.MaterialTextFields
import RxSwift
import RxCocoa
import FirebaseAuth
class LoginViewController: BaseViewController{
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGooglePlus: UIButton!

    public let disposeBag = DisposeBag()
    public let viewModel = LoginViewModel()
    
    let user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        if (UserDefaults.standard.string(forKey: "ID") != nil) {
            goToMainPage()
        }
    }
    
    private func setUpUI(){
        self.navigationController?.isNavigationBarHidden = true
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        btnFacebook.layer.shadowColor = UIColor.black.cgColor
        btnFacebook.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        btnFacebook.layer.shadowOpacity = 1.0
        btnFacebook.layer.shadowRadius = 0.0
        btnFacebook.layer.masksToBounds = false
        
        btnGooglePlus.layer.shadowColor = UIColor.black.cgColor
        btnGooglePlus.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        btnGooglePlus.layer.shadowOpacity = 1.0
        btnGooglePlus.layer.shadowRadius = 0.0
        btnGooglePlus.layer.masksToBounds = false
        
        btnFacebook.titleLabel?.layer.shadowRadius = 3
        btnFacebook.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        btnFacebook.titleLabel?.layer.shadowOffset = CGSize(width: 5, height: 2)
        btnFacebook.titleLabel?.layer.shadowOpacity = 1
        btnFacebook.titleLabel?.layer.masksToBounds = false
        
        btnGooglePlus.titleLabel?.layer.shadowRadius = 3
        btnGooglePlus.titleLabel?.layer.shadowColor = UIColor.white.cgColor
        btnGooglePlus.titleLabel?.layer.shadowOffset = CGSize(width: 5, height: 2)
        btnGooglePlus.titleLabel?.layer.shadowOpacity = 1
        btnGooglePlus.titleLabel?.layer.masksToBounds = false
    
        btnFacebook.setImage(UIImage(named: "facebook_img"), for: .normal)
        let spacing: CGFloat = 8.0
        btnFacebook.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        btnFacebook.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        
        btnGooglePlus.setImage(UIImage(named: "googlePlus_img"), for: .normal)
        btnGooglePlus.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        btnGooglePlus.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        
    }
    
    @IBAction func btnFacebookAction(_ sender: Any) {
        if NetworkUtils.checkReachable() == false {
             Dialog.showAlert(viewController: self, title: ERROR, message: NO_INTERNET_CONNECTION)
            return
        }
        
        let fbLoginManager = LoginManager()
               fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                   if let error = error {
                       print("Failed to login: \(error.localizedDescription)")
                       return
                   }

                   guard let accessToken = AccessToken.current else {
                       print("Failed to get access token")
                       return
                   }
                    self.activityIndicator.startAnimating()
                   let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

                   // Perform login by calling Firebase APIs
                   Auth.auth().signIn(with: credential, completion: { (user, error) in
                       if let error = error {
                           print("Login error: \(error.localizedDescription)")
                           let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                           let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           alertController.addAction(okayAction)
                           self.present(alertController, animated: true, completion: nil)

                           return
                       }else{
                           print("Facebook Success")
                           let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "\(FACEBOOK_PROFILE_PIC).type(large),\(FACEBOOK_PROFILE_NAME),email"])
                           graphRequest.start { (connection, result, err) in
                               if let err = err {
                                   print(err.localizedDescription)
                                   return
                               }
                               print("Result",result)
                               if let facebookData = result as? NSDictionary{

                                   guard let profileName = facebookData.value(forKey: FACEBOOK_PROFILE_NAME) as? String else { return
                                   }

                                   guard let facebookId = facebookData.value(forKey: "id") as? String else {
                                       return
                                   }
                                   guard let profilePic = facebookData.value(forKey: FACEBOOK_PROFILE_PIC) else {
                                    return
                                   }

                                   guard let email = facebookData.value(forKey: "email") as? String else {
                                    return
                                   }

                                   let data = (profilePic as AnyObject).value(forKey: "data")
                                   let facebookProfileUrl = (data as AnyObject).value(forKey: "url") as? String
                                   guard let profileUrl = facebookProfileUrl else {return}
                                   let imageData: Data = try! Data(contentsOf: URL(string: profileUrl)!)

                                   self.user.name = profileName
                                   self.user.facebookId = facebookId
                                   self.user.photoUrl = profileUrl
                                   self.user.email = email

                                   self.viewModel.checkUser(userId: self.user.facebookId, findKey: "facebookID").subscribeOn(MainScheduler.instance).subscribe(onNext: {response in
                                       let isEqual = (response == CHECK_USER_SUCCESS)
                                       if isEqual {
                                          self.goToMainPage()
                                        self.activityIndicator.stopAnimating()
                                       }else{
                                           let storyboard = UIStoryboard(name: "Login", bundle: nil)
                                           let vc =  storyboard.instantiateViewController(identifier: String(describing: RegisterViewController.self)) as! UINavigationController
                                           let navCtrl = vc.viewControllers.first as! RegisterViewController
                                           navCtrl.user = self.user
                                           navCtrl.modalPresentationStyle = .fullScreen
                                           self.navigationController?.pushViewController(navCtrl, animated: true)
                                        self.activityIndicator.stopAnimating()
                                       }
                                   }).disposed(by: self.disposeBag)
                               }
                           }
                       }
                   })

               }
    }
    
    @IBAction func btnGooglePlusAction(_ sender: Any) {
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: ERROR, message: NO_INTERNET_CONNECTION)
            return
        }
        self.activityIndicator.startAnimating()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    fileprivate func goToMainPage(){
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let vc =  storyboard.instantiateViewController(identifier: String(describing: MyTabBarCtrl.self)) as! MyTabBarCtrl
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
     if let error = error {
         print(error.localizedDescription)
       return
     }
     
     guard let authentication = user.authentication else { return }
     let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
     
     Auth.auth().signIn(with: credential) { (authResult, error) in
       if let error = error {
         print(error.localizedDescription)
         return
       }else{
         print("Login Sucessful")
         }
     }
     
     let user: GIDGoogleUser = GIDSignIn.sharedInstance()!.currentUser
        self.user.name = user.profile.name
        self.user.email = user.profile.email
        self.user.googlePlusId = user.userID
        self.user.photoUrl = user.profile.imageURL(withDimension: 100)!.absoluteString
        viewModel.checkUser(userId: user.userID,findKey: "googlePlusID")
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
            let isEqual = (response == CHECK_USER_SUCCESS)
                if isEqual {
                    self.goToMainPage()
                    self.activityIndicator.stopAnimating()
                    }else{
                    let storyboard = UIStoryboard(name: LOGIN_STORYBOARD, bundle: nil)
                    let vc =  storyboard.instantiateViewController(identifier: String(describing: RegisterViewController.self)) as! UINavigationController
                    let navCtrl = vc.viewControllers.first as! RegisterViewController
                    navCtrl.user = self.user
                    navCtrl.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(navCtrl, animated: true)
                    self.activityIndicator.stopAnimating()
                }
            },onError: { err in
                print("Login Controller CheckUser", err)
            }).disposed(by: disposeBag)
    }
}
