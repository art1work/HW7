//
//  Question.swift
//  HW7
//
//  Created by Артём Ермохин on 17.07.2022.
//

import Foundation

struct Question {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Как ты любишь отдыхать?",
                responseType: .single,
                answers: [
                    Answer(title: "В шумной компании", beer: .baltika),
                    Answer(title: "На берегу Волги", beer: .zhiguli),
                    Answer(title: "Главное в кругу семьи", beer: .corona),
                    Answer(title: "Перед телеящиком с футболом", beer: .razlivnoe),
                ]
            ),
            Question(
                title: "С чем ты согласен?",
                responseType: .multiple,
                answers: [
                    Answer(title: "Ты мальчик на девятке", beer: .baltika),
                    Answer(title: "Был на дне", beer: .zhiguli),
                    Answer(title: "Пиво с лимоном это кайф", beer: .corona),
                    Answer(title: "И в пластике норм", beer: .razlivnoe),
                ]
            ),
            Question(
                title: "Легко ли тебе общаться с людьми?",
                responseType: .ranged,
                answers: [
                    Answer(title: "Сложно", beer: .baltika),
                    Answer(title: "Не очень", beer: .zhiguli),
                    Answer(title: "Просто", beer: .corona),
                    Answer(title: "Легко", beer: .razlivnoe)
                    
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let beer: Beer
}

enum Beer: String {
    case baltika = "Балтика"
    case zhiguli = "Жигули"
    case corona = "Corona Extra "
    case razlivnoe = "Разливное пиво"
    
    var definition: String {
        switch self {
        case .baltika:
            return "Утром лучшая зарядка это балтика девятка!"
        case .zhiguli:
            return "Самарский Жигуль! С демидролом, зато свой!"
        case .corona:
            return "Какие на тебе трусики? Не семейные? Тебе что, плевать на семью?"
        case .razlivnoe:
            return "Две сиси в руки и домой, а то скоро таймаут закончится!"
        }
    }
}
