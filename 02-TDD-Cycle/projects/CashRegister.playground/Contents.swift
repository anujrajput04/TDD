import Foundation
import XCTest

class CashRegister {
    var availableFunds: Decimal
    var transactionTotal: Decimal = 0
        
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ cost: Decimal) {
        transactionTotal += cost
    }
    
    func acceptCashPayment(_ cashAmount: Decimal) {
        transactionTotal -= cashAmount
        availableFunds += cashAmount
    }
}

class CashRegisterTests: XCTestCase {
    var availableFunds: Decimal!
    var sut: CashRegister!
    var itemCost: Decimal!
    var payment: Decimal!
    
    // 1
    // First call super.setUp() to give the superclass to do its setup and then set whatever needs to be set
    override func setUp() {
        super.setUp()
        availableFunds = 100
        itemCost = 42
        payment = 40
        sut = CashRegister(availableFunds: availableFunds)
    }
    
    // 2
    // Within tearDown(), you do the opposite. You first set availableFunds and sut to nil, and you lastly call super.tearDown().
    override func tearDown() {
        availableFunds = nil
        itemCost = nil
        sut = nil
        payment = nil
        super.tearDown()
    }
    
    // 1
    // Tests are named per this convention
    // - `XCTest`: Tests methods begin with `test` to be run
    // - `test`: Followed by the name of the method being tested
    // - if special setup is required, this comes next. Followed by underscore to separate it from last part
    // - Followed by the expecetd outcome or result
    func testInit_createCashRegister() {
        // 2
        // Instantiate a new instance of `CashRegister` which is passed into `XCTestAssetNil`
        //XCTAssertNotNil(CashRegister())
    }
    
    func testInitAvailableFunds_setsAvailableFunds() {
        // given
        //let availableFunds = Decimal(100)
        
        // when
        //let sut = CashRegister(availableFunds: availableFunds)
        
        // then
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addsCostToTransationTotal() {
        // when
        sut.addItem(itemCost)
        
        // then
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
    
    func testAddItem_twoItems_addsCostsToTransationTotal() {
        // given
        let itemCost2 = Decimal(20)
        let expectedTotal = itemCost + itemCost2
        
        // when
        sut.addItem(itemCost)
        sut.addItem(itemCost2)
        
        // then
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptCashPayment_subtractsPaymentFromTransationTotal() {
        // given
        givenTransactionInProgress()
        let expected = sut.transactionTotal - payment
        
        // when
        sut.acceptCashPayment(payment)
        
        // then
        XCTAssertEqual(sut.transactionTotal, expected)
    }
    
    func testAcceptCashPayment_addsPaymentToAvailableFunds() {
        // given
        givenTransactionInProgress()
        let expected = sut.availableFunds + payment
        
        // when
        sut.acceptCashPayment(payment)
        
        // then
        XCTAssertEqual(sut.transactionTotal, expected)
    }
    
    func givenTransactionInProgress() {
        sut.addItem(50)
        sut.addItem(100)
    }
}

CashRegisterTests.defaultTestSuite.run()
