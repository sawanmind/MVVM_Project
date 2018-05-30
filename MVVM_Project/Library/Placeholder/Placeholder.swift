//
//  Placeholder.swift
//  MVVM_Project
//
//  Created by iOS Development on 5/21/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import Foundation
import UIKit



protocol PlaceholderDelegate: class {
    func didTapTryAgain()
    func getView(view:NSObject)
}
extension PlaceholderDelegate {
    func didTapTryAgain(){}
    func getView(view:NSObject){}
}


fileprivate enum PlaceholderErrorType: String {
    case internetUnavailable = "Internet Unavailable"
    case empty = "Oops!\nNothing found."
    case serverError = "Something went wrong!\nPlease try again later."
}

public class Placeholder : UIView , PlaceholderDelegate{
   
    
    
    var delegate: PlaceholderDelegate?
    var _isHidden: DynamicType<Bool> = DynamicType(true)
    var dataSource: NSObject?
    let reachability = Reachability()!
    
 
 
  fileprivate  func setupReachability(){
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
  
    
    
    @objc fileprivate func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            if self._isHidden.value == true {
                self.hideElements(true)
                self.didTapTryAgainButton()
                self.activityIndicatior.showLoading()
                
            } else {
                self.activityIndicatior.hideLoading()
            }
           
            print("Reachable via WiFi")
        case .cellular:
            if self._isHidden.value == false {
                self.hideElements(true)
                self.didTapTryAgainButton()
                self.activityIndicatior.showLoading()
            } else {
                self.activityIndicatior.hideLoading()
            }
            print("Reachable via Cellular")
        case .none:
             self._isHidden.value = true
             if self._isHidden.value == true {
                self.hideElements(false)
                self.activityIndicatior.hideLoading()
                self.errorLabel.text = PlaceholderErrorType.internetUnavailable.rawValue
             }
             print("Network not reachable")
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
        self.setupErrorLabel()
        self.setupReachability()
        self._isHidden.bind(listner: {
            self.activityIndicatior.hideLoading()
            self.hideElements($0)
        })
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hideElements(_ isHidden:Bool) {
        
        if isHidden == true {
            self.errorLabel.isHidden = true
            self.tryAgainLabel.isHidden = true
            self.iconView.isHidden = true
            bounceAnimator(element: self, completion: {})
        } else {
            self.errorLabel.isHidden = false
            self.tryAgainLabel.isHidden = false
            self.iconView.isHidden = false
            bounceAnimator(element: self, completion: {})
        }
      
    }
    
  private  lazy var errorLabel:UILabel = {
        let instance = UILabel()
        instance.adjustsFontForContentSizeCategory = true
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.font = UIFont.systemFont(ofSize: 19.5, weight: UIFont.Weight.medium)
        instance.textColor = UIColor.lightGray
        instance.textAlignment = .center
        instance.numberOfLines = 0
        instance.lineBreakMode = .byWordWrapping
        return instance
    }()
    
    private lazy var iconView: UIButton = {
        let instance = UIButton()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.contentMode = .scaleAspectFit
        instance.tintColor = UIColor.red
        return instance
    }()
    
   private lazy var tryAgainLabel:UIButton = {
        let instance = UIButton(type: UIButtonType.roundedRect)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.titleLabel?.font = UIFont.systemFont(ofSize: 12.6, weight: UIFont.Weight.regular)
        instance.setTitle("Retry", for: .normal)
        instance.setTitleColor(UIColor.lightGray, for: .normal)
        instance.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
        instance.tintColor = UIColor.gray
        instance.layer.borderColor = UIColor.lightGray.cgColor
        instance.layer.borderWidth = 1
        instance.layer.cornerRadius = 2.5
        instance.layer.masksToBounds = true
        return instance
    }()
    
    private lazy var activityIndicatior:UIButton = {
        let instance = UIButton(type: .system)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.tintColor = UIColor.gray
        return instance
    }()
    
    @objc private func didTapTryAgainButton(){
        logoAnimator(element: self.activityIndicatior)
        delegate?.didTapTryAgain()
    }
    
    private func setupErrorLabel() {
        self.addSubview(errorLabel)
        
        errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -64).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: self.widthAnchor,constant: -40).isActive = true
        errorLabel.heightAnchor.constraint(equalTo: errorLabel.heightAnchor).isActive = true
        
        self.addSubview(tryAgainLabel)
        
        tryAgainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tryAgainLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor,constant: 24).isActive = true
        tryAgainLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        tryAgainLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
       
        self.addSubview(activityIndicatior)
        activityIndicatior.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatior.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -64).isActive = true
        activityIndicatior.widthAnchor.constraint(equalToConstant: 56).isActive = true
        activityIndicatior.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        self.addSubview(iconView)
        
        iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconView.bottomAnchor.constraint(equalTo: errorLabel.topAnchor,constant: -24).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 86).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 76).isActive = true
    }
}


extension Placeholder {
    class DynamicType<T> {
        typealias Listener = (T) -> Void
        var listener:Listener?
        var value:T { didSet { listener?(value) } }
        init(_ value:T) { self.value = value }
        func bind(listner:Listener?) { self.listener = listner ; listener?(value) }
    }

}


public extension UIButton {
    
    private struct AssociatedKeys {
        static var kUIActivityIndicatorView = "UIActivityIndicatorView"
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kUIActivityIndicatorView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kUIActivityIndicatorView) as? UIActivityIndicatorView
        }
    }
    
    public func showLoading() {
        
        self.setTitle("", for: UIControlState.normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    public func hideLoading() {
        self.setTitle("", for: UIControlState.normal)
        activityIndicator?.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.tintColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator!)
        centerActivityIndicatorInButton()
        activityIndicator?.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
















