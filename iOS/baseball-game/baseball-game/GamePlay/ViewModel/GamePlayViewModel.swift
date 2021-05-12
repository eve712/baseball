//
//  GamePlayViewModel.swift
//  baseball-game
//
//  Created by Song on 2021/05/06.
//

import Foundation
import Combine

class GamePlayViewModel {
    
    @Published var gameManager: GameInformable!
    @Published var pitches: [Pitch]!
    @Published var error: Error!
    
    private let userTeamSide: TeamSide
    private var networkManager: NetworkManageable
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ userTeamSide: TeamSide, networkManager: NetworkManageable = NetworkManager()) {
        self.userTeamSide = userTeamSide
        self.networkManager = networkManager
    }
    
    
    //GameManager -> GameDTO에 따른 대대적인 변경 필요
    func requestGame() {
//        networkManager.get(type: GameDTO.self, url: EndPoint.url(path: "/1/attack")!)
//            .sink { error in
//            self.error = error as? Error
//        } receiveValue: { data in
//            self.pitches = data.turn.pitches
//            self.gameManager = GameManager(userTeamSide: self.userTeamSide, turn: data.turn)
//        }.store(in: &cancelBag)
    }
    
}
