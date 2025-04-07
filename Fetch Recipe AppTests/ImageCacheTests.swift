//
//  ImageCacheTests.swift
//  Fetch Recipe AppTests
//
//  Created by Winfred Wang on 4/6/25.
//

import XCTest
@testable import Fetch_Recipe_App
import UIKit

final class ImageCacheTests: XCTestCase {

    private let testURL = URL(string: "https://example.com/image.png")!
    private let cache = ImageCache.shared

    override func setUpWithError() throws {
        // Clear existing cache file if it exists
        let fileName = "\(testURL.absoluteString.hashValue)"
        let filePath = cache.cacheDirectory.appendingPathComponent(fileName)
        try? FileManager.default.removeItem(at: filePath)
    }

    
    func testCacheSaveAndLoadImage() async throws {
        let cache = ImageCache.shared
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7f6a259a-71df-42c2-b314-065e0c736c67/large.jpg")!
        let fileName = "\(url.absoluteString.hashValue)"
        let filePath = cache.cacheDirectory.appendingPathComponent(fileName)

        // Ensure a clean start
        try? FileManager.default.removeItem(at: filePath)
        XCTAssertFalse(FileManager.default.fileExists(atPath: filePath.path), "Image should not be cached yet")

        // First load: fetches from the web and caches
        let firstLoad = try await cache.loadImage(from: url)
        XCTAssertNotNil(firstLoad, "First load should return an image")
        XCTAssertTrue(FileManager.default.fileExists(atPath: filePath.path), "Image should now be cached on disk")

        // Second load: should return the same image from cache
        let secondLoad = cache.image(for: url)
        XCTAssertNotNil(secondLoad, "Second load should return cached image")
        XCTAssertEqual(firstLoad.size, secondLoad?.size)
    }


    func testCacheMissReturnsNil() {
        let fakeURL = URL(string: "https://example.com/does-not-exist.jpg")!
        let result = cache.image(for: fakeURL)
        XCTAssertNil(result, "Expected nil for missing cached image")
    }
}
