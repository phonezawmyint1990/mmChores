//
//  ExploreJobViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 11/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialThemes

class ExploreJobViewController: BaseViewController {

    @IBOutlet weak var FabButton: MDCFloatingButton!
    @IBOutlet weak var tableViewExploreJobList: UITableView!
    public let viewModel = ExploreViewModel()
    public let disposeBag = DisposeBag()
    var exploreJobList : [JobVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableViewExploreJobList.addSubview(self.refreshControl)
        self.getAllExploreJob()
        self.view.addSubview(emptyView)
        setUpFAB()
    }
    
    @IBAction func onTapFAB(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let vc = storyboard.instantiateViewController(identifier: String(describing: AddJobPostViewController.self)) as? AddJobPostViewController
              if let viewController = vc {
                  viewController.modalPresentationStyle = .fullScreen
                  self.present(viewController, animated: true, completion: nil)
              }
    }
    
    fileprivate func setUpFAB() {
        let plusImage = UIImage(named: "icons8-plus")?.withRenderingMode(.alwaysTemplate)
        FabButton.setImage(plusImage, for: .normal)
        FabButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        FabButton.setElevation(ShadowElevation(rawValue: 12), for: .highlighted)
    }
    
    func getAllExploreJob(){
        if NetworkUtils.checkReachable() == false {
            self.tableViewExploreJobList.restore()
            self.activityIndicator.stopAnimating()
            self.emptyView.isHidden = false
            self.tableViewExploreJobList.isHidden = true
                return
        }else{
            self.emptyView.isHidden = true
            self.tableViewExploreJobList.isHidden = false
            
            self.tableViewExploreJobList.restore()
            activityIndicator.startAnimating()
            viewModel
                .findAllExploreJob()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.exploreJobList =  response
                    self.activityIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                    self.tableViewExploreJobList.reloadData()
                }, onError: { error in
                    self.activityIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                }).disposed(by: disposeBag)
        }
    }
    
    
    
    @objc func refresh(sender:AnyObject) {
        self.getAllExploreJob()
        self.activityIndicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllExploreJob()
    }
    
    fileprivate func setUpTableView(){
        tableViewExploreJobList.delegate = self
        tableViewExploreJobList.dataSource = self
        tableViewExploreJobList.registerForCell(strID: String(describing: ExploreJobListTableViewCell.self))
    }


}
extension ExploreJobViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let vc = storyboard.instantiateViewController(identifier: String(describing: JobDetailViewController.self)) as? JobDetailViewController
        vc?.result = exploreJobList[indexPath.row]
             
             if let viewController = vc {
                 viewController.modalPresentationStyle = .fullScreen
                 
                 self.present(viewController, animated: true, completion: nil)
             }
    }
    
}
extension ExploreJobViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.exploreJobList.count == 0 {
           self.tableViewExploreJobList.setGeneralEmptyView(title: NO_COMPLETE_JOB,message: "" , photo: "job_history_empty_img")
        }else{
            self.tableViewExploreJobList.restore()
        }
        return self.exploreJobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: String(describing: ExploreJobListTableViewCell.self), for: indexPath) as! ExploreJobListTableViewCell
        item.mdata = exploreJobList[indexPath.row]
        return item
        
    }
    
    
}
