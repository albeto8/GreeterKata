@testable import GreeterKata
import XCTest

struct Greeter {
    init(name: String) {
        
    }
    
    func greet(time: Date) -> String {
        let components = Calendar.current.dateComponents([.hour], from: time)
        if components.hour == 12 {
            return "Good Afternoon"
        }
        return "Good Morning"
    }
}

final class GreeterTests: XCTestCase {

    func test_greet_with1159am_shouldSayGoodMorning() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 11, minute: 59))
        
        XCTAssertEqual(result, "Good Morning")
    }
    
    func test_greet_with1200pm_shouldSayGoodAfternoon() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 12, minute: 00))
        
        XCTAssertEqual(result, "Good Afternoon")
    }
    
    // MARK:- Helpers
    
    private func date(hour: Int, minute: Int) -> Date {
        let components = DateComponents(calendar: .current, hour: hour, minute: minute)
        return components.date!
    }
}
