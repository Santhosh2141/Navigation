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
    @State private var path1 = NavigationPath()
    // navigationPath can hold any type of hashable data without exposing what data that is
    var body: some View {
        NavigationStack(path: $path1){
//            $path meaning that changing the array will automatically navigate to whatever is in the array, but also changes the array as the user presses Back in the navigation bar.
            VStack{
                Button("Show 32") {
                    // pressing this button makes the whole array as 32
                    path = [32]
                }

                Button("Show 64") {
                    // pressing this button adds 64 to the array
                    path.append(64)
                }
                
                Button("Show 32 then 64") {
                    // this shows 32 and then 64. User needs to press back 2 times
                    path = [32, 64]
                }
                List{
                    ForEach(0..<5){ i in
                        NavigationLink("Select Number \(i)", value: i)
                    }
                    ForEach(0..<5){ i in
                        NavigationLink("Select String \(i)", value: String(i))
                    }
                }
            }
            .toolbar{
                Button("Push 556"){
                    path1.append(556)
                }
                Button("Push Hello"){
                    path1.append("hello")
                }
            }
            .navigationDestination(for: Int.self){ selection in
                Text("You selected number \(selection)")
            }
            .navigationDestination(for: String.self){ selection in
                Text("You selected string \(selection)")
            }
        }
//        NavigationStack{
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//                Text("Hello, world!")
//            }
//            .padding()
//            // when we do this, it initializes the value many times. which isnt desireable when we have a complex layout
//            NavigationLink("Tap Me"){
//                DetailedView(num: 55)
//            }
//
//            List(0..<100){ i in
//                NavigationLink("Select \(i)", value: i)
//            }
//            // this is easy for simple data.
//            // for complex data we need to hash it(converts large data into a very small data)
//            .navigationDestination(for: Int.self) { selection in
//                    Text("You selected \(selection)")
//                }
//            .navigationDestination(for: Student.self){ student in
//                Text("You are \(student.name) \(student.hashValue)")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
