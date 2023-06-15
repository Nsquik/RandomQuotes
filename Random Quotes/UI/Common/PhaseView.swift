//
//  PhaseView.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 02/06/2023.
//

import SwiftUI

struct PhaseView<Content: View>: View {
    let phase: FetchableObjectPhase
    let content: Content
    
    init(phase: FetchableObjectPhase, @ViewBuilder content: () -> Content) {
        self.phase = phase
        self.content = content()
    }

    
    
    var body: some View {
        switch phase {
        case .loading:
            ProgressView()
        case .initial:
            EmptyView()
        case .fail(error: let error):
            Image(systemName: "flag.filled.and.flag.crossed")
                .resizable()
                .frame(width: 120, height: 80)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red.opacity(0.8))
            Text(error)
        default:
            content
        }

    }
}

struct PhaseView_Previews: PreviewProvider {
    static var previews: some View {
        PhaseView(phase: .success){
            Text("siema")
        }
    }
}
