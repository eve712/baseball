//
//  SelectionViewController.swift
//  baseball-game
//
//  Created by Lia on 2021/05/03.
//

import UIKit
import Combine

protocol SelectViewModelDelegate: AnyObject {
    func didPressButton(with gameInfo: GameInfo)
}

class SelectionViewController: UIViewController {
    
    static let storyboard = "Main"
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gameListTableView: UITableView!
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    private var viewModel = SelectViewModel()
    private var dataSource: UITableViewDiffableDataSource<Section, Game>!
    private var cancelBag = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundUI()
        
        self.viewModel.requestGameSelection()
        self.registerNib()
        self.configureDataSource()
        self.bind()
    }

}


extension SelectionViewController {
    
    enum Section {
        case main
    }
    
    private func registerNib() {
        self.gameListTableView.register(GameCell.nib, forCellReuseIdentifier: GameCell.reuseIdentifier)
    }
    
    private func configureDataSource() {
        self.dataSource = UITableViewDiffableDataSource.init(tableView: self.gameListTableView) { [weak self] (tableView, indexPath, game) -> UITableViewCell in
            
            guard let self = self else { return UITableViewCell() }
            
            let cell = self.gameListTableView.dequeueReusableCell(withIdentifier: GameCell.reuseIdentifier) as? GameCell ?? GameCell()

            self.viewModel.setCellInfo(with: game)
            self.viewModel.delegate = self
            
            cell.updateUI(with: self.viewModel)
            self.bindSelection(with: cell)
            
            return cell
        }
    }
    
    private func createSnapshot(from games: [Game]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Game>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(games)
        self.dataSource.apply(snapshot)
    }
    
    private func bind() {
        viewModel.$games
            .receive(on: DispatchQueue.main)
            .sink { [weak self] games in
                guard let games = games else { return }
                self?.createSnapshot(from: games)
            }
            .store(in: &cancelBag)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                guard let error = error else { return }
                print(error) ///사용자에게 에러 표시하는 부분 미구현
            }.store(in: &cancelBag)
    }
    
}


extension SelectionViewController: Instantiatable, IdentifierReusable {
    
    static func instantiate() -> UIViewController {
        let myViewController = UIStoryboard(name: self.storyboard, bundle: nil).instantiateViewController(withIdentifier: self.reuseIdentifier) as? SelectionViewController
        
        return myViewController ?? SelectionViewController()
    }
    
}


extension SelectionViewController: SelectViewModelDelegate {
    
    func setUserID(with userID: String) {
        self.viewModel.setUserID(with: userID)
    }
    
    private func bindSelection(with cell: GameCell) {
        cell.$userTeam
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userTeam in
                guard let userTeam = userTeam else { return }
                self?.viewModel.selected(team: userTeam)
            }
            .store(in: &cancelBag)
    }
    
    func didPressButton(with gameInfo: GameInfo) {
        let nextVC = ControllerFactory.instantiate(viewController: GamePlayViewController.self) as? GamePlayViewController ?? GamePlayViewController()
        nextVC.getInfo(with: gameInfo)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


extension SelectionViewController {

    private func configureBackgroundUI() {
        self.gradientLayer.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1).cgColor, #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1).cgColor, #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        self.gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.gradientLayer.frame = self.view.bounds
        self.backgroundView.layer.addSublayer(self.gradientLayer)
    }
    
}