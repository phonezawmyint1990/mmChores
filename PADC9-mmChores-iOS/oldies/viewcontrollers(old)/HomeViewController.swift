//
//  HomeViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomAppBar_ColorThemer


class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewServiceList: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

    }
    
    fileprivate  func setupCollectionView() {
        
        collectionViewServiceList.delegate = self
        collectionViewServiceList.dataSource = self
        let nib = UINib(nibName: String(describing: ServiceListCollectionViewCell.self), bundle: nil)
        collectionViewServiceList.register(nib, forCellWithReuseIdentifier: String(describing: ServiceListCollectionViewCell.self))
        
        let layout = collectionViewServiceList.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 20
        
        let itemWidth = (self.view.frame.width - 5) / 2
   
        layout.itemSize = CGSize(width: itemWidth - 25, height: 180)
        
        
    }


}

    


extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ServiceListCollectionViewCell.self), for: indexPath)
        return cell
        
    }
    
    
    
}
