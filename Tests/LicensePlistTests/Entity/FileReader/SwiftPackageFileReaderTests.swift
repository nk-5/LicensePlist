//
//  SwiftPackageFileReaderTests.swift
//  LicensePlistTests
//
//  Created by yosshi4486 on 2021/04/06.
//

import XCTest
@testable import LicensePlistCore

class SwiftPackageFileReaderTests: XCTestCase {

    var fileURL: URL!

    var packageResolvedText: String {
        return #"""
        {
          "object": {
            "pins": [
              {
                "package": "APIKit",
                "repositoryURL": "https://github.com/ishkawa/APIKit.git",
                "state": {
                  "branch": null,
                  "revision": "4e7f42d93afb787b0bc502171f9b5c12cf49d0ca",
                  "version": "5.3.0"
                }
              },
              {
                "package": "HeliumLogger",
                "repositoryURL": "https://github.com/Kitura/HeliumLogger.git",
                "state": {
                  "branch": null,
                  "revision": "fc2a71597ae974da5282d751bcc11965964bccce",
                  "version": "2.0.0"
                }
              },
              {
                "package": "LoggerAPI",
                "repositoryURL": "https://github.com/Kitura/LoggerAPI.git",
                "state": {
                  "branch": null,
                  "revision": "4e6b45e850ffa275e8e26a24c6454fd709d5b6ac",
                  "version": "2.0.0"
                }
              },
              {
                "package": "swift-argument-parser",
                "repositoryURL": "https://github.com/apple/swift-argument-parser.git",
                "state": {
                  "branch": null,
                  "revision": "82905286cc3f0fa8adc4674bf49437cab65a8373",
                  "version": "1.1.1"
                }
              },
              {
                "package": "HTMLEntities",
                "repositoryURL": "https://github.com/Kitura/swift-html-entities.git",
                "state": {
                  "branch": null,
                  "revision": "d8ca73197f59ce260c71bd6d7f6eb8bbdccf508b",
                  "version": "4.0.1"
                }
              },
              {
                "package": "swift-log",
                "repositoryURL": "https://github.com/apple/swift-log.git",
                "state": {
                  "branch": null,
                  "revision": "5d66f7ba25daf4f94100e7022febf3c75e37a6c7",
                  "version": "1.4.2"
                }
              },
              {
                "package": "Yaml",
                "repositoryURL": "https://github.com/behrang/YamlSwift.git",
                "state": {
                  "branch": null,
                  "revision": "287f5cab7da0d92eb947b5fd8151b203ae04a9a3",
                  "version": "3.4.4"
                }
              }
            ]
          },
          "version": 1
        }
        """#
    }

    override func setUpWithError() throws {
        fileURL = URL(fileURLWithPath: "\(TestUtil.testProjectsPath)/SwiftPackageManagerTestProject/SwiftPackageManagerTestProject.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved")
    }

    override func tearDownWithError() throws {
        fileURL = nil
    }

    func testInvalidPath() throws {
        let invalidFilePath = fileURL.deletingLastPathComponent().appendingPathComponent("Podfile.lock")
        let reader = SwiftPackageFileReader(path: invalidFilePath)
        XCTAssertThrowsError(try reader.read())
    }

    func testPackageSwift() throws {
        // Path for this package's Package.swift.
        let packageSwiftPath = TestUtil.sourceDir.appendingPathComponent("Package.swift").lp.fileURL
        let reader = SwiftPackageFileReader(path: packageSwiftPath)
        XCTAssertEqual(
            try reader.read()?.trimmingCharacters(in: .whitespacesAndNewlines),
            packageResolvedText.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    func testPackageResolved() throws {
        // Path for this package's Package.resolved.
        let packageResolvedPath = TestUtil.sourceDir.appendingPathComponent("Package.resolved").lp.fileURL
        let reader = SwiftPackageFileReader(path: packageResolvedPath)
        XCTAssertEqual(
            try reader.read()?.trimmingCharacters(in: .whitespacesAndNewlines),
            packageResolvedText.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

}
