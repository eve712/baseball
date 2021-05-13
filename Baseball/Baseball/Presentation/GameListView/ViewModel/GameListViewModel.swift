//
//  GameListViewModel.swift
//  Baseball
//
//  Created by 지북 on 2021/05/04.
//

import Foundation
import Combine

struct GameListViewModelAction {
    typealias MatchUpID = Int
    let showGamePlayView: ((MatchUpID) -> Void)
}

class GameListViewModel {
    @Published private (set) var matchUpGames: [MatchUp]
    @Published private (set) var error: String
    
    private var fetchGameListUseCase: FetchGameListUseCase
    private var action: GameListViewModelAction
    
    init(fetchGameListUseCase: FetchGameListUseCase, action: GameListViewModelAction) {
        self.matchUpGames = []
        self.error = ""
        self.fetchGameListUseCase = fetchGameListUseCase
        self.action = action
        fetchGameList()
    }
    
    func fetchGameList() {
        fetchGameListUseCase.execute { result in
            switch result {
            case .success(let matchUpGames):
                self.matchUpGames = matchUpGames
            case .failure(let error):
                self.errorHandler(error: error)
            }
        }
    }
    
    private func errorHandler(error: NetworkError) {
        switch error {
        case .network(description: let des):
            self.error = des
        case .parsing(description: let des):
            self.error = des
        }
    }
    
    func didSelectItem(indexPath: IndexPath) {
        action.showGamePlayView(indexPath.item + 1)
    }
}
