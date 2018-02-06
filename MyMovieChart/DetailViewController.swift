//
//  DetailViewController.swift
//  MyMovieChart
//
//  Created by Wonmi Kang on 2018. 1. 19..
//  Copyright © 2018년 odong. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var navibar: UINavigationItem!
    
    @IBOutlet weak var wv: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var movie:Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wv.navigationDelegate = self
        
        print("linkurl = \(self.movie?.linkUrl), title = \(self.movie?.title)")
        
        self.navibar.title = self.movie?.title
        
        let req = URLRequest(url: URL(string: (self.movie?.linkUrl)!)!)
        self.wv.load(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        let alert = UIAlertController(title: "오류", message: "상세페이지를 읽어오지 못했습니다", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
