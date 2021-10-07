//
//  VKLoginViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 07.10.2021.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: Private properties
    
    private var loadingView: LoadingView!
    
    // MARK: Public properties
    
    var urComponents: URLComponents = {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: "7969501"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        return urlComp
    }()
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeSetup()
    }
    
    // MARK: Actions
    
    // MARK: Private methods
    
    private func initializeSetup() {
        loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.frame = view.frame
        webView.navigationDelegate = self
        if UserManager.shared.isAuthorized {
            showMain()
        }
        else {
            guard let url = urComponents.url else { return }
            webView.load(URLRequest(url: url))
        }
    }
    
    private func showMain() {
        let mainTC = UIStoryboard(name: "Navigation", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationController?.pushViewController(mainTC, animated: true)
    }
}

// MARK: Extension for WKNavigationDelegate

extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        loadingView.animate()
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else { return decisionHandler(.allow) }
        let paramenters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String : String]()) { (result, params) in
                var dict = result
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
            }
        loadingView.stopAnimate()
        guard let token = paramenters["access_token"],
            let userIDString = paramenters["user_id"],
            let userId = Int(userIDString)
              else { return decisionHandler(.allow) }
        UserManager.shared.saveUserToken(token, id: userId)
        decisionHandler(.cancel)
        showMain()
    }
}
