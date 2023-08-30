//
//  LeakingViewControllerTests.swift
//  AutomateMemoryLeakDetectionTests
//
//  Created by takedatakashiki on 2023/08/30.
//

import XCTest
@testable import AutomateMemoryLeakDetection

class LeakingViewControllerTests: XCTestCase {

    func testExample() throws {
        let viewController = LeakingViewController()

        _ = viewController.view

        addTeardownBlock { [weak viewController] in
            XCTAssertNil(viewController, "Object should be deallocated. Detected memory leak.")
        }
    }

    func testExampleTwo() throws {
        let viewController = LeakingViewControllerTwo()
        let presenter = LeakingViewControllerPresenter(view: viewController)
        viewController.delegate = presenter

        _ = viewController.view

//        addTeardownBlock { [weak viewController, weak presenter] in
//            XCTAssertNil(viewController, "Object should be deallocated. Detected memory leak.")
//            XCTAssertNil(presenter, "Object should be deallocated. Detected memory leak.")
//        }

        trackForMemoryLeak(instance: viewController)
        trackForMemoryLeak(instance: presenter)
    }
}

extension XCTestCase {
    func trackForMemoryLeak(instance: AnyObject,
                            file: StaticString = #filePath,
                            line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "potential memory leak on \(String(describing: instance))",
                file: file,
                line: line
            )
        }
    }
}
