//
//  QRCodeScanner.swift
//  team10app
//
//  Created by GraceJoseph on 11/5/21.
//

import Foundation
import SwiftUI

struct QRCodeScannerView: View {
    
    @StateObject var QRviewModel = QRCodeScannerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $QRviewModel.scannedCode,
                            alertItem: $QRviewModel.alertItem)
                    .frame(maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned QR Code: ", systemImage: "qrcode.viewfinder")
                    .font(.title)
                
                StatusText(QRviewModel: QRviewModel)
            }
            .navigationTitle("QR Code Scanner")
            .alert(item: $QRviewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
        }
    }
}

struct StatusText: View {
    
    @State var QRviewModel: QRCodeScannerViewModel
    
    var body: some View {
        Text(QRviewModel.statusText)
            .bold()
            .font(.largeTitle)
            .foregroundColor(QRviewModel.statusColor)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}
