//
//  ViewController.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    /**
     회차 텍스트필드
     */
    let roundTextField: UITextField = {
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
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        
        return view
    }()
    
    /**
     회차 + 당첨결과 레이블
     */
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "913회 당첨결과"
        
        return label
    }()
    
    /**
     당첨번호 레이블들
     */
    // TODO: [] -> stack
    var numberLabels = [UILabel]()
    
    let number1Label: UILabel = {
        let label = UILabel()
        label.text = "1"
        
        return label
    }()
    
    let number2Label: UILabel = {
        let label = UILabel()
        label.text = "2"
        
        return label
    }()
    
    let number3Label: UILabel = {
        let label = UILabel()
        label.text = "3"
        
        return label
    }()
    
    let number4Label: UILabel = {
        let label = UILabel()
        label.text = "4"
        
        return label
    }()
    
    let number5Label: UILabel = {
        let label = UILabel()
        label.text = "5"
        
        return label
    }()
    
    let number6Label: UILabel = {
        let label = UILabel()
        label.text = "6"
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureView()
    }
}

extension ViewController {
    func configureView() {
        view.addSubviews(roundTextField, descriptionLabel, dateLabel, separatorView, resultLabel)
        
        numberLabels.append(contentsOf: [number1Label, number2Label, number3Label, number4Label, number5Label, number6Label])
        numberLabels.forEach {
            view.addSubview($0)
        }
        
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
        
        numberLabels.forEach {
            $0.snp.makeConstraints {
                $0.top.equalTo(resultLabel.snp.bottom).offset(28)
            }
        }
    }
}
