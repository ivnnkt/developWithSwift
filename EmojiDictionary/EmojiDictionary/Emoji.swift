//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Nikita on 08.02.2022.
//

import Foundation

class Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentDirectory.appendingPathComponent("Emojis").appendingPathExtension("plist")
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        try? encodedEmojis?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Emoji] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedEmojiData = try?Data(contentsOf: archiveURL),
           let decodedEmojis = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrievedEmojiData) {
            return decodedEmojis
        } else {
            return []
        }
    }
    
    static func sampleEmojis() -> [Emoji] {
        let emojis: [Emoji] = [
            Emoji(symbol: "😄", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "🙁", name: "Confused Face", description: "A confused, pazzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "👨‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift.", usage: "apps, software, programming"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A grey elephant", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studing"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        ]
        return emojis
    }
}

