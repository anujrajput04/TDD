#  Test Expressions

## Assert methods
- Equality: `XCTAssertEqual`, `XCTAssertNotEqual`
- Truthiness: `XCTAssertTrue`, `XCTAssertFalse`
- Nullability: `XCTAssertNil`, `XCTAssertNotNil`
- Comparison: `XCTAssertLessThan`, `XCTAssertGreaterThan`, `XCTAssertLessThanOrEqual`, `XCTAssertGreaterThanOrEqual`
- Erroring: `XCTAssertThrowsError`, `XCTAssertNoThrow`

Any test case can be boiled down to a conditional: so any test assert can be re-composed into a `XCTAssertTrue`.

## View controller testing
### Functional view controller testing
The important thing when testing view controllers is to not test the views and controls directly This is better done using UI automation tests. Here, the goal is to check the logic and state of the view controller.
Functional testing is done by using separate methods for interacting with the UI (callbacks, delegate methods, etc) from logic methods (updating state)
