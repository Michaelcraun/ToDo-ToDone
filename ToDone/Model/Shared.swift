//
//  Shared.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

class Shared {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let displayFont = UIFont(name: "Arial", size: 15)
    static let smallFont = UIFont(name: "Arial", size: 8)
    
    static var selectedCategory: Category?
    static var createdSubToDo: SubToDo?
    
    static var isPremium = false
    
}
