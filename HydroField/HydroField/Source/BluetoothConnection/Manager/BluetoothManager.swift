//
//  BluetoothManager.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import Foundation
import CoreBluetooth

class BluetoothConnectionManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralManagerDelegate {
    var central: CBCentralManager!
    
    @Published var isBluetoothEnabled: Bool = false
    
    override init() {
        super.init()
        self.central = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isBluetoothEnabled = central.state == .poweredOn ? true : false
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        // TODO: Updating state of periferial connection
    }
    
    func scanForPeripherial() {
        central.scanForPeripherals(withServices: nil)
        // Add delegato for didDiscover and way to pari with "defined" device
    }
}
