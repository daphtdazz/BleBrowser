//
//  ConsoleLogViewController.swift
//  BleBrowser
//
//  Created by David Park on 23/09/2018.
//

import UIKit

class ConsoleLogViewController: UIViewController {

    var log: WBLog! = nil {
        willSet { self._unsubscribeFromLogChanges() }
        didSet { self._subscribeToLogChanges() }
    }

    deinit {
        self._unsubscribeFromLogChanges()
    }

    @IBAction func toggleSelected(_ sender: UITapGestureRecognizer) {
        self.log.isSelected = !self.log.isSelected
    }

    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? WBLog === self.log {
            self._updateView()
        }
    }

    // MARK: Internal
    func _subscribeToLogChanges() {
        self.log?.addObserver(self, forKeyPath: "isSelected", options: [.initial, .new], context: nil)
    }
    func _unsubscribeFromLogChanges() {
        self.log?.removeObserver(self, forKeyPath: "isSelected")
    }
    func _updateView() {
        if !self.log.isSelected {
            self.view.backgroundColor = UIColor.lightGray
        } else {
            self.view.backgroundColor = UIColor.groupTableViewBackground
        }
    }
}
