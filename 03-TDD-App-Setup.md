# TDD App Setup

## About the FitNess app

## Your first test
The TDD philosophy treats tests as first class code, meaning they should fit the same standards as your production code in terms of redability, naming, error handling and coding conventions.

### Figuring out what to test
The TDD process requires writing a test first. This means you have to determine the smallest unit of functionality. This unit is where to start - the smallest thing that does something.

## Red-Green-Refactor
The name of the game in TDD is __red, green, refactor__. This means iteratively writing tests in this fashion:
1. Write a test that fails (red).
2. Write the minimum amount of code so the test passes (green).
3. Clean up test(s) and code as needed (refactor).
4. Repeat rhe process until all the logic cases are covered.

### Writing a red test
### Making the test green
Although, application targets aren't frameworks, they are modules, and test targets have the ability to import them as if it were a framework. Like frameworks, they have to be imported in each Swift file, so the compiler is aware of what the app contains.

### Writing a more interesting test
TDD is about discipline, and it's good practice to strictly follow the process while learning. With more experience, it's OK to skip the literal build and test step after getting the test to compile. Writing the minimum amount of code so the test passes cannot be skipped, though. Its essential to the TDD process and is what ensures adequate coverage.

## Test nomenclature
1. `func testAppModel_whenStarted_isInInProgressState() {`
The test function name should describe the test. The test name shows up in the test navigator and in test logs. With a large test suite that runs in a continuous integration rig, you'll be able to just look at the test failures and know what the problem is. Avoid creating tests named `test1`, `test2`, etc.

The name scheme used here has up to four parts:
- All tests must being with `test`.
- `AppModel` This says an `AppModel` is the system under test (sut).
- `whenStarted` is the condition or state change that is the catalyst for the test.
- `isInInProgressState` is the assertion about what the sut's state should be after the `when` happens.

This naming convention also helps keep the test code focused to a specific condition. Any code that doesn't flow naturally from the test name belongs in another test.

2. `let sut = AppModel()`
This makes the __system under test__ explicit by naming it `sut`. This test is in the `AppModelTests` test case subclass and this is a test on `AppModel`. It may be slightly redundant, but it's nice and explicit.

3. `sut.start()`
This is the behavior to test. In this case, the test is covering what happens when `start()` is called.

4. `let observedState = sut.appState`
Define a property that holds the valueyou observed while executing the application code.

5. `XCTAssertEqual(observedState, AppState.inProgress)`
The last part is the assertion about what happened to `sut` when it was started. The stated logical assertions correspond directly in `XCTest` to `XCTAssert` functions.

The division of a test method is referred to as __given/when/then__:
- The first part for a test is the things that are __given__. That is the initial state of system.
- The second part is the __when__, which is the action, event, or state change that acts on the system.
- The third part, or __then__, is testing the expected state after the when.

## Structure of XCTestCase subclass
XCTest is in the family of test frameworks derived from XUnit. Like so many good object-oriented things, XUnit comes from Smalltalk (where it was SUnit). It's an architecture fro running unit tests. The "X" is a stand--in for the programming language. For example, in Java it's JUnit, and in Objective-C it's OCUnit. In Swift, it's just XCTest.

With XUnit, tests are methods whose name starts with `test` that are part of a __test case class__. Test cases are grouped together is a test suite. Test runner is a program that knows how to find test cases in the suite, run them, and gather and display results. It's Xcode's test runner that is executed twhen you run the test phase of a scheme.

Each test case class has a `setUp()` and a `tearDown()` method that is used to set up global and class state before and after each test method is run.

- `XCTestCase` subclass lifecycles aremanaged outside the test execution, an any class-level state is persisted between test methods.
- The order in which test classes and test methods are run is not explicitly defined and cannot be relied upon.

Therefore, it's important to use `setUp()` and `tearDown()` to clean up and make sure state is in a known position before each test.

### Tearing down a test
A related gotcha with XCTestCases is it won't be deinitialized until all the tests are complete. That means its important to clean up a test's state after it's run to control memory usage, clean up the filesystem, or otherwise put things back the way it was found.

## Your next set of tests
### Test target organization
As you continue to add test cases when building the app, it will become hard to find and maintain unorganized tests. Unit tests are first class code and should have the same level of scrutiny as production app code which means keeping them organized.

We use the following organization:
```
Test Target
    ⌊ Cases
        ⌊ Group 1
            ⌊ Tests 1
            ⌊ Tests 2
        ⌊ Group 2
            ⌊ Tests
    ⌊ Mocks
    ⌊ Helper Classes
    ⌊ Helper Extensions
```

- __Cases__: The group for the test cases, and these are organized in a parallel structure to the app code. This makes it really easy to navigate between the app class and its tests.
- __Mocks__: For code that stands in for functional ocde, allowing for separating functionality from implementation. For example, network requests are commonly mocked.
- __Helper classes and extensions__: For additional code that you'll write to make the test code easier to write, but don't directly test or mock functionality. 

## Using @testable import
Xcode provides a way to expose data types for testing without making them available for general use. That’s through the `@testable` attribute.
```swift
@testable import FitNess
```
This makes symbols that are `open`, `public`, and `internal` available to the test case.

### Testing UI updates
TDD best practice is to have one assert per test. With well-named test methods, when the test fails, you'll know exactly where the issue is, because there is no ambiguity between multiple conditions.
Another good practice is instead of hard-coding the string usage of the variables is preferred. By using the app's value, the assert is testing behavior and not a specific value. If the string changes or gets localized, the test won't have to change to accomodate that.

## Testing initial conditions
The call to `viewDidLoad()` is needed because the `sut` is not actually loaded from the `xib` and put into a view hierarchy, so the view lifecycle methods do not get called.

## Key points
- TDD is about writing tests before writing app logic.
- Use logical statements to drive what should be tested.
- Each test should fail upon its first execution. Not compiling counts as a failure.
- Use tests to guide refactoring code for readability and performance.
- Good naming conventions make it easier to navigate and find issues.
