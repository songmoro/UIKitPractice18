//
//  LottoViewController.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class CircleView: UIView {
    let numberLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(width: CGFloat, number: Int) {
        self.init(length: width, number: number)
    }
    
    convenience init(height: CGFloat, number: Int) {
        self.init(length: height, number: number)
    }
    
    convenience init(width: CGFloat) {
        self.init(length: width)
    }
    
    convenience init(height: CGFloat) {
        self.init(length: height)
    }
    
    private init(length: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: length, height: length))
        configureLayout(length)
        
        numberLabel.text = "+"
    }
    
    private init(length: CGFloat, number: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: length, height: length))
        configureLayout(length)
        
        numberLabel.text = number.description
        numberLabel.textColor = .systemBackground
    }
    
    private func configureLayout(_ length: CGFloat) {
        addSubview(numberLabel)
        
        numberLabel.textAlignment = .center
        
        numberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.size.equalTo(CGSize(width: length, height: length))
        }
        
        layer.cornerRadius = length / 2
    }
}

class LottoViewController: UIViewController {
    /**
     회차 텍스트필드
     */
    let roundTextField: UITextField = {
        // TODO: 키보드 입력 방지
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    /**
     당첨번호 안내 레이블
     */
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        
        return label
    }()
    
    /**
     추첨 날짜 레이블
     */
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-05-30 추첨"
        
        return label
    }()
    
    /**
     구분선
     */
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        
        return view
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureView()
        configurePicker()
    }
}

extension LottoViewController {
    func configureView() {
        view.addSubviews(roundTextField, descriptionLabel, dateLabel, separatorView, resultLabel, numberStackView)
        
        roundTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview(\.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(roundTextField.snp.bottom).offset(24)
            $0.leading.equalTo(roundTextField.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(descriptionLabel)
            $0.trailing.equalTo(roundTextField.snp.trailing)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.trailing.equalTo(dateLabel.snp.trailing)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        numberStackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
    }
    
    func configureStackView() {
        var numbers = Array(1...45)
        let colors: [UIColor] = [.systemYellow, .systemBlue, .systemBlue, .systemRed, .systemRed, .systemGray, .clear, .systemGray]
        
        numberViews.forEach {
            $0.removeFromSuperview()
        }
        
        (1...8).forEach {
            let view: UIView
            let randomIndex = Int.random(in: 0..<(numbers.count))
            
            switch $0 {
            case 0...7:
                view = ($0 == 7) ? CircleView(width: 40) : CircleView(width: 40, number: numbers.remove(at: randomIndex))
                
                view.backgroundColor = colors[$0 - 1]
            case 8:
                let stackView = UIStackView()
                stackView.axis = .vertical
                stackView.alignment = .center
                
                view = stackView
                
                let numberView = CircleView(width: 40, number: numbers.remove(at: randomIndex))
                numberView.backgroundColor = colors[$0 - 1]
                
                let bonusLabel = UILabel()
                bonusLabel.text = "보너스"
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

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    var items: [Int] {
        Array(1...1181)
    }
    
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
        roundTextField.text = items[row].description
        resultLabel.text = "\(items[row].description)회 당첨결과"
        configureStackView()
    }
}
