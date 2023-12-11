//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by seif elshahet on 09/12/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16.0)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}


enum SampleError: Error {
    case errorRequired
}

var wrapper: ErrorWrapper {
    ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error.")
}

#Preview {
    ErrorView(errorWrapper: wrapper)
}
