//
//  IAPHandler.swift
//
//  Created by Dejan Atanasov on 13/07/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit
import StoreKit

class NetworkIndicator: NSObject {
    private static var loadingCount = 0
    
    class func networkOperationStarted() {
        if loadingCount == 0 { UIApplication.shared.isNetworkActivityIndicatorVisible = true }
        loadingCount += 1
    }
    
    class func networkOperationFinished() {
        if loadingCount > 0 { loadingCount -= 1 }
        if loadingCount == 0 { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
    }
}
