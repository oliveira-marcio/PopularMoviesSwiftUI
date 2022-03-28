import SwiftUI

struct NetworkImage: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat

    @State var imageData: Data?

    init(urlString: String, width: CGFloat, height: CGFloat) {
        self.urlString = urlString
        self.width = width
        self.height = height
    }

    var body: some View {
        if let imageData = imageData,
            let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .background(Color.gray)
                .task {
                    await fetchPoster()
                }
        }
    }

    private func fetchPoster() async {
        imageData = try? await Repository.shared.fetchPoster(from: urlString)
    }
}
