import XCTest

public func XCTAssertEqualToAny<T: Equatable>(_ actual: @autoclosure () throws -> T,
                                              _ expected: @autoclosure () throws -> Any?,
                                              file: StaticString = #file,
                                              line: UInt = #line) throws {
  let actual = try actual()
  let expected = try XCTUnwrap(expected() as? T)
  XCTAssertEqual(actual, expected, file: file, line: line)
}

public func XCTAssertEqualToDate(_ actual: @autoclosure () throws -> Date,
                                 _ expected: @autoclosure () throws -> Any?,
                                 file: StaticString = #file,
                                 line: UInt = #line) throws {
  let actual = try actual()
  let value = try expected()
  let expected: Date
  if let value = value as? TimeInterval {
    expected = Date(timeIntervalSinceReferenceDate: value)
  } else {
    expected = try XCTUnwrap(value as? Date)
  }
  XCTAssertEqual(actual, expected, file: file, line: line)  
}

public func XCTAssertEqualToDecimal(_ actual: @autoclosure () throws -> Decimal,            
                                    _ expected: @autoclosure () throws -> Any?,
                                    file: StaticString = #file,
                                    line: UInt = #line) throws {

  let actual = try actual()
  let value = try XCTUnwrap(expected() as? Double)
  let expected = Decimal(value)
  
  XCTAssertEqual(actual, expected, file: file, line: line)
}

public func XCTAssertEqualToURL(_ actual: @autoclosure () throws -> URL,
                                _ expected: @autoclosure () throws -> Any?,
                                file: StaticString = #file,
                                line: UInt = #line) throws {

  let actual = try actual()
  let value = try XCTUnwrap(expected() as? String)
  let expected = try XCTUnwrap(URL(string: value))
  XCTAssertEqual(actual, expected, file: file, line: line)
}
