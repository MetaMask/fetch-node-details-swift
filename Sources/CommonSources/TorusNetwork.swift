import Foundation

internal enum TorusNetwork : Equatable, Hashable {
    case legacy(LegacyNetwork)
    case sapphire(SapphireNetwork)
    
    public var name : String {
        switch self {
        case .legacy(let network) :
            return network.name
        case .sapphire(let network) :
            return network.name
        }
    }
    
    public var path : String {
        switch self {
        case .legacy(let network) :
            return network.path
        case .sapphire(let network) :
            return network.path
        }
    }
    
    @available(*, deprecated, message: "Use CITADEL_SERVER_MAP[buildEnv] or DASHBOARD_PUBLIC_API_MAP[buildEnv] instead")
    public var signerMap :  String {
        switch self {
        case .legacy(let network) :
            return network.signerMap
        case .sapphire(let network) :
            return network.signerMap
        }
    }
}

public enum SapphireNetwork: Equatable, Hashable {
    case SAPPHIRE_DEVNET
    case SAPPHIRE_MAINNET

    public var path: String {
        switch self {
        case .SAPPHIRE_DEVNET:
            return "sapphire_devnet"
        case .SAPPHIRE_MAINNET:
            return "sapphire_mainnet"
        }
    }
    
    public var name: String {
        switch self {
        case .SAPPHIRE_DEVNET:
            return "sapphire_devnet"
        case .SAPPHIRE_MAINNET:
            return "sapphire_mainnet"
        }
    }
    
    @available(*, deprecated, message: "Use CITADEL_SERVER_MAP[buildEnv] or DASHBOARD_PUBLIC_API_MAP[buildEnv] instead")
    public var signerMap : String {
        return CITADEL_SERVER_MAP[.production]!
    }
}

public enum LegacyNetwork: Equatable, Hashable {
    case MAINNET
    case TESTNET
    case CYAN
    case AQUA
    case CELESTE

    public var path: String {
        switch self {
        case .MAINNET:
            return "mainnet"
        case .TESTNET:
            return "goerli"
        case .CYAN, .AQUA, .CELESTE:
            return "polygon-mainnet"
        }
    }
    
    public var name: String {
        switch self {
        case .MAINNET:
            return "mainnet"
        case .TESTNET:
            return "testnet"
        case .CYAN :
            return "cyan"
        case .AQUA :
            return "aqua"
        case .CELESTE:
            return "celeste"
        }
    }
    
    public var migration_map: LegacyNetworkMigrationInfo {
        switch self {
        case .MAINNET:
            return LegacyNetworkMigrationInfo(migrationCompleted: true, networkIdentifier: self.name, networkMigratedTo: SapphireNetwork.SAPPHIRE_MAINNET)
        case .TESTNET:
            return LegacyNetworkMigrationInfo(migrationCompleted: true, networkIdentifier: "teal", networkMigratedTo: SapphireNetwork.SAPPHIRE_DEVNET)
        case .CYAN :
            return LegacyNetworkMigrationInfo(migrationCompleted: true, networkIdentifier: self.name, networkMigratedTo: SapphireNetwork.SAPPHIRE_MAINNET)
        case .AQUA :
            return LegacyNetworkMigrationInfo(migrationCompleted: true, networkIdentifier: self.name, networkMigratedTo: SapphireNetwork.SAPPHIRE_MAINNET)
        case .CELESTE:
            return LegacyNetworkMigrationInfo(migrationCompleted: true, networkIdentifier: self.name, networkMigratedTo: SapphireNetwork.SAPPHIRE_MAINNET)
        }
    }
    
    public var networkMap : String {
        switch self {
        case .MAINNET: return "mainnet"
        case .TESTNET: return "goerli"
        case .CYAN: return "polygon-mainnet"
        case .AQUA: return "polygon-mainnet"
        case .CELESTE: return "polygon-mainnet"
        }
    }
    
    @available(*, deprecated, message: "Use CITADEL_SERVER_MAP[buildEnv] or DASHBOARD_PUBLIC_API_MAP[buildEnv] instead")
    public var signerMap : String {
        return CITADEL_SERVER_MAP[.production]!
    }
    
    @available(*, deprecated, message: "Use LEGACY_METADATA_MAP[buildEnv] instead")
    public var metadataMap: String {
        return LEGACY_METADATA_MAP[.production]!
    }
}

