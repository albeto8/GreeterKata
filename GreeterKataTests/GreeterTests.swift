@testable import GreeterKata
import XCTest

struct Greeter {
    init(name: String) {
        
    }
    
    func greet(time: Date) -> String {
        return ""
    }
}

final class GreeterTests: XCTestCase {

    func test_greet_with1159am_shouldSayGoodMorning() {
        let sut = Greeter(name: "")
        let components = DateComponents(calendar: .current, hour: 11, minute: 59)
        let time = components.date!
        
        let result: String = sut.greet(time: time)
        
        XCTAssertEqual(result, "Good Morning")
    }
}
