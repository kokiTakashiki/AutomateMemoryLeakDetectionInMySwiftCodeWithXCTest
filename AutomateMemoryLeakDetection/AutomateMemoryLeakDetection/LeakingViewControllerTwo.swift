//
//  LeakingViewControllerTwo.swift
//  AutomateMemoryLeakDetection
//
//  Created by takedatakashiki on 2023/08/30.
//

import UIKit

protocol LeakingViewControllerDelegate: AnyObject {
    func buttonClicked()
}

// this is memory leak code
//protocol LoadingView {
//    func startLoading()
//}

//class LeakingViewControllerPresenter: LeakingViewControllerDelegate {
//    var view: LoadingView
//
//    init(view: LoadingView) {
//        self.view = view
//    }
//
//    func buttonClicked() {
//        view.startLoading()
//        //do some operation ...
//    }
//}

protocol LoadingView: AnyObject {
    func startLoading()
}

class LeakingViewControllerPresenter: LeakingViewControllerDelegate {
    weak var view: LoadingView?

    init(view: LoadingView) {
        self.view = view
    }

    func buttonClicked() {
        view?.startLoading()
        //do some operation ...
    }
}

class LeakingViewControllerTwo: UIViewController, LoadingView {

    var delegate: LeakingViewControllerDelegate?

    lazy var button = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        self?.delegate?.buttonClicked()
    }))

    override func viewDidLoad() {
        view.addSubview(button)
    }

    func startLoading() {
        print("show view")
    }
}
