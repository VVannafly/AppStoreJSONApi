//
//  BaseListController.swift
//  AppStoreJSONApi
//
//  Created by Dmitriy Chernov on 11.02.2021.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
