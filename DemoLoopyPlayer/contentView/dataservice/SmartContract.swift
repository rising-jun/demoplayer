//
//  SmartContract.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/05.
//

import Foundation
import web3swift
import BigInt
import RxSwift

class SmartContract{
    
    private var userAddress: EthereumAddress!
    private let web3test = Web3.InfuraRinkebyWeb3()
    private var contract: web3.web3contract!
    private var contractEthreumAddress: EthereumAddress!
    private var nft: ERC721!
    private var tokenIDList: [String] = []
    private var idResult = PublishSubject<BigUInt>()
    
    init(userAddress: String, contractAddress: String) {
        self.userAddress = EthereumAddress(userAddress)
        self.contractEthreumAddress = EthereumAddress(contractAddress)
        self.contract = web3test.contract("WITCH_ABI".localized(), at: contractEthreumAddress, abiVersion: 2)
        self.nft = ERC721(web3: web3test, provider: web3test.provider, address: contractEthreumAddress)
    }
    
    public func checkTokenInfo(contractAddress: String, completion: @escaping (String?) -> ()) {
        DispatchQueue.global().async {
            //let balance = try? self.tokenBalance(contractAddress: contractAddress)
            guard let tokenBal = try? self.nftBalanceOf() else {
                return
            }
            
            guard let tokenIdList = try? self.nftTokenId(index: tokenBal) else{
                return
            }
            
            print("tokenIdList : \(tokenIdList)")
            
            guard let tokenURI = try? self.nftURI(tokenId: tokenIdList.first!) else{
                return
            }
            
            print(tokenURI)
            DispatchQueue.main.async {
                completion(tokenURI)
            }
        }
    }
    
    private func nftURI(tokenId: BigUInt) throws -> String{
        var result = try nft.tokenURI(tokenId: tokenId)
        return result
    }
    
    private func nftTokenId(index: BigUInt) throws -> [BigUInt]{
        var idList: [BigUInt] = []
        for i in 0 ..< index{
            idList.append(try nft.tokenOfOwnerByIndex(owner: userAddress, index: BigUInt(i)))
        }
        
        return idList
    }
    
    private func nftBalanceOf() throws -> BigUInt{
        var result = try nft.getBalance(account: userAddress)
        print("nftBalanceOf Method \(result)")
        return result
    }
    
    
    
    private func nftName() throws -> String{
        let balanceOfCallResult = try contract.method("name")?.call()
        print("namename \(try contract.method("name")?.call())")
        guard case .some = balanceOfCallResult, let name = balanceOfCallResult!["0"] as? String else {
            print("none")
            throw WalletError.networkError }
        return "\(name)"
    }
}

