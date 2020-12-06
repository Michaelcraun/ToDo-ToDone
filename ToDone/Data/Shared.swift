//
//  Shared.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class Shared {
    static let instance = Shared()
    
    var isPremium = false
    
    var selectedCategory: Category?
    var createdSubToDo: SubToDo?
    
    var productPurchasing = SKProduct()
    var productList = [SKProduct]()
}

enum Products: String {
    case premium = "com.CraunicProductions.HoneyDo.premium"
}
