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
        self.managerState = centralManager.state == .poweredOn ? .operational : .error
    }

    /// Starts scanning for peripherals.
    func startScanning() {
        guard centralManager.state == .poweredOn else {
            managerState = .error
            return
        }

        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        isScanning = true
        managerState = .scanning
    }

    /// Stops scanning for peripherals.
    func stopScanning() {
        centralManager.stopScan()
        isScanning = false
        managerState = .disconnected
    }

    /// Connects to a specified peripheral.
    /// - Parameter peripheral: The peripheral to connect to.
    func connect(to peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
        managerState = .starting
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
            managerState = .starting
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
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        managerState = .connected
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral,
                        error: Error?) {
        handleError(error)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?) {
        connectedPeripheral = nil
        if let error = error {
            handleError(error)
        } else {
            managerState = .disconnected
        }
    }
}

