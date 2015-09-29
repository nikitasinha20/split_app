class Bill < ActiveRecord::Base
   belongs_to :groups, dependent: :destroy

  # splits the bill for individual user 
  def self.split amount, group_id
    user_count = Group.find(group_id).users.count
    return amount/user_count
  end

end
