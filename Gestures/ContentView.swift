import SwiftUI

struct ContentView: View {

    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var isExpanding = false
    
    @GestureState private var scaleAmount: CGFloat = 1

    var body: some View {
        Circle()
            .fill(.red)
            .frame(width: 80, height: 80)
            .offset(offset)
            .scaleEffect(isDragging ? 2 : 1)
            .gesture(DragGesture()
                .onChanged {
                    value in offset = value.translation
                    //isDragging = true
                }
                .onEnded {
                    _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
            )
            .padding()
        Circle()
            .fill(.green)
            .frame(width: 80, height: 80)
            .offset(.zero)
            .scaleEffect(isExpanding ? 2 : 1)
            .gesture(LongPressGesture()
                .onChanged({
                    value in
                    withAnimation {
                      isExpanding = true
                    }
                })
                .onEnded({
                    value in
                    withAnimation {
                        isExpanding = false
                    }
                })
            )
            .padding()
        Circle()
            .fill(.blue)
            .frame(width: 80, height: 80)
            .offset(.zero)
            .scaleEffect(scaleAmount)
            .gesture(
                MagnificationGesture()
                    .updating($scaleAmount, body: {(value, state, transition) in
                    state = value
                    }
                )
            )
            .animation(.easeInOut, value: 1.0)
            .padding()
    }
}

#Preview {
    ContentView()
}
