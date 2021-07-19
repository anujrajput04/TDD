#  Test Expectations

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

## Waiting for notifications
### Building the alert center
`expectation(forNotification:object:handler)` creates an expectation that fulfills when a notification posts.
It's not generally a good idea to use a `wait` as the test assertion. It's better to use an explicit assert call. `wait` only tests that an expectation was fulfilled and does not make any claims about the app's logic.

### Waiting for multiple events
You can use expectation's `expectedFulfullmentCount` property to refine the fulfillment condition. Setting `expectedFulfillmentCount` to two means that the expectation won't be met until `fulfill()` has been called twice before the timeout..

### Expecting something not to happen
Good test suites not only test when things happen according to plan, but also check that certain side effects do not occur. One of the things the app should not do is spam the user with alerts.

```swift
exp.isInverted = true
```
When an expectation is inverted it indicates this test fails if the expectation is fulfilled and succeeds if the wait times out. This test will fail if two notifications aretriggered by the two alerts.

## Getting specific about notifications
While you should strive for a single assert per test, it's oK to have more than one if they both confirm the same truth.

## Driving alerts from the data model
### Testing for multiple expectations
Using `wait(for:timeout:)` with an array of just one expectation. Array is useful to provide multiple expextations and `wait` for al of them to be fulfilled.
`enforceOrder` parameter is an optional paramter which makes sure that not only all the expectations are fulfilled but they happen in order specified in the array.
The ordering check allows for sophisticated tests. eg, you could use this when writing a test for a multi-step process like image filtering or a network login that requires a multiple API call. These testst not only ensure all the steps happen in the necessary order in production code, but also validate that your test code isn't going through a different flow than expected. 

### Refining Requirements
The previous set of unit tests have one flaw when it comes to validating the app. They test a snapshot of the app's state and do not consider that the app is dynamic.
When in progress, the app will continually update the step count, and it's important to not spam the user at each step, but insteadonly alert them when a threshold is first crossed. In addition, the user has the option to clear the alert if an earlier alert was cleared by the user.
