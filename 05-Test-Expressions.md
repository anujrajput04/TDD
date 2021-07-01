#  Test Expressions

`XCTestExpectation` is the tool for testing things that happen outside the direct flow.
- General test expectations
- Notification expectations

## Using an expectation
XCTest expectations have two parts: __expectation__ and a __waiter__. An expectation is an object thta you can leter `fulfull`. The `wait` method of `XCTestCase` tells the test execution to wait until the expectation is fulfilled or a specified amount of time passes.

The state transitions occure in response to asynchronous events outside the user's control.

### Writing an asynchronous test
In order to react to an asynchronous event, the code needs a way to listen for a change. This is commonly done through a closure, a delegate method, or by observing a notification.

1. `expectation(description:)` is an `XCTestCase` method that creates an `XCTestExpectation` object. The `description` helps identify a failure in the test logs.

2. `fulfill()` is called on the expectation to indicate it has been fulfilled - specifically, the callback has occured. Here `stateChangeCallback` will trigger on `sut` when a state change occurs.
3. `wait(for:timeout:)` causes the test runner to pause until all expectations are fulfilled or the `timeout` time (in seconds) passes. The assertion will not be called until the wait completes.

### Testing for true asynchronity
Stopping execution in the debugger doesn't pause the `wait` timeout. When the debugger pauses at a breakpoint and you explore for the logic error, be mindful that the test will probably fail due to timeout. Simply disable or remove the breakpoint and re-run once the issue is corrected.
