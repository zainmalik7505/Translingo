//
//  DeepLTranslator.swift
//  Translingo
//
//  Created by Zain Malik on 21/09/2024.
//

import Foundation

class DeepLTranslator: ObservableObject{
    @Published var translationText: String = ""
    
    private let apiKey: String = "04e50302-af0c-4a53-a8f7-962656474eb2:fx"
    
    
    func translate(text: String, targetLanguage: String){
        
        //Create the API Endpoint URL
        let url = URL(string: "https://api-free.deepl.com/v2/translate")!
        
        //Configure the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        //Prepare the Request Body
        let body = "auth_key=\(apiKey)&text=\(text)&target_lang=\(targetLanguage.uppercased())"
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Decode the JSON response
            if let translationResponse = try? JSONDecoder().decode(DeepLTranslationResponse.self, from: data) {
                DispatchQueue.main.async {
                    self?.translationText = translationResponse.translations.first?.text ?? "No translation found"
                }
            }
        }
        task.resume() // Start the network task
    }
}

