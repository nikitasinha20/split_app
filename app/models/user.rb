class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  # has_many :payers, class_name: "User", foreign_key: "payee_id"
  # belongs_to :payee, class_name: "User"

  # Authenticating User while login process
  def self.authenticate email = "", password = ""
    user = User.find_by_email(email)
    if user && user.password.eql?(password)
      return user
    else
      return false
    end
  end
 
  # Calculating amount to be paid or accepted for the users
  # Can also be implemented using self join association for User
  def self.balance current_user , user, group
  	pay=0; get=0
  	group.bills.each do |bill|
  		individual_amt = Bill.split bill.amount, group.id
  		if bill.paid_by.eql?(user.id)
  			pay += individual_amt
  		elsif bill.paid_by.eql?(current_user.id)
  			get += individual_amt
 		end
 	end

    if pay > get
    	value = "Pay: " + (pay-get).to_s
    else
    	value = "Get: " + (get-pay).to_s
    end
  	return value
  end

end






























