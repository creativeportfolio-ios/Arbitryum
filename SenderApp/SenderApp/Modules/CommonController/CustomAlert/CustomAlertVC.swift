//
//  CustomAlertVC.swift
//  
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

///
class CustomAlertVC: UIViewController {

    // MARK: Outlets
    ///
    @IBOutlet weak var lblTitle: UILabel!
    ///
    @IBOutlet weak var lblMessage: UILabel!
    ///
    @IBOutlet weak var imgAlertIcon: UIImageView!
    ///
    @IBOutlet weak var vwSingleButton: UIView!
    ///
    @IBOutlet weak var vwTwoButtons: UIView!
    ///
    @IBOutlet weak var btnOK: UIButton!
    ///
    @IBOutlet weak var btnCancel: UIButton!
    ///
    @IBOutlet weak var btnOther: UIButton!
    
    ///
    @IBOutlet weak var heightConstraintIcon: NSLayoutConstraint!
    ///
    @IBOutlet weak var topConstraintIcon: NSLayoutConstraint!

    // MARK: Variables

    ///
    typealias CustomAlertViewTapButtonBlock = (Int) -> Void
    ///
    var messageTitle: String = ""
    ///
    var messageText: String = ""
    ///
    var attributedText: NSAttributedString?
    ///
    var alertIcon: UIImage?
    ///
    var cancelButtonTitle: String = ""
    ///
    var otherButtonTitles: [String]?
    ///
    var buttonDidTappedBlock: CustomAlertViewTapButtonBlock?

    // MARK: User Actions
    
    ///
    @IBAction func alertButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: {[weak self] in
            if self?.buttonDidTappedBlock != nil {
                self?.buttonDidTappedBlock?(sender.tag)
            }
        })
    }

    // MARK: Life Cycle Methods
    
    ///
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    ///
    convenience init(WithTitle title: String, message: String, attrString: NSAttributedString? = nil, alertIcon: UIImage?, cancelButtonTitle: String, otherButtonTitles: [String]?) {
        self.init(nibName: "CustomAlertVC", bundle: nil)
        self.modalPresentationStyle = .overFullScreen

        self.messageTitle = title
        if let strAttr = attrString {
            let attString = NSMutableAttributedString()
            if message != "" {
                attString.append(NSMutableAttributedString(string: message))
            }
            attString.append(strAttr)
            self.attributedText = attString
        } else {
            self.messageText = message
        }
        self.alertIcon = alertIcon
        self.cancelButtonTitle = cancelButtonTitle
        self.otherButtonTitles = otherButtonTitles
    }

    // MARK: - Life Cycle methods

    ///
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    ///
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    ///
    func setupUI() {
        lblTitle.text = messageTitle
        if attributedText != nil {
            lblMessage.attributedText = attributedText
        } else {
            lblMessage.text = messageText
        }
        imgAlertIcon.image = alertIcon
        btnCancel.layer.borderWidth = 1.0
        btnCancel.layer.borderColor = UIColor.lightGray.cgColor

        if alertIcon == nil {
            // Icon height changed to 0 when not to be shown
            heightConstraintIcon.constant = 0.0
            topConstraintIcon.constant = 0.0
        } else {
            // Icon height is 70 by default, with 8 top spacing
            heightConstraintIcon.constant = 70.0
            topConstraintIcon.constant = 8.0
        }

        if otherButtonTitles == nil {
            vwTwoButtons.isHidden = true
            vwSingleButton.isHidden = false

            btnOK.setTitle(cancelButtonTitle, for: .normal)
            btnOK.setTitle(cancelButtonTitle, for: .highlighted)
            btnOK.setTitle(cancelButtonTitle, for: .selected)
            btnOK.titleLabel?.adjustsFontSizeToFitWidth = true
        } else {
            vwTwoButtons.isHidden = false
            vwSingleButton.isHidden = true

            btnCancel.setTitle(cancelButtonTitle, for: .normal)
            btnCancel.setTitle(cancelButtonTitle, for: .highlighted)
            btnCancel.setTitle(cancelButtonTitle, for: .selected)
            btnCancel.titleLabel?.adjustsFontSizeToFitWidth = true

            btnOther.setTitle(otherButtonTitles?[0], for: .normal)
            btnOther.setTitle(otherButtonTitles?[0], for: .highlighted)
            btnOther.setTitle(otherButtonTitles?[0], for: .selected)
            btnOther.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
}
