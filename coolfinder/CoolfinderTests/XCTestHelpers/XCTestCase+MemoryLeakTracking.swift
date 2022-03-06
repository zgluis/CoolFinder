//
//  XCTestCase+MemoryLeakTracking.swift
//  CoolfinderTests
//
//  Created by Luis Zapata on 05-03-22.
//

import XCTest

extension XCTestCase {
    public func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
