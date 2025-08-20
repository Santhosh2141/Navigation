//
//  ContentView.swift
//  Navigation
//
//  Created by Santhosh Srinivas on 18/08/25.
//

import SwiftUI

class PathStore: ObservableObject{
//    var path: NavigationPath
    var path: [Int]{
        didSet{
            save()
        }
    }
    
    // this saves the path we are going in savePath variable
    private let savePath = URL.documentsDirectory.appending(path: "SavePath")
    
    init() {
        // when we relaunch the app, this takes places
        // if savePath has any data, then we decode it
        if let data = try? Data(contentsOf: savePath){
            
//            when we decode our JSON we need to decode to a specific type, then use the decoded data to create a new NavPath
//            if let decodedData = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data)
            if let decodedData = try? JSONDecoder().decode([Int].self, from: data){
                
//                path = NavigationPath(decodedData)
                
                // the decoded path is assigned to path which is used when relaunced
                path = decodedData
                return
            }
        }
        
        // when we initially launch, it is am empty array
        path = []
//        path = NavigationPath()
    }
    
    func save() {
        
        // when we use path, it should be codable to JSON. but NavPath doesnt always have to be codable.
        // so we check if the path can be coded and then pass this codable value to the encoder.
        
//        guard let representation = path.codable else { return }
        do {
//            let data = try JSONEncoder().encode(representation)
            
            // the path when we close is encoded and written to savePath var
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

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

struct DetailView: View{
//    The @Binding property wrapper lets us pass an @State property into another view and modify it from there – we can share an @State property in several places, and changing it in one place will change it everywhere.
    var number: Int
//    @Binding var path: [Int]
//    @Binding var path1: NavigationPath
    var body: some View{
        NavigationLink("Go to a random Number", value: Int.random(in: 0...1000))
            .navigationTitle("Number: \(number)")
            .toolbar{
                Button("Home"){
//                    path.removeAll() // this if we use it as an array
//                    path1 = NavigationPath() // this if we use navigation Path
                }
            }
    }
}
struct ContentView: View {
    
//    @State private var path = [Int]()
    @State private var pathStore = PathStore()
    @State private var path1 = NavigationPath()
    // navigationPath can hold any type of hashable data without exposing what data that is
    var body: some View {
        NavigationStack(path: $pathStore.path){
//            $path meaning that changing the array will automatically navigate to whatever is in the array, but also changes the array as the user presses Back in the navigation bar.
            VStack{
//                DetailView(number: 0, path: $path, path1: $path1)
                DetailView(number: 0)
                    .navigationDestination(for: Int.self){ i in
//                        DetailView(number: i, path: $path, path1: $path1)
                        DetailView(number: i)
                    }
//                Button("Show 32") {
//                    // pressing this button makes the whole array as 32
//                    path = [32]
//                }
//
//                Button("Show 64") {
//                    // pressing this button adds 64 to the array
//                    path.append(64)
//                }
//
//                Button("Show 32 then 64") {
//                    // this shows 32 and then 64. User needs to press back 2 times
//                    path = [32, 64]
//                }
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
            
            NavigationLink{
                NavigationStyles()
            } label: {
                Text("Go To Nav Styles")
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
