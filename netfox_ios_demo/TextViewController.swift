//
//  TextViewController.swift
//  netfox_ios_demo
//
//  Created by Nathan Jangula on 10/12/17.
//  Copyright © 2017 kasketis. All rights reserved.
//

import UIKit
import netfox_ios

class TextViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var session: URLSession!
    var dataTask: URLSessionDataTask?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func tappedLoad(_ sender: Any) {

        let vc = NFX.sharedInstance().getMainViewController()

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    private func handleCompletion(error: String?, data: Data?) {
        DispatchQueue.main.async {
            
            if let error = error {
                NSLog(error)
                return
            }
            
            if let data = data {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let message = dict?["value"] as? String {
                        self.textView.text = message
                    }
                } catch {
                    
                }
            }
        }
    }
}

extension TextViewController : URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
    }
}

