//
//  BarCodeScannerView.swift
//  BarcodeScanner
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import SwiftUI

struct BarCodeScannerView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                ScannerView()
                    .frame(width: .infinity,height: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanner Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text("Not yet Scanned")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.green)
                    .padding()
            }
        }
        .navigationTitle("Barcode Scanner")
    }
}

#Preview {
    BarCodeScannerView()
}
