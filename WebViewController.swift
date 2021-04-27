//
//  WebViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 04.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var urlString : String!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        let activityItems = [urlString] as! Array<String>
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityController.excludedActivityTypes = [.postToFacebook]
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func safariButtonTapped(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(URL(string: urlString)!)
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    @IBAction func reload(_ sender: UIBarButtonItem) {
        webView.reload()
    }
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

           if keyPath == "estimatedProgress" {
               if webView.estimatedProgress == 1.0 {
                   navigationItem.title = webView.title
               } else {
                   navigationItem.title = "Loading…"
               }
           }
       }
}
