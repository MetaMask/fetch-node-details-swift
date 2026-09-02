@testable import FetchNodeDetails

import XCTest

class fetchNodeDetailsTests: XCTestCase {
    var timeout: TimeInterval = 10
    var verifierId = "hello@tor.us"
    func test_getNode_Mainnet() async throws {
        let fnd = NodeDetailManager(network: .MAINNET)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
        XCTAssertEqual(result, SampleOutputMainnet().val)
    }

    // TODO: https://mainnet.infura.io/v3/7f287687b3d049e2bea7b64869ee30a3 is unsupported network
//    func test_getNode_custom_path_Mainnet() async {
//        let fnd = FetchNodeDetails(network: .CUSTOM(path: "https://\("mainnet").infura.io/v3/\("7f287687b3d049e2bea7b64869ee30a3")"))
//        do {
//            let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
//            XCTAssertEqual(result, SampleOutputMainnet().val)
//        } catch {
//            XCTFail()
//        }
//    }

    func test_getNode_Testnet() async throws {
        let fnd = NodeDetailManager(network: .TESTNET)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
        XCTAssertEqual(result, SampleOutputTestnet().val)
    }

    func test_getNode_SapphireDevnet() async throws {
        let fnd = NodeDetailManager(network: .SAPPHIRE_DEVNET)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
        var config = try! SapphireConfig(network: .SAPPHIRE_DEVNET)
        config.setUpdated(updated: true)
        XCTAssertEqual(result, config)
        XCTAssertEqual(result, SampleOutputSAPPHIREDEVNET().val)
    }

    func test_getNode_SapphireMainnet() async throws {
        let fnd = NodeDetailManager(network: .SAPPHIRE_MAINNET)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
        var config = try! SapphireConfig(network: .SAPPHIRE_MAINNET)
        config.setUpdated(updated: true)
        XCTAssertEqual(result, config)
        XCTAssertEqual(result, SampleOutputSAPPHIREMAINNET().val)
    }

    func test_getNode_Cyan() async throws {
        let fnd = NodeDetailManager(network: .CYAN)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
        XCTAssertEqual(result, SampleOutputCyan().val)
    }

    func test_getNode_Aqua() async throws {
        let fnd = NodeDetailManager(network: .AQUA)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: verifierId)
        XCTAssertEqual(result, SampleOutputAqua().val)
    }

    func test_getNode_Celeste() async throws {
        let fnd = NodeDetailManager(network: .CELESTE)
        let result = try await fnd.getNodeDetails(verifier: "google", verifierID: "hello@tor.us")
        XCTAssertEqual(result, SampleOutputCeleste().val)
    }
    
    func test_getMetadata_Mainnet() async throws {
        let fnd = NodeDetailManager(network: .MAINNET)
        let result = try await fnd.getMetadataUrl()
        XCTAssertEqual(result, LEGACY_METADATA_MAP[.production])
    }
    
    func test_constants_match_fnd_web() {
        XCTAssertEqual(FND_SERVER_MAP[.production], "https://api.web3auth.io/fnd-service")
        XCTAssertEqual(FND_SERVER_MAP[.development], "https://api-develop.web3auth.io/fnd-service")
        XCTAssertEqual(CITADEL_SERVER_MAP[.production], "https://api.web3auth.io/citadel-service")
        XCTAssertEqual(DASHBOARD_PUBLIC_API_MAP[.production], "https://api.web3auth.io/signer-service")
        XCTAssertEqual(STORAGE_SERVER_MAP[.production], "https://api.web3auth.io/session-service")
        XCTAssertEqual(STORAGE_SERVER_SOCKET_URL_MAP[.development], "https://develop-session.web3auth.io")
        XCTAssertEqual(LEGACY_METADATA_MAP[.production], "https://api.web3auth.io/metadata-service")
        XCTAssertEqual(Web3AuthKeyType.secp256k1.rawValue, "secp256k1")
        XCTAssertEqual(Web3AuthSigType.ecdsaSecp256k1.rawValue, "ecdsa-secp256k1")
    }

    func test_getMetadata_Mainnet_development() async throws {
        let fnd = NodeDetailManager(network: .MAINNET, buildEnv: .development)
        let result = try await fnd.getMetadataUrl()
        XCTAssertEqual(result, LEGACY_METADATA_MAP[.development])
    }

    func test_getMetadata_SapphireMainnet() async throws {
        let fnd = NodeDetailManager(network: .SAPPHIRE_MAINNET)
        let result = try await fnd.getMetadataUrl()
        XCTAssertEqual(result, SampleOutputSAPPHIREMAINNET().val.getTorusNodeEndpoints()[0].replacingOccurrences(of: "/sss/jrpc", with: "/metadata"))
    }
}
