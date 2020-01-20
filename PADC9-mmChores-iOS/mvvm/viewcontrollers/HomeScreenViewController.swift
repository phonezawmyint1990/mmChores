//
//  HomeScreenViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 10/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialThemes
import RxSwift
import RxCocoa


class HomeScreenViewController: BaseViewController {
    var tabbar : UITabBar?
    
    @IBOutlet weak var tableViewJobPosts: UITableView!
    @IBOutlet weak var FabButton: MDCFloatingButton!
    
    var mViewModel : HomeScreenViewModel = HomeScreenViewModel()
    var data : [JobVO] = []
    
//    lazy var activityIndicator : UIActivityIndicatorView = {
//           let ui = UIActivityIndicatorView()
//           ui.translatesAutoresizingMaskIntoConstraints = false
//           ui.startAnimating()
//        ui.style = UIActivityIndicatorView.Style.medium
//           return ui
//       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mViewModel.query = mViewModel.baseQuery()
        setUpFAB()
        setUpTableView()
        self.getAllJobPost()
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableViewJobPosts.addSubview(self.refreshControl)
        self.view.addSubview(emptyView)
    }
    
    @objc func refresh(sender:AnyObject) {
        self.getAllJobPost()
        self.activityIndicator.stopAnimating()
    }
    
    func getAllJobPost(){
        if NetworkUtils.checkReachable() == false {
            self.emptyView.isHidden = false
            self.tableViewJobPosts.isHidden = true
            self.activityIndicator.stopAnimating()
            return
        }else{
            self.emptyView.isHidden = true
            self.tableViewJobPosts.isHidden = false
            self.activityIndicator.startAnimating()
            self.refreshControl.endRefreshing()
                mViewModel.requestData(tableView : self.tableViewJobPosts)
            if  mViewModel.result.count == 0 {
                     setEmptyView()
                  }else{
                      restoreTableView()
                  }
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getAllJobPost()
    }
    
    func setEmptyView() {
        let emptyView = UIView(frame: CGRect(x: self.tableViewJobPosts.center.x, y: self.tableViewJobPosts.center.y, width: self.tableViewJobPosts.bounds.size.width, height: self.tableViewJobPosts.bounds.size.height))
    
        let imageView = UIImageView()
        emptyView.addSubview(imageView)
        imageView.image = UIImage(named: "job_post_empty_img")
        imageView.contentMode = .scaleAspectFit
    
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        emptyView.addSubview(titleLabel)
        
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = POSTED_ANY_JOBS
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let button = UIButton(frame: .zero)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(POST_NEW_JOB_BTN_TITLE, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(button)
        button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        button.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -40).isActive = true
        button.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        
        self.tableViewJobPosts.backgroundView = emptyView
        self.tableViewJobPosts.separatorStyle = .none
    }
    
    @objc func pressed(sender: UIButton!) {
        addJobPost()
        }
        
        func restoreTableView() {
            self.tableViewJobPosts.backgroundView = nil
            self.tableViewJobPosts.separatorStyle = .none
        }
        
    
    @IBAction func onTapFABJobPost(_ sender: Any) {
        addJobPost()
    }
    
    fileprivate func setUpFAB() {
        let plusImage = UIImage(named: "icons8-plus")?.withRenderingMode(.alwaysTemplate)
        FabButton.setImage(plusImage, for: .normal)
        FabButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        FabButton.setElevation(ShadowElevation(rawValue: 12), for: .highlighted)
    }
    fileprivate func setUpTableView() {
        tableViewJobPosts.delegate = self
        tableViewJobPosts.dataSource = self
        tableViewJobPosts.registerForCell(strID: String(describing: JobsPostsTableViewCell.self))
        self.tableViewJobPosts.addSubview(FabButton)
    }
    
}
extension HomeScreenViewController : HomeScreenDelegate {
    func addJobPost() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: AddJobPostViewController.self)) as? AddJobPostViewController
        if let viewController = vc {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func showJobDetail(data : JobVO) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: JobDetailViewController.self)) as? JobDetailViewController
        vc?.result = data
        
        if let viewController = vc {
            viewController.modalPresentationStyle = .fullScreen
            
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
}

extension HomeScreenViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showJobDetail(data: mViewModel.result[indexPath.row])
    }
    
}
extension HomeScreenViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mViewModel.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: String(describing: JobsPostsTableViewCell.self), for: indexPath) as! JobsPostsTableViewCell
        item.mData = mViewModel.result[indexPath.row]
        return item
    }
    
    
}
