//
//  BoxOffice.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/24/25.
//

struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}

struct BoxOfficeParameters: Encodable {
    // key
    let key: String
    
    // yyyymmdd
    let targetDt: String
    
    // "0"..."10", nil
    let itemPerPage: String? = nil
    
    // "Y", "N", nil
    let multiMovieYn: String? = nil
    
    // "K", "F", nil
    let repNationCd: String? = nil
    
    // "0105000000”
    let wideAreaCd: String? = nil
}
