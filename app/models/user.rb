class User < ActiveRecord::Base
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: {maximum: 100, minimum: 2}
    validates :email,   presence: true, length: {maximum: 255},
                        format: {with: /@/},
                        uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 8}
end
