import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    var trackColor: Color

    var body: some View {
        HStack{
            Text("0")
            Slider(value: $value)
                .accentColor(trackColor)
            Text("255")
        }
        .padding(.horizontal)
    }
}

