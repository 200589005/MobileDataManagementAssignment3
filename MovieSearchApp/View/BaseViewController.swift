//
//  BaseViewController.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 21/07/24.
//

import UIKit
import Foundation

class BaseViewController: UIViewController {

    
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    //MARK: Constraints
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    
    
    func updateLayout() {
        self.view.updateConstraints()
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }
    
    func showSpinner(_ isUserInterectionEnable:Bool = true) {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.view.isUserInteractionEnabled = isUserInterectionEnable
            self.navigationController?.navigationBar.isUserInteractionEnabled = isUserInterectionEnable
            self.view.bringSubviewToFront(self.activityIndicatorView)
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
            return
        }
    }
    
    private func setupActivityIndicatorView() {
        if #available(iOS 13, *) {
            self.activityIndicatorView.style = .large
        }else{
            self.activityIndicatorView.style = .whiteLarge
        }
        self.activityIndicatorView.style = .gray
        self.activityIndicatorView.isHidden = true
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.color = UIColor.black //UIColor(hex: "FB6E52")
        self.view.addSubview(self.activityIndicatorView)
        activityIndicatorView.center = self.view.center
        self.activityIndicatorView.anchorCenterSuperview()
        return
        /*
        self.indicator.isHidden = true
        self.indicator.color = UIColor.AppTheme_RedColor
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
         */
    }
    
    
    
}
