//
//  AppModelTests.swift
//  FitNessTests
//
//  Created by Anuj Rajput on 15/04/21.
//  Copyright © 2021 Anuj Rajput. All rights reserved.
//

import XCTest
import FitNess

class AppModelTests: XCTestCase {
    
    var sut: AppModel!
        
    override func setUpWithError() throws {
        do {
            try super.setUpWithError()
            sut = AppModel()
        } catch (let error) {
            print(error)
        }
    }
    
    override func tearDownWithError() throws {
        do {
            sut = nil
            try super.tearDownWithError()
        } catch (let error) {
            print(error)
        }
    }
    
    func testAppModel_whenInitialized_isInNotStartedState() {
        let initialState = sut.appState
        XCTAssertEqual(initialState, AppState.notStarted)
    }
    
    func testAppModel_whenStarted_isInInProgressState() {
        
        // 2 when started
        sut.start()
        
        // 3 then it is in inProgress
        let observedState = sut.appState
        XCTAssertEqual(observedState, AppState.inProgress)
    }
}
