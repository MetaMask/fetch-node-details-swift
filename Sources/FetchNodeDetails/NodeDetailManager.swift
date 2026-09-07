import BigInt
import Foundation
import OSLog
// Global variable
var fndLogType = OSLogType.default

open class NodeDetailManager {
    
    private var fndServerEndpoint: String
    private var currentEpoch: String = "0"
    private var torusNodeEndpoints = [String]()
    private var torusNodePub: [TorusNodePubModel] = []
    private var torusIndexes: [BigUInt] = []
    private var torusNodeSSSEndpoints: [String] = []
    private var torusNodeRSSEndpoints: [String] = []
    private var torusNodeTSSEndpoints: [String] = []

    private var network: Web3AuthNetwork = .SAPPHIRE_MAINNET
    private var buildEnv: BuildEnv = .production
    private var keyType: Web3AuthKeyType = .secp256k1
    private var sigType: Web3AuthSigType = .ecdsaSecp256k1

    private var urlSession: URLSession
    private var updated = false
    var nodeDetails: AllNodeDetailsModel {
        return .init(_currentEpoch: currentEpoch, _torusNodeEndpoints: torusNodeEndpoints, _torusNodeSSSEndpoints: torusNodeSSSEndpoints, _torusNodeRSSEndpoints: torusNodeRSSEndpoints, _torusNodeTSSEndpoints:torusNodeTSSEndpoints, _torusIndexes: torusIndexes, _torusNodePub: torusNodePub, _updated: updated)
    }


    public init(
        network: Web3AuthNetwork,
        fndEndpoint: String? = nil,
        logLevel: OSLogType = .default,
        urlSession: URLSession = URLSession.shared,
        buildEnv: BuildEnv = .production,
        keyType: Web3AuthKeyType = .secp256k1,
        sigType: Web3AuthSigType = .ecdsaSecp256k1
    ) {
        fndLogType = logLevel // to be used across application
        self.network = network
        self.urlSession = urlSession
        self.buildEnv = buildEnv
        self.keyType = keyType
        self.sigType = sigType
        if let endpoint = fndEndpoint, !endpoint.isEmpty {
            self.fndServerEndpoint = endpoint
        } else {
            self.fndServerEndpoint = "\(FND_SERVER_MAP[buildEnv]!)/node-details"
        }
    }
    
    public func getNodeDetails(verifier: String, verifierID: String) async throws -> AllNodeDetailsModel {
        switch network.torusNetwork {
        case .legacy(let legacyNetwork):
            if updated && !MULTI_CLUSTER_NETWORKS.contains(legacyNetwork) {
                return nodeDetails
            }
        case .sapphire(_):
            break
        }
    
        
        var fndResult: AllNodeDetailsModel
        fndResult = nodeDetails
        
        do {
            guard let urlEncodedVerifier = verifier.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let urlEncodedVerifierID = verifierID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let urlEncodedNetwork = network.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let urlEncodedKeyType = keyType.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let urlEncodedSigType = sigType.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                throw FetchNodeError.InvalidInput
            }
            
            guard let url = URL(string: "\(fndServerEndpoint)?network=\(urlEncodedNetwork)&verifier=\(urlEncodedVerifier)&verifierId=\(urlEncodedVerifierID)&keyType=\(urlEncodedKeyType)&sigType=\(urlEncodedSigType)") else {
                throw FetchNodeError.InvalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(NodeDetailsResponse.self, from: data)
            let nodeDetails = response.getNodeDetails()
            fndResult.setNodeDetails(nodeDetails: nodeDetails, updated: true)
            return fndResult
        } catch let error {
            os_log("Failed to fetch node details from server, using local. %s", log: getTorusLogger(log: FNDLogger.core, type: .error), type: .error, error.localizedDescription)
        }
        
        let nodeDetails = try fetchLocalConfig(network: self.network)
        fndResult.setNodeDetails(nodeDetails: nodeDetails, updated: false)
        return fndResult
    }
    
    public func getMetadataUrl() async throws -> String {
        switch network.torusNetwork {
        case .legacy:
            return LEGACY_METADATA_MAP[buildEnv]!
        case .sapphire:
            return try await self.getNodeDetails(verifier: "test-verifier", verifierID: "test-verifier-id").getTorusNodeEndpoints()[0].replacingOccurrences(of: "/sss/jrpc", with: "/metadata")
        }
    }
    
    // setNodeDetails is defined in AllNodeDetailsModel because of accessibility of variables
}
