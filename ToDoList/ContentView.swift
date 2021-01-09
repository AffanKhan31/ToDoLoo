//
//  ContentView.swift
//  ToDoList
//
//  Created by affan khan on 2020-12-29.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(fetchRequest: ToDoListItem.getAllToDoListItem())
    var items: FetchedResults<ToDoListItem>
    
    @State var text: String = ""
    
    
    var body: some View {
        NavigationView {
            
            List {
                Section(header: Text("New Item")){
                    HStack{
                        TextField("Enter new item...", text: $text)
                                                
                        Button(action: {
                            if !text.isEmpty {
                            let newItem = ToDoListItem(context: context)
                            newItem.name = text
                            newItem.createdAt = Date()
                            
                            do {
                                try context.save()
                            }
                            catch {
                                print(error)
                            }
                            
                            text = ""
                            }
                        }, label: {
                            Text("Save")
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Color.purple)
                            
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                
                                
                        })
                    }
                        
                }
                
                Section {
                    ForEach(items) { toDoListItem in
                        VStack(alignment: .leading) {
                            Text(toDoListItem.name!)
                                .font(.headline)
                            Text("\(toDoListItem.createdAt!)")
                        }
                    }.onDelete(perform: {
                        indexSet in guard let index = indexSet.first else {
                            return
                        }
                    let itemToDelete = items[index]
                    context.delete(itemToDelete)
                    do {
                        try context.save()
                        
                    } catch {
                        print(error)
                    }
                    })
                }
            }
            .navigationTitle("ToDoLoo")
            
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
