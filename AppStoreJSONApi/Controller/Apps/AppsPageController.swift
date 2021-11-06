//
//  AppsController.swift
//  AppStoreJSONApi
//
//  Created by Dmitriy Chernov on 11.02.2021.
//

import UIKit

class AppsPageController: BaseListController {
    
    let cellId = "id"
    let headerId = "headerId"
    var socialApps = [SocialApp]()
    var groups = [AppGroup]()
    
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchGames(completion: { appgroup, error in
            dispatchGroup.leave()
            group1 = appgroup
        })
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, err) in
            dispatchGroup.leave()
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group3 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, err) in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
            
        }
        
        dispatchGroup.notify(queue: .main) {
            print("completed your dispatch group tasks...")
            self.activityIndicator.stopAnimating()
        if let group = group1 {
            self.groups.append(group)
        }
        if let group = group2 {
            self.groups.append(group)
        }
        if let group = group3 {
            self.groups.append(group)
        }
        self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.socials = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            guard let self = self else { return }
            let appPage = AppDetailController()
            appPage.appId = feedResult.id
            appPage.navigationItem.title = feedResult.name
            self.navigationController?.pushViewController(appPage, animated: true)
        }
        return cell
    }
}

extension AppsPageController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
