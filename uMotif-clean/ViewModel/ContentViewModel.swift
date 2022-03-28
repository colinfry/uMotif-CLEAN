//
//  ContentViewModel.swift
//  uMotif-clean
//
//  Created by Colin Fry on 26/03/2022.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    
    var getJokesUseCase: GetJokesUseCaseProtocol?
    
    init(getJokesUseCase: GetJokesUseCaseProtocol?) {
        self.getJokesUseCase = getJokesUseCase
    }
            
    @Published var jokes: [CNJoke] = []
    @Published var errorMessage = ""
    @Published var isLoading = true
    @Published var hasError = false
    
    let navTitle = "55 Terrible Jokes"
    
    func getJokes() async {
        isLoading = true
        errorMessage = ""
        
        let result = await getJokesUseCase?.execute()
        isLoading = false
        
        switch result {
        case .success(let jokes):
            self.jokes = jokes
        case .failure(let error):
            self.jokes = []
            errorMessage = error.localizedDescription
            hasError = true
        case .none:
            self.jokes = []
            errorMessage = "Loading Error - No Use Case"
            hasError = true
        }
    }
}
