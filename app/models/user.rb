class User < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :email, uniqueness: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
  message: "Your email format is wrong" }
  validates :password, length: { minimum: 6 }

  before_create :encrypt_password

  private

  def encrypt_password
    self.password = change(password)
  end

  def change(str)
    Digest::SHA1.hexdigest(str)
  end
end
