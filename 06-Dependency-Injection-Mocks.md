#  Dependency Injection & Mocks

## What's up with fakes, mocks, and stubs?
When writing tests, it's important to isolate the system-under-test from other parts of the code so your tests have high confidence that they are testing the system as described. Tests focused on edge cases or error conditions can be very difficult to write, as they often involve specific state external to the system-under-test. It's also difficult to diagnose and debug tests that fail due to intermittent or inconsistent issues outside the system-under-test.

The way to isolate the system-under-test and circumvent these issues is to use __test doubles__: objects that stands in for real code. There are several variants of test doubles:
- __Stub__: Stubs stand in for the original object and provide canned responses/ These are often used to implement one method of a protocol and have empty or nil returning implementatitons for the others
- __Fake__: Fakes often have logic, but instad of providing real or production data, they provide test data. For example, a fake network manager might read/write from local JSON files instead of connecting over a network.
- __Mock__: Mocks are used to verify behavior, that is they should have an expectation that a certain method of the mock gets called or that its state was set to an expected value. Mocks are generally expected to provide test values or behaviors.
- __Partial mock__: While a regular mock is a complete substitution for a production object, a partial mock uses the production code and only overrides part of it to test the expectations. Partial mocks are ususally a subclass or provide a proxy to the production object.

## Handling error conditions
### Dealing with no pedometer
You’ll have to add functionality to detect that the pedometer is not available and to inform the user
### Dealing with no permissions
The other error state that needs to be handled is when the user declines the permission pop-up
### Mocking a callback
There is another important error situation to handle. This occurs the very first time the user taps __Start__ on a pedometer-capable device. In that case, the start flow goes ahead, but the user can decline in the permission pop-up. If the user declines, there is an error in the `eventUpdates` callback
