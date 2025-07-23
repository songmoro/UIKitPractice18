//
//  BoxOfficeViewController.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

protocol IsIdentifiable {
    static var identifier: String { get }
}

extension IsIdentifiable {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UITableView {
    func register(_ cellClass: (AnyObject & IsIdentifiable).Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
}

extension UITableView {
    func dequeueReusableCell(_ cellClass: (AnyObject & IsIdentifiable).Type, for indexPath: IndexPath) -> UITableViewCell {
        self.dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath)
    }
}

class RatingView: UIView {
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "888"
        label.textColor = .systemBackground
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(ratingLabel)
        backgroundColor = .label
        
        ratingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

class MovieCell: UITableViewCell, IsIdentifiable {
    let ratingView = RatingView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "엽문 4: 더 파이널"
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "8888-88-88"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubviews(ratingView, titleLabel, dateLabel)
        
        ratingView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalToSuperview().multipliedBy(0.15)
        }
        
        titleLabel.setContentCompressionResistancePriority(dateLabel.contentCompressionResistancePriority(for: .horizontal) - 1, for: .horizontal)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(ratingView.snp.trailing).offset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(20).priority(.high)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func update(row: Int, _ movie: Movie) {
        ratingView.ratingLabel.text = "\(row)"
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
    }
}

class BoxOfficeViewController: UIViewController {
    var movies = MovieInfo.movies
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "20200401"
        
        return textField
    }()
    
    // TODO: 보관/폐기 고민
    let searchTextFieldUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        
        return view
    }()
    
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
