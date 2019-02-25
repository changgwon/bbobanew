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
    	redirect_to '/payment/charge_show'
	end
	def charge_show
		@charges=current_user.charges.reverse
		@charges=Kaminari.paginate_array(@charges).page(params[:page]).per(2)

	end
	def charge_delete
		charge = Charge.find(params[:charge_id])
		if (charge.user==current_user)
		   charge.delete
		end
		redirect_back(fallback_location: root_path)
	end

	def cashflow
		@cashflows=current_user.cashflows
		@cashflows=@cashflows.reverse
		@cashflows=Kaminari.paginate_array(@cashflows).page(params[:page]).per(5)
		
	end

end
