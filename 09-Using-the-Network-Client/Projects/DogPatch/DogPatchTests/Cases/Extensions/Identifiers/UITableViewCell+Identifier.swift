@testable import DogPatch
import XCTest

class UITableViewCell_Identifier: XCTestCase {
  
  func test_identifer_returnsExpected() {
    // given
    let expected = "\(TestTableViewCell.self)"
    
    // when
    let actual = TestTableViewCell.identifier
    
    // then
    XCTAssertEqual(actual, expected)
  }
}
