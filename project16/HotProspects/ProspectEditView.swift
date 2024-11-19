//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by ke on 2024/11/7.
//

import SwiftUI

struct ProspectEditView:View {
    @Bindable var perspect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Edit Name:", text: $perspect.name)
                TextField("Edit Amail Address", text: $perspect.emailAddress)
            }
        }
        .navigationTitle("Edit Prospect")
    }
}
