//
//  BluetoothManager.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import Foundation
import CoreBluetooth

final class BluetoothManager: NSObject, ObservableObject {
    /// The shared instance of the Bluetooth manager.
    static let shared = BluetoothManager()

    /// The underlying CoreBluetooth central manager.
    private var centralManager: CBCentralManager!

    /// The currently connected peripheral, if any.
    @Published var connectedPeripheral: CBPeripheral?
    
    /// Indicates whether any parypherial got connected.
    @Published var isConnected: Bool = false

    /// The current state of the Bluetooth manager.
    @Published var managerState: BluetoothManagerState = .notStarted

    /// List of discovered peripherals during scanning.
    @Published var discoveredPeripherals: [CBPeripheral] = []

    /// Indicates whether scanning is currently active.
    @Published var isScanning: Bool = false

    /// Initializes the Bluetooth manager and sets up the central manager.
    override init() {
        super.init()
        self.managerState = .starting
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    /// Starts scanning for peripherals.
    func startScanning() {
        isScanning.toggle()
        guard centralManager.state == .poweredOn else {
            managerState = .error
            return
        }
        managerState = .scanning
        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    /// Stops scanning for peripherals.
    func stopScanning() {
        centralManager.stopScan()
        isScanning = false
        
        // Reset manager state
        guard centralManager.state == .poweredOn else {
            managerState = .error
            return
        }
        managerState = .readyToPair
    }

    /// Connects to a specified peripheral.
    /// - Parameter peripheral: The peripheral to connect to.
    func connect(to peripheral: CBPeripheral) {
        managerState = .connecting
        centralManager.connect(peripheral, options: nil)
    }

    /// Disconnects from the currently connected peripheral.
    func disconnect() {
        guard let peripheral = connectedPeripheral else { return }
        centralManager.cancelPeripheralConnection(peripheral)
        connectedPeripheral = nil
        managerState = .disconnected
    }

    /// Handles errors encountered during Bluetooth operations.
    /// - Parameter error: The error to handle.
    func handleError(_ error: Error?) {
        // Log or handle the error as needed
        managerState = .error
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            managerState = .readyToPair
            // Auto-start scanning if needed
        default:
            managerState = .error
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.append(peripheral)
        }
        
        guard let peripheralName = peripheral.name,
              peripheralName.starts(with: "HydroField-BT") else {
            return
        }
        print("Attempting connection to newly discover peripherial...")
        connect(to: peripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        self.stopScanning()
        
        print("Sucessfully connected to peripheral: \(peripheral.name)")
        managerState = .connected
        isConnected = true
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral,
                        error: Error?) {
        print("Unable to connect to peripherial with: \(error?.localizedDescription)")
        handleError(error)
        startScanning()
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?) {
        print("Disconnected from peripheral: \(error?.localizedDescription)")
        connectedPeripheral = nil
        isConnected = false
        if let error = error {
            handleError(error)
        } else {
            managerState = .disconnected
        }
    }
}

