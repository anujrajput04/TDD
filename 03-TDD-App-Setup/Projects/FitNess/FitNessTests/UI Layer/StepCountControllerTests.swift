//
//  StepCountControllerTests.swift
//  FitNessTests
//
//  Created by Anuj Rajput on 27/04/21.
//  Copyright © 2021 Anuj Rajput. All rights reserved.
//

@testable import FitNess
import XCTest

class StepCountControllerTests: XCTestCase {

    var sut: StepCountController!
    
    override func setUpWithError() throws {
        do {
            try super.setUpWithError()
            sut = StepCountController()
        } catch (let error) {
            print(error)
        }
    }

    override func tearDownWithError() throws {
        do {
            sut = nil
            try super.tearDownWithError()
        } catch(let error) {
            print(error)
        }
    }
    
    // MARK: - Initial State
    
    func testController_whenCreated_buttonLabelIsStart() {
        // given
        sut.viewDidLoad()
        
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
    }
    
    // MARK: - In Progress
    
    func testController_whenStartTapped_appIsInProgress() {
        // when
        sut.startStopPause(nil)
        
        // then
        let state = AppModel.instance.appState
        XCTAssertEqual(state, AppState.inProgress)
    }

    func testController_whenStartTapped_buttonLabelIsPause() {
        // when
        sut.startStopPause(nil)
        
        // then
        let text = sut.startButton.title(for: .normal)
        XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
    }
}
