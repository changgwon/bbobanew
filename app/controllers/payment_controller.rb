class PaymentController < ApplicationController
	def charge
		@user = current_user
	end

	def new
		@charge = Charge.new
	end
	def create
		charge = Charge.new
		charge.amount = params[:charge][:amount]
    	charge.user_id = current_user.id
    	charge.deposit = false
    	charge.save
    	# puts "*"*100
    	# puts current_user.id
    	# puts charge.errors.full_messages
    	# puts "*"*100
    	redirect_to '/'
	end
	def charge_show
		@charges=current_user.charges
	end

end
