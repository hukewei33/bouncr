//
//  QRCodeViewModel.swift
//  team10app
//
//  Created by GraceJoseph on 11/5/21.
//

import Foundation
import SwiftUI

final class QRCodeScannerViewModel: ObservableObject {
    
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    
    var statusColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
}
