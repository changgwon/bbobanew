class PrinterController < ApplicationController
  	def index
		@todayuploads = []
    	Upload.all.each do |x|
	      	if (x.pkupdate == Date.today) && (x.progress == "인쇄대기" || x.progress == "인쇄중")
	        	@todayuploads << x
	      	end
    	end
	end
  
    def account
    end
end
