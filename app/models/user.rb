class User < ApplicationRecord
  before_destroy :prevent_no_admin
	has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy
  has_many :task_labels
	has_secure_password
	before_validation { email.downcase! }
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, length: {minimum: 6}

  private
	def prevent_no_admin
		if User.where(is_admin: true).count == 1 && self.is_admin == true
			throw(:abort)
		end
	end
end
