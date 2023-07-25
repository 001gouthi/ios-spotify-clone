//
//  AuthViewController.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 6/27/23.
//

import UIKit
import WebKit

class AuthViewController: UIViewController,WKNavigationDelegate,UIWebViewDelegate {
    
    private let webView:WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,configuration:config)
       return webView
    }()
    
    public var completionHandler: ((Bool)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signInURL else {
            print("signIn url empty ")
            return
        }
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.navigationDelegate = self
        print("url is \(url)")
        webView.load(URLRequest(url:url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else{
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name=="code"})?.value else{
            return
        }
    print("code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code){ [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//            if let url = navigationAction.request.url, let queryItems = URLComponents(string: url.absoluteString)?.queryItems {
//                for item in queryItems {
//                    if item.name == "code" {
//                        if let parameterValue = item.value {
//                            // Handle the parameter value as needed
//                            print("Parameter value: \(parameterValue)")
//                        }
//                    }
//                }
//            }
//
//            // Continue with the navigation
//            decisionHandler(.allow)
//        }

    
    
}
