//
//  BoxOfficeViewController.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class BoxOfficeViewController: UIViewController {
    var movies = MovieInfo.movies
    
    let searchTextField: UITextField = {
        let textField = UITextField(borderStyle: .none)
        textField.placeholder = "20200401"
        
        return textField
    }()
    
    // TODO: 보관/폐기 고민
    let searchTextFieldUnderline = UIView(backgroundColor: .label)
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureTableView()
        configureTextField()
    }
}

extension BoxOfficeViewController {
    func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(searchTextField, searchTextFieldUnderline, searchButton, tableView)
        
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview(\.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalToSuperview().multipliedBy(0.65)
            $0.height.equalTo(48)
        }
        
        searchButton.snp.makeConstraints {
            $0.leading.equalTo(searchTextField.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.centerY.equalTo(searchTextField)
        }
        
        searchTextFieldUnderline.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(searchTextField)
            $0.height.equalTo(4)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(searchTextField)
            $0.trailing.equalTo(searchButton)
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.bottom.equalToSuperview(\.safeAreaLayoutGuide)
        }
    }
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func configureTextField() {
        searchTextField.delegate = self
        searchButton.addTarget(self, action: #selector(shuffle), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shuffle()
        
        return true
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MovieCell.self, for: indexPath)
        
        if let cell = cell as? MovieCell {
            let movie = movies[indexPath.row]
            cell.update(row: indexPath.row + 1, movie)
        }
        
        return cell
    }
    
    @objc func shuffle() {
        view.endEditing(true)
        
        movies.shuffle()
        tableView.reloadData()
    }
}

#Preview {
    BoxOfficeViewController()
}
