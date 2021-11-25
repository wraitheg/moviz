//
//  DiscoverVCSnapshotTests.swift
//  MovizTests
//
//  Created by Li Hao Lai on 1/1/21.
//

@testable import Moviz
import OHHTTPStubs
import OHHTTPStubsSwift
import SnapshotTesting
import XCTest

class DiscoverVCSnapshotTests: XCTestCase {
    var mainStub: HTTPStubsDescriptor?
    
    var imageStub: HTTPStubsDescriptor?
    
    override func setUp() {
        mainStub = stub(condition: isHost("api.themoviedb.org")) { _ -> HTTPStubsResponse in
            return HTTPStubsResponse(fileAtPath: OHPathForFile("discover.json", type(of: self))!,
                                     statusCode: 200,
                                     headers: ["Content-Type": "application/json"])
        }

        imageStub = stub(condition: isHost("image.tmdb.org")) { request -> HTTPStubsResponse in
            guard let path = request.url?.path,
                  let name = path.split(separator: "/").last?.replacingOccurrences(of: ".jpg", with: "") else {
                return HTTPStubsResponse(jsonObject: [:], statusCode: 404, headers: nil)
            }

            guard let image = UIImage(named: String(name), in: Bundle(for: Self.self), with: nil),
                  let imageData = image.pngData() else {
                return HTTPStubsResponse(jsonObject: [:], statusCode: 404, headers: nil)
            }

            return HTTPStubsResponse(data: imageData,
                                     statusCode: 200,
                                     headers: nil)
        }
        
        super.setUp()
        
        // 1. Set `isRecording` true for recording new snapshot, false for asserting with the recorded snapshot
        isRecording = false
    }
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testDiscoverVC() {
        // 2. Prepare the view you would like to do snapshot testing
        let vm = DiscoverViewModel()
        let vc = DiscoverViewController.instantiate(viewModel: vm)
        
        // 3. Assert the view on the devices you would like to test
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneSe)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneSe)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneSe)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneX)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneX)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneX)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneXsMax)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneXsMax)))
        assertSnapshot(matching: vc, as: .wait(for: 1, on: .image(on: .iPhoneXsMax)))
    }
}
