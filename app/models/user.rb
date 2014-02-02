class User < ActiveRecord::Base

  has_secure_password
  attr_accessible :draws, :email, :last_name, :losses, :name, :role, :username, :wins, :ttt_ids, :password, :password_confirmation

  has_and_belongs_to_many :ttts

  before_validation :set_default_role

  #mount_uploader :image, RecipeImageUploader

  def set_default_role
    self.role ||= :user
  end

end
