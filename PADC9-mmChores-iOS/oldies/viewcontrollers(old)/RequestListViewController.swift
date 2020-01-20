//
//  RequestListViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class RequestListViewController: UIViewController {
    
    @IBOutlet weak var tableViewRequestList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        
    }
    fileprivate func setupTableView(){
        
        tableViewRequestList.delegate = self
        tableViewRequestList.dataSource = self
        
        tableViewRequestList.registerForCell(strID: String(describing: HeaderTableViewCell.self))
        tableViewRequestList.registerForCell(strID: String(describing: TitleTableViewCell.self))
        tableViewRequestList.registerForCell(strID: String(describing: LastFooterTableViewCell.self))
        
        self.tableViewRequestList.separatorStyle = .none
        
    }
   
    
}

extension RequestListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 {
          return 315
            
         }
        else if indexPath.row == 1 {
            return 70
        }
        else
        {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
          onTapAcceptedList()
        } else if indexPath.row == 1 {
            return
        } else {
            onTapUnAcceptedList()
        }
    }
}

extension RequestListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let item = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableViewCell.self), for: indexPath) as! HeaderTableViewCell
            item.delegate = self 
            return item
            
        } else if indexPath.row == 1 {
            
            let item = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleTableViewCell.self), for: indexPath) as! TitleTableViewCell
            return item
            
            
        } else  {
            let item = tableView.dequeueReusableCell(withIdentifier: String(describing: LastFooterTableViewCell.self), for: indexPath) as! LastFooterTableViewCell
            return item
            
        }
        
    }
    
    
    
}
extension RequestListViewController : RequestListDelegate {
  
    
    func onTapAcceptedList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: ServiceDetailViewController.self)) as? ServiceDetailViewController
        if let viewController = vc {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
    }
    }
    
    func onTapUnAcceptedList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: ServiceDetailViewController.self)) as? ServiceDetailViewController
        if let viewController = vc {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
    }
    
    }
}
