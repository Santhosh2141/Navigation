//
//  NavigationStyles.swift
//  Navigation
//
//  Created by Santhosh Srinivas on 20/08/25.
//

import SwiftUI

struct NavigationStyles: View {
    @State private var title = "Navigation Styles"
    var body: some View {
        NavigationStack{
//            List(0..<100){ i in
//                Text("Row \(i)")
//            }
            Text("Hello, world!")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Tap Me") {
                        // button action here
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            // the bars affect all bars. so we use for
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarColorScheme(.dark)
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct NavigationStyles_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStyles()
    }
}
