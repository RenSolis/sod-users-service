class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def to_json
    super(except: :password)
  end
end
