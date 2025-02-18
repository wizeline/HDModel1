//
//  FaqView.swift
//  HD-POC
//
//  Created by Kelderth Krom on 16/02/25.
//

import SwiftUI

struct FaqView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                FaqCardView()
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("FAQ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(.accent)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    FaqView()
}

struct FaqCardView: View {
    var body: some View {
        GroupBox {
            Text("What is my benefit for registering my insurance policy with HD?")
                .font(.headline)
            
            Rectangle()
                .fill(.black.opacity(0.3))
                .frame(height: 2)
            
            Text("HD's top priority is to ensure the safety and security of all our customers. and by registering your insurance policy We will always make sure to provide you with the best possible service.")
                .font(.subheadline)
                .padding(.top, 20)
            
            Spacer()
        }
        .groupBoxStyle(CustomGroupBoxStyle())
        .frame(maxHeight: 250)
        .padding(.horizontal, 20)
    }
}

struct CustomGroupBoxStyle : GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.content
            configuration.label
        }
        .padding()
        .background(Color.accent.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black.opacity(0.2), lineWidth: 2)
        }
    }
}
