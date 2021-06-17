# TDD App Setup

## About the FitNess app

## Your first test
### Adding a test target
### Figuring out what to test
### Adding a test class

## Red-Green-Refactor
### Writing a red test
### Making the test green
### Writing a more interesting test

## Test nomenclature

## Structure of XCTestCase subclass
### Setting up a test
### Tearing down a test

## Your next set of tests
### Test target organization
As you continue to add test cases when building the app, it will become hard to find and maintain unorganized tests. Unit tests are first class code and should have the same level of scrutiny as production app code which means keeping them organized

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

- __Cases__: 
- __Mocks__: 
- __Helper classes and extensions__: 
