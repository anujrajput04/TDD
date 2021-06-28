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

## Test ordering matters
### Code coverage
Code coverage is the measure of how many lines of app code are executed during tests. There will be a list of each file in the target along with the percentage of code lines that were executed. Having 100% or close for a file means you're following TDD closely. When the tests are written first, only the code needed to pass the test gets added. 

The coverage annotation on the right side of the editor represents the number of times that line was executed. Lines witha red coloring or "0" indicate opportunities to add additional tests.

Lines with a striped red annotation mean that only part of that line was run. Hovering over the stripe in the annotation bar will show you in green which part was run and in red what was not.

The goal should be to get as close to 100% as possible. Coverage doesn't mean the code works, but lack of coverage means that it's not tested. For views and view controllers, its not expected to get to 100% coverage because TDD does not include UI testing. When you combine unit tests with UI automation tests, then you should expect to be able to cover most if not all of the files.
