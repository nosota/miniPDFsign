//
//  ShareViewController.swift
//  ShareExtension
//
//  Created for miniPDFSign
//

import UIKit

class ShareViewController: RSIShareViewController {

    // Automatically redirect to host app after sharing
    override func shouldAutoRedirect() -> Bool {
        return true
    }
}
