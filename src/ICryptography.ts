type KeyIdentifier = number

export interface ICryptography {
	// ECDSA
	
	genKeyPair(): Promise<[KeyIdentifier, KeyIdentifier]>
	exportPublicKey(publicKey: KeyIdentifier): Promise<string>
	exportPrivateKey(privateKey: KeyIdentifier): Promise<string>
	importPublicKey(publicKey: string): Promise<KeyIdentifier>
	importPrivateKey(privateKey: string): Promise<KeyIdentifier>
	sign(privateKey: KeyIdentifier, data: string | object): Promise<string>
	verify(publicKey: KeyIdentifier, data: string | object, signature: string): Promise<boolean>
	
	// AES

	genAESKey(): Promise<KeyIdentifier>
	encrypt(key: KeyIdentifier, data: string | object): Promise<string>
	decrypt(key: KeyIdentifier, ciphertext: string): Promise<string | object>
	exportKey(key: KeyIdentifier): Promise<string>
	importKey(key: string): Promise<KeyIdentifier>
	forgetKey(key: KeyIdentifier): Promise<void>

	// PBKDF2 Passphrase key
	
	genEncryptedMasterKey(passphrase: string): Promise<KeyIdentifier>
	decryptMasterKey(passphrase: string, masterKey: KeyIdentifier): Promise<KeyIdentifier>
	updatePassphraseKey(passphrase: string, newPassphrase: string, masterKey: KeyIdentifier): Promise<void>
	exportMasterKey(masterKey: KeyIdentifier): Promise<string>
	importMasterKey(key: string): Promise<KeyIdentifier>

	// Hashing

	hashSHA1(data: string | object): Promise<string>
	hashSHA256(data: string | object): Promise<string>

	reset(): Promise<void>
}