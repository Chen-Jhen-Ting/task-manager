class User < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
  message: "Your email format is wrong" }
  validates :password, length: { minimum: 6 }

  before_create :encrypt_password

  def self.login(options)
    if options[:email] && options[:password]
      find_by(email: options[:email],
              password: Digest::SHA1.hexdigest(options[:password]))
    end
  end

  private

  def encrypt_password
    self.password = change(password)
  end

  def change(str)
    Digest::SHA1.hexdigest(str)
  end
end
