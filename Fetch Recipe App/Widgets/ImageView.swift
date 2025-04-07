//
//  ImageView.swift
//  Fetch Recipe App
//
//  Created by Winfred Wang on 4/6/25.
//

import SwiftUI

struct ImageView: View {
    @State private var image: UIImage? = nil
    let url: URL

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        // Load image only when they appear
        .onAppear {
            Task {
                await loadImage()
            }
        }
    }

    private func loadImage() async {
        do {
            let img = try await ImageCache.shared.loadImage(from: url)
            image = img
        } catch {
            print("Failed to load image:", error)
        }
    }
}


