//
//  ViewController.swift
//  inAppPruchaseExample
//
//  Created by Yiu Yu on 26/10/2022.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    enum Product: String, CaseIterable
    {
        case gems = "com.yiuyu.inAppPruchaseExample.Gems"
        case nonadspremium =  "com.yiuyu.inAppPruchaseExample.Premium"
        case monthlysubscription = "com.yiuyu.inAppPruchaseExample.Monthly"
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first
        {
            print("product is available")
            self.purchase(aProduct: oProduct)
        } else {
            print("product is not available")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Customer is in the process of purchase")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Purchase Completed")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Purchase Failed")
            case .restored:
                print("Restored")
            case .deferred:
                print("Deferred")
            default:
                print("Purchase Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
                  
    func purchase(aProduct: SKProduct) {
        let payment = SKPayment(product: aProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
                  
    @IBAction func buyGems(_ sender: UIButton) {
        if SKPaymentQueue.canMakePayments() {
            let set: Set<String> = [Product.gems.rawValue]
            
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    @IBAction func buyPremium(_ sender: UIButton) {
        if SKPaymentQueue.canMakePayments() {
            let set: Set<String> = [Product.nonadspremium.rawValue]
            
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }

    }
    
    @IBAction func buyMonthlySubscription(_ sender: UIButton) {
        if SKPaymentQueue.canMakePayments() {
            let set: Set<String> = [Product.monthlysubscription.rawValue]
            
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

