class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :bills

  $list = Hash.new

  # partial implementation of invite functionality
  def self.invite group_id, email
    # send mail using an Action Mailer class
    $list.store(email, group_id)
  end

end
