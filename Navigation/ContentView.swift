//
//  ContentView.swift
//  Navigation
//
//  Created by Santhosh Srinivas on 18/08/25.
//

import SwiftUI

struct Student: Hashable, Identifiable{
    
    var id = UUID()
    var name: String
    var age: Int
}

struct DetailedView: View{
    
    var num : Int
    var body: some View{
        Text("Number \(num)")
    }
    
    init(num: Int) {
        self.num = num
        print("Created View for \(num)")
    }
}
struct ContentView: View {
    
    @State private var path = [Int]()
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
            // when we do this, it initializes the value many times. which isnt desireable when we have a complex layout
            NavigationLink("Tap Me"){
                DetailedView(num: 55)
            }
            
            List(0..<100){ i in
                NavigationLink("Select \(i)", value: i)
            }
            // this is easy for simple data.
            // for complex data we need to hash it(converts large data into a very small data)
            .navigationDestination(for: Int.self) { selection in
                    Text("You selected \(selection)")
                }
            .navigationDestination(for: Student.self){ student in
                Text("You are \(student.name) \(student.hashValue)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
