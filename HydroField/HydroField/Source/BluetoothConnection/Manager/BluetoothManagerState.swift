//
//  BluetoothManagerState.swift
//  HydroField
//
//  Created by Maciej Sączewski on 06/04/2025.
//


/// Represents the current state of the Bluetooth manager.
enum BluetoothManagerState: String {
    /// The Bluetooth manager has not yet started.
    case notStarted

    /// The Bluetooth manager has started and is initializing.
    case starting

    /// The Bluetooth manager was initialized and started sucesfully
    case operational

    /// The Bluetooth manager is actively scanning for peripherals.
    case scanning

    /// The Bluetooth manager is connected to a peripheral.
    case connected

    /// The Bluetooth manager has been disconnected from the peripheral.
    case disconnected

    /// An error has occurred in the Bluetooth manager.
    case error
}
