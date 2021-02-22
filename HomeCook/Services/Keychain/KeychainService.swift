import KeychainSwift

class KeychainService {
    static var shared: KeychainService = {
        return KeychainManager(keychain: KeychainSwift())
    }()
    private let keychain: KeychainSwift
    
    private init(keychain: KeychainSwift) {
        self.keychain = keychain
    }
    
    func get(_ key: KeychainKey) -> String? {
            return keychain.get(key.name)
    }
    
    @discardableResult
    func set(_ value: String, key: KeychainKey) -> Bool {
            return keychain.set(value, forKey: key.name)
    }
    
    @discardableResult
    func delete(_ key: KeychainKey) -> Bool {
        return keychain.delete(key.name)
    }
}
