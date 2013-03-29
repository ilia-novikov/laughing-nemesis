require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation, :options

  validates :name, :presence => true,
            :length => {:maximum => 50}
  validates :email, :presence => true,
            :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true,
            :confirmation => true,
            :length => {:within => 8..40}

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def get_role
    role
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def get_option (key)
    unless options.nil?
      options_hash = {}
      options.split(',').each { |elem| options_hash[elem.split('=')[0]] = elem.split('=')[1] }
      if options_hash.include?(key)
        options_hash[key]
      end
    end
  end

  def set_option (key, value)
    if options.nil?
      options = "#{key}=#{value}"
      update_attribute('options', options)
    else
      options_hash = {}
      options.split(',').each { |elem| options_hash[elem.split('=')[0]] = elem.split('=')[1] }
      options_hash[key] = value
      options = options.map { |k, v| "#{k}=#{v}" }.join(',')
      update_attribute('options', options)
    end
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
