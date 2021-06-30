#  Test Expressions

`XCTestExpectation` is the tool for testing things that happen outside the direct flow.
- General test expectations
- Notification expectations

## Using an expectation
XCTest expectations have two parts: __expectation__ and a __waiter__. An expectation is an object thta you can leter `fulfull`. The `wait` method of `XCTestCase` tells the test execution to wait until the expectation is fulfilled or a specified amount of time passes.

The state transitions occure in response to asynchronous events outside the user's control.

### Writin an asynchronous test
