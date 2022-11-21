//
//  TeamTests.swift
//  SportTests
//
//  Created by MyMac on 2022-11-21.
//

import XCTest
import Football

final class TeamTests: XCTestCase {
    // MARK: - Propertes
    var sut: Team!
    var mock: Mock!
    // MARK: - Overheads
    override func setUpWithError() throws {
        mock = Mock()
        sut = makeMockTeam()
    }
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }
    // MARK: - Tests
    func test_id_init_propertyEqualsInput() {
        let id = sut.id
        XCTAssertEqual(id, mock.id)
        XCTAssertNotEqual(id, UUID())
        XCTAssert(!id.uuidString.isEmpty)
    }
    func test_name_init_propertyEqualsInput() {
        let name = sut.name
        XCTAssertEqual(name, mock.name)
        XCTAssertNotEqual(name, UUID().uuidString)
        XCTAssert(!name.isEmpty)
    }
    func test_logo_init_propertyEqualsInput() {
        let logo = sut.logo
        XCTAssertEqual(logo, mock.logo)
        XCTAssertNotEqual(logo, URL(string: "https://www.abc.com")!)
        XCTAssert(!logo.absoluteString.isEmpty)
    }
    // MARK: - Helpers
    struct Mock {
        let id = UUID()
        let name = UUID().uuidString
        let logo = URL(string: "https://www.google.com")!
    }
    private func makeMockTeam() -> Team {
        Team(
            id: mock.id,
            name: mock.name,
            logo: mock.logo
        )
    }
}
