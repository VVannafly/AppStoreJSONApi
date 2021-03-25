//
//  AppsHeaderHorizontalController.swift
//  AppStoreJSONApi
//
//  Created by Dmitriy Chernov on 11.02.2021.
//

import UIKit

class AppsHeaderHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var socials = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(AppHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socials.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppHeaderCell
        cell.companyLabel.text = socials[indexPath.item].name
        cell.titleLabel.text = socials[indexPath.item].tagline
        cell.imageView.sd_setImage(with: URL(string: socials[indexPath.item].imageUrl))
        return cell
    }
    
}
