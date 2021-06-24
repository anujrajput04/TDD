#  Test Expressions

## Assert methods
- Equality: `XCTAssertEqual`, `XCTAssertNotEqual`
- Truthiness: `XCTAssertTrue`, `XCTAssertFalse`
- Nullability: `XCTAssertNil`, `XCTAssertNotNil`
- Comparison: `XCTAssertLessThan`, `XCTAssertGreaterThan`, `XCTAssertLessThanOrEqual`, `XCTAssertGreaterThanOrEqual`
- Erroring: `XCTAssertThrowsError`, `XCTAssertNoThrow`

Any test case can be boiled down to a conditional: so any test assert can be re-composed into a `XCTAssertTrue`.
