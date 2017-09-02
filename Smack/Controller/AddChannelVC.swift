//
//  AddChannelVC.swift
//  Smack
//
//  Created by Sean Perez on 9/2/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    @IBOutlet weak var channelNameTextField: CustomTextField!
    @IBOutlet weak var channelDescriptionTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardDismissal()
        registerForViewControllerDismissal()
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelButtonPressed(_ sender: Any) {
        guard let channelName = channelNameTextField.text, channelName != "", let channelDescription = channelDescriptionTextField.text else { return }
        SocketService.instance.addChannel(channelName, channelDescription: channelDescription) { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension AddChannelVC: ViewControllerIsDismissableByTap, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
