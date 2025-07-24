//
//  Lottery.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

struct Lottery: Decodable {
    // 2025-07-19
    let drwNoDate: String
    
    // 1181
    let drwNo: Int
    
    // 1...45
    let drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo: Int
    
    var numbers: [Int] {
        [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, 0, bnusNo]
    }
}

struct LotteryParameters: Codable {
    let method: String
    let drwNo: Int
}
