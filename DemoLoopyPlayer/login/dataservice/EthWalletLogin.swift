//
//  EthWalletLogin.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/03.
//

import Foundation
import web3swift
import PromiseKit
import SwiftKeychainWrapper
import BigInt
import Alamofire

enum WalletError: Error {
    case dataError
    case keystoreError
    case pathError
    case addressError
    case networkError
    case balanceError
    case mnemonicsError
    case unknownError
}

class EthWalletLogin {

    //static let shared = EthWalletLogin()
    private let userAddressKey = "userAddressKey"
    private let migratedKeystoreKey = "migratedKeystoreKey"
    private let cobakWalletKeystoreDataKey = "cobakWalletKeystoreDataKey"
    
    func importAccount(privateKey: String) throws {
        guard let privateKeyData = Data.fromHex(privateKey) else {
            throw WalletError.dataError
        }
        guard let keystore = (try? EthereumKeystoreV3(privateKey: privateKeyData)) ?? nil else {
            throw WalletError.keystoreError
        }
        guard let address = keystore.getAddress()?.address else {
            throw WalletError.keystoreError
        }

        try save(keystore: keystore, address: address)
    }
    
    private func save(keystore: AbstractKeystore, address: String, mnemonics: String? = nil) throws {
        if keystore is BIP32Keystore && mnemonics == nil {
            throw WalletError.dataError
        }
        
        try saveKeystoreOnKeychain(keystore: keystore)
        userAddress = address
        migratedKeystore = true
    }
    
    var userAddress: String? {
        get {
            return KeychainWrapper.standard.string(forKey: userAddressKey)
        }
        set {
            if let newValue = newValue {
                KeychainWrapper.standard.set(newValue, forKey: userAddressKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: userAddressKey)
            }
        }
    }
    
    var migratedKeystore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: migratedKeystoreKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: migratedKeystoreKey)
        }
    }
    
    private var userEthereumAddress: EthereumAddress? {
        guard let userAddress = userAddress else { return nil }
        return EthereumAddress(userAddress)
    }
    
    private func saveKeystoreOnKeychain(keystore: AbstractKeystore) throws {
        if keystore is BIP32Keystore {
            guard let keystoreParams = (keystore as! BIP32Keystore).keystoreParams else { throw WalletError.keystoreError }
            guard let keystoreData = try? JSONEncoder().encode(keystoreParams) else { throw WalletError.dataError }
            KeychainWrapper.standard.set(keystoreData, forKey: cobakWalletKeystoreDataKey)
        } else {
            guard let keystoreParams = (keystore as! EthereumKeystoreV3).keystoreParams else { throw WalletError.keystoreError }
            guard let keystoreData = try? JSONEncoder().encode(keystoreParams) else { throw WalletError.dataError }
            KeychainWrapper.standard.set(keystoreData, forKey: cobakWalletKeystoreDataKey)
        }
    }
}
