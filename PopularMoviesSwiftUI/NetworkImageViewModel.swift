import Foundation
import SwiftUI

@MainActor class NetworkViewModel: ObservableObject {
    @Published var imageData: Data?

    func fetchPoster(from urlString: String) {
        Task {
            imageData = try await Repository.shared.fetchPoster(from: urlString)
        }
    }
}
