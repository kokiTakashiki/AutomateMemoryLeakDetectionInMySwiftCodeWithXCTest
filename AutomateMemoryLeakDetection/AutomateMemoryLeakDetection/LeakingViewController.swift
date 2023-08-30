//
//  LeakingViewController.swift
//  AutomateMemoryLeakDetection
//
//  Created by takedatakashiki on 2023/08/30.
//

import UIKit

class LeakingViewController: UIViewController {

    // this is memory leak code
//    lazy var button = UIButton(primaryAction: UIAction(handler: { _ in
//        self.onButtonAction()
//    }))

    lazy var button = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        self?.onButtonAction()
    }))

    override func viewDidLoad() {
        view.addSubview(button)
    }

    func onButtonAction() {
        print("")
    }
}
