import KeychainSwift

class KeychainService {
    static var shared: KeychainService = {
        return KeychainManager(keychain: KeychainSwift())
    }()
    private let keychain: KeychainSwift
    
    private init(keychain: KeychainSwift) {
        self.keychain = keychain
    }
    
    func get(_ key: String) -> String? {
        return keychain.get(key)
    }
    
    @discardableResult
    func set(_ value: String, key: String) -> Bool {
        return keychain.set(value, forKey: key)
    }
    
    @discardableResult
    func delete(_ key: String) -> Bool {
        return keychain.delete(key)
    }
    
    func clearKeychainOnFirstRun() {
        if !UserDefaults.standard.bool(forKey: "hasRunBefore") {
            keychain.clear()
            
            UserDefaults.standard.set(true, forKey: "hasRunBefore")
            UserDefaults.standard.synchronize()
        }
    }
}
