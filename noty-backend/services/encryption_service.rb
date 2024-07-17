# api/services/encryption_service.rb

module EncryptionService
  ALGORITHM = 'aes-256-cbc'

  def self.key
    Base64.decode64(ENV['ENCRYPTION_KEY'])
  end

  def self.encrypt(data)
    cipher = OpenSSL::Cipher.new(ALGORITHM)
    cipher.encrypt
    cipher.key = key
    iv = cipher.random_iv
    encrypted = cipher.update(data) + cipher.final
    Base64.encode64(iv + encrypted)
  end

  def self.decrypt(data)
    decoded_data = Base64.decode64(data)
    decipher = OpenSSL::Cipher.new(ALGORITHM)
    decipher.decrypt
    decipher.key = key
    decipher.iv = decoded_data[0..15] # Assuming 16 bytes IV
    decrypted = decipher.update(decoded_data[16..-1]) + decipher.final
    decrypted
  end
end
