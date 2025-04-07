//
//  ImageCache.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import Foundation


import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let fileManager = FileManager.default
    private let cacheDir: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]

    // Load image from cache
    func image(for url: URL) -> UIImage? {
        let fileName = "\(url.absoluteString.hashValue)"
        let filePath = cacheDir.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: filePath) else { return nil }
        return UIImage(data: data)
    }
    
    // Save image to cache
    func save(data: Data, for url: URL) {
        let fileName = "\(url.absoluteString.hashValue)"
        let filePath = cacheDir.appendingPathComponent(fileName)
        try? data.write(to: filePath)
    }

    // Function to call from views
    func loadImage(from url: URL) async throws -> UIImage {
        if let cached = image(for: url) {
            return cached
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        save(data: data, for: url)
        return image
    }
    
    // For test access only
    var cacheDirectory: URL {
        return cacheDir
    }
}
