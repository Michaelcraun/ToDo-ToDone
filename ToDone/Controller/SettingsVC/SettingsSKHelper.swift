//
//  SettingsSKHelper.swift
//  ToDone
//
//  Created by Michael Craun on 10/13/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import StoreKit

extension SettingsVC {
    
    func checkPurchases() {
        
        print("checkPurchases()")
        
        Shared.isPremium = defaults.bool(forKey: "isPremium")
        
    }
    
    func buyProduct(productID: String) {
        
        print("buyProduct(productID:)")
        print(productID)
        
        for product in Shared.productList {
            
            let productToCheck = product.productIdentifier
            
            if productToCheck == productID {
                
                Shared.productPurchasing = product
                print(Shared.productPurchasing.productIdentifier)
                
                NetworkIndicator.networkOperationStarted()
                
                let pay = SKPayment(product: Shared.productPurchasing)
                
                SKPaymentQueue.default().add(self)
                SKPaymentQueue.default().add(pay)
                
                NetworkIndicator.networkOperationFinished()
                
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("productsRequest()")
        
        NetworkIndicator.networkOperationStarted()
        
        let myProducts = response.products
        
        print(myProducts)
        
        for product in myProducts {
            
            print(product.productIdentifier)
            Shared.productList.append(product)
            
        }
        
        NetworkIndicator.networkOperationFinished()
        
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        print("paymentQueueRestoreCompletedTransactionFinished")
        
        for transaction in queue.transactions {
            
            let t: SKPaymentTransaction = transaction
            let productID = t.payment.productIdentifier
            
            switch productID {
            case Products.premium.rawValue:
                Shared.isPremium = true
                defaults.set(Shared.isPremium, forKey: "isPremium")
            default: break
            }
        }
        
        let alert = UIAlertController(title: "Restore Successful", message: "Your products have been restored. Thank you!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        NetworkIndicator.networkOperationFinished()
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        print("paymentQueue()")
        
        NetworkIndicator.networkOperationStarted()
        
        for transaction: AnyObject in transactions {
            
            let trans = transaction as! SKPaymentTransaction
            
            print(trans.transactionState.rawValue)
            
            switch trans.transactionState {
            case .purchased:
                let productID = Shared.productPurchasing.productIdentifier
                
                switch productID {
                case Products.premium.rawValue:
                    Shared.isPremium = true
                    defaults.set(Shared.isPremium, forKey: "isPremium")
                default: break
                }
                
                let alert = UIAlertController(title: "Purchase Successful", message: "Your purchase was successful. Thank you!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(alert, animated: true, completion: nil)
                
                queue.finishTransaction(trans)
            case .failed:
                let alert = UIAlertController(title: "Purchase Failed", message: "Your purchase failed. Please try again later or contact support.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(alert, animated: true, completion: nil)
                
                queue.finishTransaction(trans)
            default: break
            }
        }
        
        NetworkIndicator.networkOperationFinished()
        
    }
}
