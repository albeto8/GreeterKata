@testable import GreeterKata
import XCTest

struct Greeter {
    private let greetingTimes: [(from: Int, greeting: String)] = [
        (0, "Good Evening"),
        (5, "Good Morning"),
        (12, "Good Afternoon"),
        (17, "Good Evening"),
        (24, "SENTINEL")
    ]
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func greet(time: Date) -> String {
        let hello = greeting(for: time)
        
        if name.isEmpty {
            return hello
        }
        return "\(hello), \(name)"
    }
    
    private func greeting(for time: Date) -> String {
        let theHour = hour(for: time)
        for (index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour && theHour < greetingTimes[index + 1].from {
                return greetingTime.greeting
            }
        }
        return ""
    }
    
    private func hour(for time: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: time)
        return components.hour ?? 0
    }
}

final class GreeterWithNameTests: XCTestCase {
    func test_greetMorning_withAlberto_shouldSayGoodMorningAlberto() {
        let sut = Greeter(name: "Alberto")
        
        let result = sut.greet(time: date(hour: 11, minute: 59))
        
        XCTAssertEqual(result, "Good Morning, Alberto")
    }
    
    func test_greetAfternoon_withBeryl_shouldSayGoodMorningBeryl() {
        let sut = Greeter(name: "Beryl")
        
        let result = sut.greet(time: date(hour: 15, minute: 00))
        
        XCTAssertEqual(result, "Good Afternoon, Beryl")
    }
}

final class GreeterWithoutNameTests: XCTestCase {

    func test_greet_with1159am_shouldSayGoodMorning() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 11, minute: 59))
        
        XCTAssertEqual(result, "Good Morning")
    }
    
    func test_greet_with500am_shouldSayGoodMorning() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 5, minute: 00))
        
        XCTAssertEqual(result, "Good Morning")
    }
    
    func test_greet_with800am_shouldSayGoodMorning() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 8, minute: 00))
        
        XCTAssertEqual(result, "Good Morning")
    }
    
    func test_greet_with1200pm_shouldSayGoodAfternoon() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 12, minute: 00))
        
        XCTAssertEqual(result, "Good Afternoon")
    }
    
    func test_greet_with459pm_shouldSayGoodAfternoon() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 16, minute: 59))
        
        XCTAssertEqual(result, "Good Afternoon")
    }
    
    func test_greet_with200pm_shouldSayGoodAfternoon() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 14, minute: 00))
        
        XCTAssertEqual(result, "Good Afternoon")
    }
    
    func test_greet_with500pm_shouldSayGoodEvening() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 17, minute: 00))
        
        XCTAssertEqual(result, "Good Evening")
    }
    
    func test_greet_with2359pm_shouldSayGoodEvening() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 23, minute: 59))
        
        XCTAssertEqual(result, "Good Evening")
    }
    
    func test_greet_with2000pm_shouldSayGoodEvening() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 20, minute: 00))
        
        XCTAssertEqual(result, "Good Evening")
    }
    
    func test_greet_with1200am_shouldSayGoodEvening() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 0, minute: 00))
        
        XCTAssertEqual(result, "Good Evening")
    }
    
    func test_greet_with459am_shouldSayGoodEvening() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 4, minute: 59))
        
        XCTAssertEqual(result, "Good Evening")
    }
    
    func test_greet_with2000am_shouldSayGoodEvening() {
        let sut = Greeter(name: "")
        
        let result = sut.greet(time: date(hour: 2, minute: 00))
        
        XCTAssertEqual(result, "Good Evening")
    }
}

// MARK:- Helpers

func date(hour: Int, minute: Int) -> Date {
    let components = DateComponents(calendar: .current, hour: hour, minute: minute)
    return components.date!
}
