//
//  MatchTests.swift
//  SportTests
//
//  Created by MyMac on 2022-11-21.
//

import XCTest
@testable import Sport

final class MatchTests: XCTestCase {
    // MARK: - Properties
    var sut: Match!
    var mock: Mock!
    // MARK: - Overheads
    override func setUpWithError() throws {
        mock = Mock()
        sut = makeMockMatch()
    }
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }
    // MARK: - Tests
    func test_date_init_propertyEqualsInput() {
        let date = sut.date
        XCTAssertEqual(date, mock.date)
        XCTAssertNotEqual(date, Date())
    }
    func test_description_init_propertyEqualsInput() {
        let description = sut.description
        XCTAssertEqual(description, mock.description)
        XCTAssertNotEqual(description, UUID().uuidString)
        XCTAssert(!description.isEmpty)
    }
    func test_home_init_propertyEqualsInput() {
        let home = sut.home
        XCTAssertEqual(home, mock.home)
        XCTAssertNotEqual(home, UUID().uuidString)
        XCTAssert(!home.isEmpty)
    }
    func test_away_init_propertyEqualsInput() {
        let away = sut.away
        XCTAssertEqual(away, mock.away)
        XCTAssertNotEqual(away, UUID().uuidString)
        XCTAssert(!away.isEmpty)
    }
    func test_winner_init_propertyEqualsInput() {
        let winner = sut.winner
        XCTAssertEqual(winner, mock.winner)
        XCTAssertNotEqual(winner, UUID().uuidString)
        XCTAssert(!winner.isEmpty)
    }
    func test_highlights_init_propertyEqualsInput() {
        let highlights = sut.highlights
        XCTAssertEqual(highlights, mock.highlights)
        XCTAssertNotEqual(highlights, URL(string: "https://www.abc.com/")!)
        XCTAssert(!highlights.absoluteString.isEmpty)
    }
    // MARK: - Helpers
    struct Mock {
        let date = Date()
        let description = UUID().uuidString
        let home = UUID().uuidString
        let away = UUID().uuidString
        let winner = UUID().uuidString
        let highlights = URL(string: "https://www.google.com")!
    }
    private func makeMockMatch() -> Match {
        Match(
            date: mock.date,
            description: mock.description,
            home: mock.home,
            away: mock.away,
            winner: mock.winner,
            highlights: mock.highlights
        )
    }
}
