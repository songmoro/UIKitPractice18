//
//  BoxOfficeViewController.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class BoxOfficeViewController: UIViewController {
    var movies = [Movie]()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField(borderStyle: .none)
        textField.placeholder = "20200401"
        textField.delegate = self
        
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        
        tableView.register(MovieCell.self)
        
        return tableView
    }()
    
    let dotDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd."
        
        return dateFormatter
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        // TODO: formstyle
        let yesterday = Date().yesterday.formatted(.dateTime
            .year()
            .month(.twoDigits)
            .day(.twoDigits)
            .locale(Locale(identifier: "ko-KR"))
        )
        
        let yesterdayDate = dotDateFormatter.date(from: yesterday)!
        let yesterdayText = dateFormatter.string(from: yesterdayDate)
        
        call(yesterdayText)
    }
}

extension BoxOfficeViewController {
    func configure() {
        let searchTextFieldUnderline = UIView(backgroundColor: .label)
        
        view.backgroundColor = .systemBackground
        view.addSubviews(searchTextField, searchTextFieldUnderline, searchButton, tableView)
        
        [searchTextField, tableView].snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
        }
        
        [searchButton, tableView].snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview(\.safeAreaLayoutGuide).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.65)
            $0.height.equalTo(48)
        }
        
        searchButton.addTarget(self, action: #selector(didEndEditing), for: .touchUpInside)
        searchButton.snp.makeConstraints {
            $0.leading.equalTo(searchTextField.snp.trailing).offset(12)
            $0.height.centerY.equalTo(searchTextField)
        }
        
        searchTextFieldUnderline.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(searchTextField)
            $0.height.equalTo(4)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.bottom.equalToSuperview(\.safeAreaLayoutGuide)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didEndEditing()
        return true
    }
    
    @objc func didEndEditing() {
        view.endEditing(true)
        call(searchTextField.text!)
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func call(_ date: String) {
        guard dateFormatter.date(from: date) != nil else { return }
        
        let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")!
        let parameters = BoxOfficeParameters(key: Secret.boxOfficeApiKey, targetDt: date)
        
        AF.request(url, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BoxOfficeResponse.self) {
                switch $0.result {
                case .success(let boxOfficeResponse):
                    self.movies = boxOfficeResponse.boxOfficeResult.dailyBoxOfficeList.map {
                        Movie(title: $0.movieNm, releaseDate: $0.openDt, audienceCount: Int($0.rank)!)
                    }
                    self.tableView.reloadData()
                default:
                    break
                }
            }
    }
}

extension Date {
    var yesterday: Date {
        Calendar.current.date(byAdding: DateComponents(day: -1), to: self)!
    }
}

#Preview {
    BoxOfficeViewController()
}
