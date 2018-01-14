class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :password, presence: true, length: { minimum: 6 }

  has_many :favorites, dependent: :destroy
  has_many :pictures,  through: :favorites

# メールアドレスをDBに保存する直前に小文字にして、同じアドレスが登録されることを防ぐ
   before_save { email.downcase! }
   has_secure_password

end
