class User < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
  message: "Your email format is wrong" }
  validates :password, length: { minimum: 6 }


end
