//
//  HeaderTableViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var pagingControl: UIPageControl!
    @IBOutlet weak var collectionViewHeader: UICollectionView!
    
    
    var delegate : RequestListDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        
    }
    
    fileprivate func setupCollectionView() {
        
        collectionViewHeader.delegate = self
        collectionViewHeader.dataSource = self
        let nib = UINib(nibName: String(describing: HeaderUICollectionViewCell.self), bundle: nil)
        collectionViewHeader.register(nib, forCellWithReuseIdentifier:String(describing: HeaderUICollectionViewCell.self))
        
        let layout = collectionViewHeader.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 20
        pagingControl.numberOfPages = 8
        
        
    }
}
extension HeaderTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderUICollectionViewCell.self), for: indexPath)
        return cell
    }
    
    
}
extension HeaderTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return  CGSize(width: self.frame.width , height: 220)

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      pagingControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onTapAcceptedList()
        
    }
}
