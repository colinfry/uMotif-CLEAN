//
//  ContentView.swift
//  uMotif-clean
//
//  Created by Colin Fry on 26/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ContentViewModel(getJokeUseCase: CNGetJokeUseCase(dataSource: CNJokeDataSource(dataService: CNJokeService()))))
    }
        
    var body: some View {
        JokesList()
    }
    
    fileprivate func JokesList() -> some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.jokes){ item in
                        Text(item.joke)
                            .font(.body)
                            .padding(5)
                    }
                }
                .navigationTitle(viewModel.navTitle)
                .task {
                   await viewModel.getJokes()
                }
                .alert("Error", isPresented: $viewModel.hasError) {
                } message: {
                    Text(viewModel.errorMessage)
                }
            }
            
            ProgressView("Loadingjokes")
                .progressViewStyle(.circular)
                .opacity(viewModel.isLoading ? 1 : 0)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
