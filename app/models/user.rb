class User < ActiveRecord::Base

  has_secure_password
  attr_accessible :draws, :email, :last_name, :losses, :name, :role, :username, :wins, :ttt_ids, :password, :password_confirmation

  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_and_belongs_to_many :ttts

  before_validation :set_default_role

  #mount_uploader :image, RecipeImageUploader

  def set_default_role
    self.role ||= :user
  end

  def self.get_user(id)
    user = User.find_by_id(id)
  end

  def init_user
    self.wins = 0
    self.draws = 0
    self.losses = 0
  end

  # def update_record(id1, id2, key)
  #   unless id1 == -1  do
  #     User.find_by_id(id1)[key.to_sym] += 1
  #   end

  #   unless id2 == -1  do
  #     User.find_by_id(id2)[key.to_sym] += 1
  #   end
  # end

end
