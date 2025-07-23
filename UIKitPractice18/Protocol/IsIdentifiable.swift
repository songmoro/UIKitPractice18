//
//  IsIdentifiable.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//


protocol IsIdentifiable {
    static var identifier: String { get }
}

extension IsIdentifiable {
    static var identifier: String {
        String(describing: Self.self)
    }
}