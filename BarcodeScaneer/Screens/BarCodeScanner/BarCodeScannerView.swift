//
//  BarCodeScannerView.swift
//  BarcodeScanner
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import SwiftUI

struct AlertItem:Identifiable{
    var id = UUID().uuidString
    let title:String
    let message:String
    let dismisButton: Alert.Button
    
}



struct BarCodeScannerView: View {

    @StateObject var viewModel = BarCodeScannerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                    .frame(width: UIScreen.main.bounds.width,height: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanner Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(viewModel.statusText)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(viewModel.statusTextColor)
                    .padding()
                
            }
    
        }
        .navigationTitle("Barcode Scanner")
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismisButton)
        }
    }
}

#Preview {
    BarCodeScannerView()
}
