import Foundation

public enum BuildEnv: String, Equatable, Hashable, Codable {
    case production
    case development
    case staging
    case testing
}

public enum Web3AuthKeyType: String, Equatable, Hashable, Codable {
    case secp256k1
    case ed25519
}

public enum Web3AuthSigType: String, Equatable, Hashable, Codable {
    case ecdsaSecp256k1 = "ecdsa-secp256k1"
    case ed25519
    case bip340
}

public let TORUS_LEGACY_NETWORK: [LegacyNetwork: String] = [
    .MAINNET: "mainnet",
    .TESTNET: "testnet",
    .CYAN: "cyan",
    .AQUA: "aqua",
    .CELESTE: "celeste",
]

public let TORUS_SAPPHIRE_NETWORK: [SapphireNetwork: String] = [
    .SAPPHIRE_DEVNET: "sapphire_devnet",
    .SAPPHIRE_MAINNET: "sapphire_mainnet",
]

let TORUS_NETWORK: [TorusNetwork: String] = [
    TorusNetwork.sapphire(SapphireNetwork.SAPPHIRE_DEVNET): "sapphire_devnet",
    TorusNetwork.sapphire(SapphireNetwork.SAPPHIRE_MAINNET): "sapphire_mainnet",
    TorusNetwork.legacy(LegacyNetwork.MAINNET): "mainnet",
    TorusNetwork.legacy(LegacyNetwork.TESTNET): "testnet",
    TorusNetwork.legacy(LegacyNetwork.CYAN): "cyan",
    TorusNetwork.legacy(LegacyNetwork.AQUA): "aqua",
    TorusNetwork.legacy(LegacyNetwork.CELESTE): "celeste",
]

public typealias TORUS_NETWORK_TYPE = String

public let LEGACY_NETWORKS_ROUTE_MAP: [LegacyNetwork: LegacyNetworkMigrationInfo] = [
    .AQUA: LegacyNetwork.AQUA.migration_map,
    .CELESTE: LegacyNetwork.CELESTE.migration_map,
    .CYAN: LegacyNetwork.CYAN.migration_map,
    .MAINNET: LegacyNetwork.MAINNET.migration_map,
    .TESTNET: LegacyNetwork.TESTNET.migration_map,
]

public let CITADEL_SERVER_MAP: [BuildEnv: String] = [
    .production: "https://api.web3auth.io/citadel-service",
    .development: "https://api-develop.web3auth.io/citadel-service",
    .staging: "https://api.web3auth.io/citadel-service",
    .testing: "https://api-develop.web3auth.io/citadel-service",
]

public let DASHBOARD_PUBLIC_API_MAP: [BuildEnv: String] = [
    .production: "https://api.web3auth.io/signer-service",
    .development: "https://api-develop.web3auth.io/signer-service",
    .staging: "https://api.web3auth.io/signer-service",
    .testing: "https://api-develop.web3auth.io/signer-service",
]

public let LEGACY_METADATA_MAP: [BuildEnv: String] = [
    .production: "https://api.web3auth.io/metadata-service",
    .development: "https://api-develop.web3auth.io/metadata-service",
    .staging: "https://api.web3auth.io/metadata-service",
    .testing: "https://api-develop.web3auth.io/metadata-service",
]

public let FND_SERVER_MAP: [BuildEnv: String] = [
    .production: "https://api.web3auth.io/fnd-service",
    .development: "https://api-develop.web3auth.io/fnd-service",
    .staging: "https://api.web3auth.io/fnd-service",
    .testing: "https://api-develop.web3auth.io/fnd-service",
]

public let STORAGE_SERVER_MAP: [BuildEnv: String] = [
    .production: "https://api.web3auth.io/session-service",
    .development: "https://api-develop.web3auth.io/session-service",
    .staging: "https://api.web3auth.io/session-service",
    .testing: "https://api-develop.web3auth.io/session-service",
]

public let STORAGE_SERVER_SOCKET_URL_MAP: [BuildEnv: String] = [
    .production: "https://session.web3auth.io",
    .development: "https://develop-session.web3auth.io",
    .staging: "https://session.web3auth.io",
    .testing: "https://develop-session.web3auth.io",
]

public let KEY_TYPE: [Web3AuthKeyType: String] = [
    .secp256k1: Web3AuthKeyType.secp256k1.rawValue,
    .ed25519: Web3AuthKeyType.ed25519.rawValue,
]

public let SIG_TYPE: [Web3AuthSigType: String] = [
    .ecdsaSecp256k1: Web3AuthSigType.ecdsaSecp256k1.rawValue,
    .ed25519: Web3AuthSigType.ed25519.rawValue,
    .bip340: Web3AuthSigType.bip340.rawValue,
]

let MULTI_CLUSTER_NETWORKS: [LegacyNetwork] = []
