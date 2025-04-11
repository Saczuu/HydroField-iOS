//
//  BluetoothManager.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import Foundation
import CoreBluetooth

/// A manager class for handling Bluetooth operations using CoreBluetooth framework.
/// This class provides functionalities for scanning, connecting, and disconnecting peripherals.
final class BluetoothManager: NSObject, ObservableObject {

    /// The shared instance of the Bluetooth manager.
    static let shared = BluetoothManager()

    /// The underlying CoreBluetooth central manager.
    private var centralManager: CBCentralManager!

    /// The currently connected peripheral, if any.
    @Published var connectedPeripheral: CBPeripheral?

    /// Indicates whether any peripheral got connected.
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
    ///
    /// This function toggles the scanning state, checks if the Bluetooth manager is powered on,
    /// and starts scanning for peripherals if the manager is ready.
    func startScanning() {
        isScanning.toggle()
        guard centralManager.state == .poweredOn else {
            managerState = .error
            return
        }
        managerState = .scanning
        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        Logger.info(message: "Started scanning for peripherals.", category: .bluetooth)
    }

    /// Stops scanning for peripherals.
    ///
    /// This function stops the scanning process and resets the manager state to `readyToPair`.
    func stopScanning() {
        centralManager.stopScan()
        isScanning = false
        
        // Reset manager state
        guard centralManager.state == .poweredOn else {
            managerState = .error
            return
        }
        managerState = .readyToPair
        Logger.info(message: "Stopped scanning for peripherals.", category: .bluetooth)
    }

    /// Connects to a specified peripheral.
    ///
    /// - Parameter peripheral: The peripheral to connect to.
    /// - Starts the connection process with the peripheral.
    func connect(to peripheral: CBPeripheral) {
        managerState = .connecting
        centralManager.connect(peripheral, options: nil)
        Logger.info(message: "Attempting to connect to peripheral: \(peripheral.name ?? "Unknown")", category: .bluetooth)
    }

    /// Disconnects from the currently connected peripheral.
    ///
    /// This function cancels the connection and resets the connected peripheral state.
    func disconnect() {
        guard let peripheral = connectedPeripheral else { return }
        centralManager.cancelPeripheralConnection(peripheral)
        connectedPeripheral = nil
        managerState = .disconnected
        Logger.info(message: "Disconnected from peripheral.", category: .bluetooth)
    }

    /// Handles errors encountered during Bluetooth operations.
    ///
    /// - Parameter error: The error to handle.
    /// - Logs the error and updates the manager state to `error`.
    func handleError(_ error: Error?) {
        managerState = .error
        Logger.error(message: "Error encountered: \(error?.localizedDescription ?? "Unknown error")", category: .bluetooth)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {

    /// Called when the central manager's state is updated.
    ///
    /// - Parameter central: The CBCentralManager instance.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            managerState = .readyToPair
            Logger.info(message: "Bluetooth is powered on. Ready to pair.", category: .bluetooth)
        default:
            managerState = .error
            Logger.error(message: "Bluetooth is not powered on or unavailable.", category: .bluetooth)
        }
    }

    /// Called when a peripheral is discovered during scanning.
    ///
    /// - Parameters:
    ///   - central: The CBCentralManager instance.
    ///   - peripheral: The discovered peripheral.
    ///   - advertisementData: The advertisement data.
    ///   - RSSI: The received signal strength indicator.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.append(peripheral)
        }

        guard let peripheralName = peripheral.name,
              peripheralName.starts(with: "HydroField-BT") else {
            return
        }

        Logger.info(message: "Discovered peripheral: \(peripheralName), attempting connection.", category: .bluetooth)
        connect(to: peripheral)
    }

    /// Called when a connection to a peripheral is successful.
    ///
    /// - Parameter central: The CBCentralManager instance.
    /// - Parameter peripheral: The connected peripheral.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        self.stopScanning()

        Logger.info(message: "Successfully connected to peripheral: \(peripheral.name ?? "Unknown")", category: .bluetooth)
        managerState = .connected
        isConnected = true
    }

    /// Called when a connection to a peripheral fails.
    ///
    /// - Parameters:
    ///   - central: The CBCentralManager instance.
    ///   - peripheral: The peripheral that failed to connect.
    ///   - error: The error encountered during the connection attempt.
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral,
                        error: Error?) {
        Logger.error(message: "Failed to connect to peripheral: \(peripheral.name ?? "Unknown") with error: \(error?.localizedDescription ?? "Unknown error")", category: .bluetooth)
        handleError(error)
        startScanning()
    }

    /// Called when a peripheral is disconnected.
    ///
    /// - Parameters:
    ///   - central: The CBCentralManager instance.
    ///   - peripheral: The peripheral that was disconnected.
    ///   - error: The error encountered during disconnection, if any.
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?) {
        Logger.info(message: "Disconnected from peripheral: \(peripheral.name ?? "Unknown")", category: .bluetooth)
        connectedPeripheral = nil
        isConnected = false
        if let error = error {
            handleError(error)
        } else {
            managerState = .disconnected
        }
    }
}
