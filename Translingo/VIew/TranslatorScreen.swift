//
//  TranslatorScreen.swift
//  Translingo
//
//  Created by Zain Malik on 21/09/2024.
//

import SwiftUI

struct TranslatorScreen: View {
    
    @StateObject private var vm = DeepLTranslator()
    @State private var inputText: String = ""
    @State private var selectedLanguage: String = "EN"
    
    let languages = ["ES", "FR", "DE", "IT", "PT"] // Language options (Spanish, French, German, Italian, Portuguese)
    
    
    
    var body: some View {
        
        TextField("Enter Text", text: $inputText)
            .padding()
            .autocapitalization(.none)
        
        VStack() {
            VStack(spacing: 20) {
                Picker("Select Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self){language in
                        Text(language).tag(language)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                Button("Translate"){
                    vm.translate(text: inputText, targetLanguage: selectedLanguage)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(8)
                
                Text("Translated Text:")
                    .font(.headline)
                    .padding()
                
                Text(vm.translationText)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    TranslatorScreen()
}
