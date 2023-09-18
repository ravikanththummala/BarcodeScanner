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

struct AlertContext {
    static let invalidDevicePut = AlertItem(title: "In ValidInput", message: "Something is wrong with the camera. We are unable to capture the input.", dismisButton: .default(Text("Ok")))
                                            
   static let scannedInvalid = AlertItem(title: "Scanned Invalid", message: "The value scanned is not valid. This app scans EAN-8 and EAN-13", dismisButton: .default(Text("Ok")))

}

struct BarCodeScannerView: View {
    @State private var scannedCode = ""
    @State private var alertItem:AlertItem?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(width: UIScreen.main.bounds.width,height: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanner Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not yet Scanned" : scannedCode )
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(scannedCode.isEmpty ? .red : .green)
                    .padding()
                
            }
    
        }
        .navigationTitle("Barcode Scanner")
        .alert(item: $alertItem) { alertItem in
            Alert(title: Text(alertItem.title), 
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismisButton)
        }
    }
}

#Preview {
    BarCodeScannerView()
}
