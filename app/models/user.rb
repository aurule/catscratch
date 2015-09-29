class User < ActiveRecord::Base
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: {maximum: 100, minimum: 2}
    validates :email,   presence: true, length: {maximum: 255},
                        format: {with: /@/},
                        uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 8}

    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end
end
