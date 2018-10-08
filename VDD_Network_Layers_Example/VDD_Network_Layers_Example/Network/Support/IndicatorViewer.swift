//
//  IndicatorViewer.swift
//  Hemophilia_iOS
//
//  Created by vinhdd on 8/10/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import MBProgressHUD

class IndicatorViewer {
    static func show(atView view: UIView? = nil,
                     showDimBackground: Bool = true,
                     canInteractBehind: Bool = true) {
        let viewToShow = view ?? UIApplication.shared.windows.first ?? nil
        guard let showView = viewToShow else { return }
        let progressView = MBProgressHUD.showAdded(to: showView, animated: true)
        if showDimBackground {
            progressView.backgroundView.style = .solidColor
            progressView.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
        }
        progressView.removeFromSuperViewOnHide = true
        progressView.isUserInteractionEnabled = canInteractBehind
    }
    
    static func show(atView view: UIView? = nil,
                     text: String,
                     mode: MBProgressHUDMode,
                     showDimBackground: Bool = true,
                     canInteractBehind: Bool = true) {
        let viewToShow = view ?? UIApplication.shared.windows.first ?? nil
        guard let showView = viewToShow else { return }
        let progressView = MBProgressHUD.showAdded(to: showView, animated: true)
        progressView.label.text = text
        progressView.mode = mode
        if showDimBackground {
            progressView.backgroundView.style = .solidColor
            progressView.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
        }
        progressView.removeFromSuperViewOnHide = true
        progressView.isUserInteractionEnabled = canInteractBehind
    }
    
    static func hide(atView view: UIView? = nil, animated: Bool = true) {
        let viewToHide = view ?? UIApplication.shared.windows.first ?? nil
        guard let hideView = viewToHide else { return }
        MBProgressHUD.hide(for: hideView, animated: animated)
    }
}
