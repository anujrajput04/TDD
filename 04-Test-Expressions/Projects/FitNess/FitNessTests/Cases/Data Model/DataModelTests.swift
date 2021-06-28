//
//  DataModelTests.swift
//  FitNessTests
//
//  Created by Anuj Rajput on 24/06/21.
//  Copyright © 2021 Anuj Rajput. All rights reserved.
//

import XCTest
@testable import FitNess

class DataModelTests: XCTestCase {

    var sut: DataModel!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        sut = DataModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try? super.tearDownWithError()
    }
    
    func testModel_whenStepsReachGoal_goalIsReached() {
        // given
        sut.goal = 1000
        
        // when
        sut.steps = 1000
        
        // then
        XCTAssertTrue(sut.goalReached)
    }
    
    // MARK: - Goal
    func testModel_whenStarted_goalIsNotReached() {
        XCTAssertFalse(sut.goalReached, "goalReached should be false when the model is created")
    }
}
