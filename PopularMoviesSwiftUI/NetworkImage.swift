import SwiftUI

struct NetworkImage: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat

    init(urlString: String, width: CGFloat, height: CGFloat) {
        self.urlString = urlString
        self.width = width
        self.height = height
    }

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .background(Color.gray)
        }.frame(width: width, height: height)
    }
}
