//
//  HistoryJobViewController.swift
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

class HistoryJobViewController: BaseViewController {
    
    @IBOutlet weak var tableViewHistoryJobList: UITableView!
    
    @IBOutlet weak var FabButton: MDCFloatingButton!
    
    public let viewModel = HistoryViewModel()
    public let disposeBag = DisposeBag()
    var historyJobList: [JobVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableViewHistoryJobList.addSubview(self.refreshControl)
        self.getAllHistory()
        self.view.addSubview(emptyView)
        setUpFAB()
    }
    fileprivate func setUpFAB() {
           let plusImage = UIImage(named: "icons8-plus")?.withRenderingMode(.alwaysTemplate)
           FabButton.setImage(plusImage, for: .normal)
           FabButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
           FabButton.setElevation(ShadowElevation(rawValue: 12), for: .highlighted)
       }
    
    @IBAction func onTapFAB(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let vc = storyboard.instantiateViewController(identifier: String(describing: AddJobPostViewController.self)) as? AddJobPostViewController
              if let viewController = vc {
                  viewController.modalPresentationStyle = .fullScreen
                  self.present(viewController, animated: true, completion: nil)
              }
    }
    
    func getAllHistory(){
        if NetworkUtils.checkReachable() == false {
            self.emptyView.isHidden = false
            self.tableViewHistoryJobList.isHidden = true
            self.activityIndicator.stopAnimating()
                return
            }else{
            self.emptyView.isHidden = true
            self.tableViewHistoryJobList.isHidden = true
                self.tableViewHistoryJobList.restore()
                activityIndicator.startAnimating()
                viewModel.findAllHistory()
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: {response in
                        self.historyJobList = response
                        self.activityIndicator.stopAnimating()
                        self.refreshControl.endRefreshing()
                        self.tableViewHistoryJobList.isHidden = false
                        self.tableViewHistoryJobList.reloadData()
                    }, onError: {error in
                        self.activityIndicator.stopAnimating()
                        self.refreshControl.endRefreshing()
                    })
                    .disposed(by: disposeBag)
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllHistory()
    }
    
    @objc func refresh(sender:AnyObject) {
        self.getAllHistory()
        self.activityIndicator.stopAnimating()
    }
    
    fileprivate func setupTableView(){
        tableViewHistoryJobList.delegate = self
        tableViewHistoryJobList.dataSource = self
        tableViewHistoryJobList.registerForCell(strID: String(describing: HistoryJobListTableViewCell.self))
    }
    
}
extension HistoryJobViewController : UITableViewDelegate{
    
}

extension HistoryJobViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.historyJobList.count == 0 {
           self.tableViewHistoryJobList.setGeneralEmptyView(title: NO_COMPLETE_JOB,message: "" , photo: "job_history_empty_img")
        }else{
            self.tableViewHistoryJobList.restore()
        }
        return historyJobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryJobListTableViewCell.self), for: indexPath) as! HistoryJobListTableViewCell
        item.mdata = historyJobList[indexPath.row]
        return item
        
    }
    
    
}
