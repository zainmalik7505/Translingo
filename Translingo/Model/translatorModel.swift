//
//  translatorModel.swift
//  Translingo
//
//  Created by Zain Malik on 21/09/2024.
//

import Foundation

struct DeepLTranslationResponse: Codable {
    struct Translation: Codable {
        let text: String
    }
    let translations: [Translation]
}

