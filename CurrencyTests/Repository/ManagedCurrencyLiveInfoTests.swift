//
//  ManagedCurrencyInfoTests.swift
//  CurrencyTests
//
//  Created by kuanwei on 2022/5/26.
//

import Foundation
import XCTest
@testable import Currency

class ManagedCurrencyLiveInfoTests: XCTestCase {
    var persistence: MockCurrencyPersistence!
    
    override func setUp() {
        super.setUp()
        persistence = MockCurrencyPersistence.shared

        do {
            try insertSampleManagedCurrencyLiveInfo()
        }
        catch {
            XCTFail()
        }
    }

    override func tearDown() {
        do {
            let fetchRequest = ManagedCurrencyLiveInfo.fetchRequest()
            let currencyInfos = try persistence.viewContext.fetch(fetchRequest)

            for currencyInfo in currencyInfos {
                persistence.viewContext.delete(currencyInfo)
            }
            try persistence.viewContext.save()
        }
        catch {
            XCTFail()
        }
        super.tearDown()
    }

    func testCount() {
        do {
            let count = try ManagedCurrencyLiveInfo.count(in: persistence.viewContext)
            XCTAssertEqual(1, count)
        }
        catch {
            XCTFail()
        }
    }

    func testFetch() {
        do {
            let result = try ManagedCurrencyLiveInfo.fetch(in: persistence.viewContext)
            XCTAssertEqual(1, result.count)
        }
        catch {
            XCTFail()
        }
    }

    func testDelete() {
        do {
            let changes = try ManagedCurrencyLiveInfo.delete(source: "USD", in: persistence.viewContext)
            XCTAssertNotNil(changes)
        }
        catch {
            XCTFail()
        }
    }

    func testClear() {
        do {
            let changes = try ManagedCurrencyLiveInfo.clear(in: persistence.viewContext)
            XCTAssertNotNil(changes)
        }
        catch {
            XCTFail()
        }
    }
}

extension ManagedCurrencyLiveInfoTests {
    private func insertSampleManagedCurrencyLiveInfo() throws {
        do {
            let managedCurrencyInfo = ManagedCurrencyLiveInfo(context: persistence.viewContext)
            managedCurrencyInfo.source = ManagedCurrencyLiveInfoSample.USDLiveInfo.source
            managedCurrencyInfo.time = ManagedCurrencyLiveInfoSample.USDLiveInfo.time
            managedCurrencyInfo.quotes = ManagedCurrencyLiveInfoSample.USDLiveInfo.quotes
            try persistence.viewContext.save()
        } catch {
            XCTFail()
        }
    }
}
