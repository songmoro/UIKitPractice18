//
//  LotteryViewController.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import Alamofire
import SnapKit

class LotteryViewController: BaseViewController {
    /**
     회차 텍스트필드
     */
    let roundTextField = UITextField(borderStyle: .roundedRect)
    
    /**
     당첨번호 안내 레이블
     */
    let descriptionLabel = UILabel(text: "당첨번호 안내")
    
    /**
     추첨 날짜 레이블
     */
    let dateLabel = UILabel(text: "0000-00-00 추첨")
    
    /**
     회차 + 당첨결과 레이블
     */
    let resultLabel = UILabel()
    
    /**
     당첨번호 뷰 스택
     */
    let numberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        
        return stackView
    }()
    
    /**
     당첨번호 뷰들
     */
    var numberViews = [UIView]()
    
    /**
     피커 뷰 아이템
     */
    var items: [Int] = Array(1...1181)
    
    /**
     번호 색깔
     */
    let colors: [UIColor] = [.systemYellow, .systemBlue, .systemBlue, .systemRed, .systemRed, .systemGray, .clear, .systemGray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configurePicker()
    }
}

extension LotteryViewController {
    func configureView() {
        let separatorView = UIView(backgroundColor: .opaqueSeparator)
        view.addSubviews(roundTextField, descriptionLabel, dateLabel, separatorView, resultLabel, numberStackView)
        
        [roundTextField, descriptionLabel, separatorView, numberStackView].snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
        }
        
        [roundTextField, dateLabel, separatorView, numberStackView].snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
        }
        
        roundTextField.snp.makeConstraints {
            $0.top.equalToSuperview(\.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(roundTextField.snp.bottom).offset(24)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(descriptionLabel)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        numberStackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(28)
            $0.height.equalTo(60)
        }
    }
    
    func configureStackView(_ numbers: [Int]) {
        numberViews.forEach {
            $0.removeFromSuperview()
        }
        
        (0...7).forEach {
            let view: UIView
            
            switch $0 {
            case 0...5:
                view = CircleView(width: 40, number: numbers[$0])
                view.backgroundColor = colors[$0]
            case 6:
                view = CircleView(width: 40)
                view.backgroundColor = colors[$0]
            case 7:
                let stackView = UIStackView()
                stackView.axis = .vertical
                stackView.alignment = .center
                
                view = stackView
                
                let numberView = CircleView(width: 40, number: numbers[$0])
                numberView.backgroundColor = colors[$0]
                
                let bonusLabel = UILabel(text: "보너스")
                bonusLabel.font = .systemFont(ofSize: 14)
                
                stackView.addArrangedSubview(numberView)
                stackView.addArrangedSubview(bonusLabel)
            default: return
            }
            
            numberViews.append(view)
            numberStackView.addArrangedSubview(view)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func configurePicker() {
        let picker = UIPickerView()
        roundTextField.inputView = picker
        
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(items.count - 1, inComponent: 0, animated: false)
        
        pickerView(picker, didSelectRow: items.count - 1, inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        call(row + 1)
    }
    
    func call(_ round: Int) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do")!
        let parameters = LotteryParameters(method: "getLottoNumber", drwNo: round)
        
        // URLEncodedFormParameterEncoder
        AF.request(url, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LotteryResponse.self) {
                switch $0.result {
                case .success(let lottery):
                    self.roundTextField.text = round.description
                    self.resultLabel.text = "\(round.description)회 당첨결과"
                    self.dateLabel.text = "\(lottery.drwNoDate) 추첨"
                    self.configureStackView(lottery.numbers)
                case .failure:
                    break
                }
            }
    }
}

#Preview {
    LotteryViewController()
}
