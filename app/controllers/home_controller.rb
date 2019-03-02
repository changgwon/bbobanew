class HomeController < ApplicationController  
  def new2
  end

  def main
    #count 를 위한 비효율적인 코드
    @uploads = Upload.where(userid:current_user.userid)
    @ongoing_upload = []
    @past_upload = []
    @uploads.each do |upload|
      if upload.progress != "인쇄취소"
        if upload.pkupdate < Date.today
          @past_upload << upload

        elsif upload.pkupdate == Date.today
          if upload.pkuptime != "canceled"
            pkuptime_s = upload.pkuptime.split('~')
            pkuptime_d = pkuptime_s[1].split(':')
            to_compare = Time.utc(upload.pkupdate.year, upload.pkupdate.month, upload.pkupdate.day,
                                  pkuptime_d[0].to_i, pkuptime_d[1].to_i, 0)
          
            if to_compare >= Time.now
              @ongoing_upload << upload
            
            elsif to_compare < Time.now
              upload.category = "past"
              @ongoing_upload << upload
            # else
            #   @past_upload << upload
            end
          end
        else
          @ongoing_upload << upload
        end
      else
        @past_upload << upload
      end
    end
    @count=@ongoing_upload.count

  end

  def fileupload
    uploads = Upload.all
    @count1 = 0
    @count2 = 0
    @count3 = 0
    @count4 = 0 
    @count5 = 0
    @count6 = 0
    @count7 = 0
    @count8 = 0
    @count9 = 0 
    @count10 = 0

    uploads.each do |x|
      if x.pkupdate == Date.today
        if x.pkuptime == "10:15~10:30"
          @count1+=1
        elsif x.pkuptime == "11:45~12:00"
          @count2+=1
        elsif x.pkuptime == "13:15~13:30"
          @count3+=1
        elsif x.pkuptime == "14:45~15:00"
          @count4+=1
        elsif x.pkuptime == "16:15~16:30"
          @count5+=1
        end
      else
        if x.pkuptime == "10:15~10:30"
          @count6+=1
        elsif x.pkuptime == "11:45~12:00"
          @count7+=1
        elsif x.pkuptime == "13:15~13:30"
          @count8+=1
        elsif x.pkuptime == "14:45~15:00"
          @count9+=1
        elsif x.pkuptime == "16:15~16:30"
          @count10+=1
        end
      end
    end

    @upload = Upload.new
  end

  def filecheck
    @upload = Upload.new
    pagenum_o = params[:upload][:pagenum]
    @count = 0
    pagenum_c = pagenum_o.split(',') # ,에 대해서도  if x.include? "," 추가해주세용 '3'
    pagenum_c.each do |x|
      if x.include? "-"
        pagenum_d = x.split('-')
        @count = @count + (pagenum_d[1].to_i-pagenum_d[0].to_i+1) 
      else
        @count = @count +1
      end
    end
    if params[:upload][:split].to_i % 2 == 0
      @count = @count / params[:upload][:split].to_i
    else
      @count = @count / params[:upload][:split].to_i + 1
    end

  end
  def filecreate
    @upload = Upload.new
    @upload.userid = current_user.userid
    @upload.user_id = current_user.id
    @upload.stdnum = current_user.stdnum
    @upload.progress = "인쇄대기"

    @upload.attachment = params[:upload][:attachment]
    @upload.printer = params[:upload][:printer]
    @upload.pagenum = params[:upload][:pagenum]

    pagenum_o = params[:upload][:pagenum]
    @count = 0
    pagenum_c = pagenum_o.split(',') # ,에 대해서도  if x.include? "," 추가해주세용 '3'
    pagenum_c.each do |x|
      if x.include? "-"
        pagenum_d = x.split('-')
        @count = @count + (pagenum_d[1].to_i-pagenum_d[0].to_i+1) 
      else
        @count = @count +1
      end
    end
    if @count % params[:upload][:split].to_i  == 0
      @count = @count / params[:upload][:split].to_i
    else
     @count = (@count / params[:upload][:split].to_i) + 1
    end

    @upload.totalpage = @count # pagenum은 string 형태 그대로 두고 count를 새로운 column에 저장해야 할 것 같아욤 (detail page에 필요)

    pkupdate = params[:upload][:pkupdate]
    if pkupdate == "오늘"
      pkupdate = Date.today
    else
      pkupdate = Date.today+1
    end
    @upload.pkupdate = pkupdate

    @upload.pkuptime = params[:upload][:pkuptime]
    @upload.landscape = params[:upload][:landscape]
    @upload.doublepg = params[:upload][:doublepg]
    @upload.split = params[:upload][:split]
    @upload.color = params[:upload][:color]

    if @upload.color == "컬러" 
      @upload.cost = @count * 200
    else
      @upload.cost = @count * 50
    end


    ## 유저 DB 갱신 (캐시 차감)
    @user = current_user
    if @user.cur_cash <  @upload.cost
      @upload.flag = false
    else

      chkcount = 0
      Upload.all.each do |x|
        if x.pkuptime == @upload.pkuptime
          chkcount +=1
        end
      end

      if chkcount <= 30
        @upload.save
        @user.cur_cash -=  @upload.cost
        @user.save
        cashflow=Cashflow.new
        cashflow.cur_cash=current_user.cur_cash
        cashflow.user_id=@upload.user_id
        cashflow.real_created_at = @upload.created_at
        cashflow.amount = @upload.cost
        cashflow.use_type = "차감"
        cashflow.save
      else

      end
    
    end
    


    redirect_to '/home/main'
  end

  def ownerpage_tomo
    if current_user.usertype == "user"
      redirect_to "/home/main"
    end
    @todayuploads = []
    @tomorrowuploads = []
    Upload.all.each do |x|
      if x.pkupdate == Date.today
        @todayuploads << x
      elsif x.pkupdate > Date.today
        @tomorrowuploads << x
      end
    end
    @today = Date.today;
  end

  def filecurrent
    @uploads = Upload.where(userid:current_user.userid)
    @ongoing_upload = []
    @past_upload = []
    @uploads.each do |upload|
      if upload.progress != "인쇄취소"
        if upload.pkupdate < Date.today
          @past_upload << upload

        elsif upload.pkupdate == Date.today

          if upload.pkuptime != "canceled"
            pkuptime_s = upload.pkuptime.split('~')
            pkuptime_d = pkuptime_s[1].split(':')
            to_compare = Time.utc(upload.pkupdate.year, upload.pkupdate.month, upload.pkupdate.day,
                                  pkuptime_d[0].to_i, pkuptime_d[1].to_i, 0)
            if to_compare >= Time.now
              @ongoing_upload << upload
            
            elsif to_compare < Time.now
              upload.category = "past"
              @ongoing_upload << upload
            # else
            #   @past_upload << upload
            end
          end
        else
          @ongoing_upload << upload
        end
      else
        @past_upload << upload
      end
    end

    @ongoing_upload =@ongoing_upload.sort_by{|upload| [upload.pkupdate, upload.pkuptime]}
    @ongoing_upload =Kaminari.paginate_array(@ongoing_upload).page(params[:page]).per(3)
    @past_upload =@past_upload.sort_by{|upload| [upload.pkupdate]}.reverse
    @past_upload =Kaminari.paginate_array(@past_upload).page(params[:page]).per(3)
  end

  def ownerpage
    if current_user.usertype == "user"
      redirect_to "/home/main"
    end
    @todayuploads = []
    @tomorrowuploads = []
    Upload.all.each do |x|
      if x.pkupdate == Date.today
        @todayuploads << x
      elsif x.pkupdate > Date.today
        @tomorrowuploads << x
      end
    end

    @tomorrow = Date.today+1;
  end

  def changeState1
    if current_user.usertype == "admin"
      upload = Upload.find(params[:id])
      upload.progress = "인쇄중"
      upload.save
    end
    # redirect_to home_ownerpage_path
    redirect_back(fallback_location: home_ownerpage_path)
  end

  def changeState2
      upload = Upload.find(params[:id])
      if current_user.usertype == "admin" && upload.progress != "인쇄취소"
      
      upload.progress = "인쇄취소"
      refund = upload.totalpage * 50

      # 환불!!!!
      user = upload.user
      user.cur_cash = (user.cur_cash + refund)
      user.save

      cashflow=Cashflow.new
      cashflow.user_id=upload.user_id
      cashflow.real_created_at = upload.created_at
      cashflow.amount = upload.cost
      cashflow.cur_cash=current_user.cur_cash
      cashflow.use_type = "인쇄취소"

      cashflow.save
      upload.save

    end
    # redirect_to home_ownerpage_path
    redirect_back(fallback_location: home_ownerpage_path)
  end

  def changeState3
    if current_user.usertype == "admin"
      upload = Upload.find(params[:id])
      upload.progress = "인쇄완료"
      upload.save
    end 

    # redirect_to home_ownerpage_path
    redirect_back(fallback_location: home_ownerpage_path)
  end

  def changeState4
    if current_user.usertype == "admin"
      upload = Upload.find(params[:id])
      upload.progress = "인쇄대기"
      upload.save
    end

    redirect_back(fallback_location: home_ownerpage_path)
  end

  def usercancel
    upload = Upload.find(params[:id])
    if upload.user==current_user && upload.progress != "인쇄취소" 
      
      upload.progress = "인쇄취소"
      upload.pkuptime = "canceled"
      refund=upload.totalpage * 50 

      # 환불!!!!
      user = current_user

      user.cur_cash = (user.cur_cash + refund)
      user.save
      upload.save
    end
    redirect_to "/home/filecurrent"

  end

  def index
    if user_signed_in?
      if current_user.usertype == "admin"
        redirect_to "/home/ownerpage"
      else
        redirect_to "/home/main"
      end
    else
      redirect_to "/users/sign_in"
    end
  end

  def filedetail
    @upload = Upload.find(params[:id])
  end

  def filehistory
    @upload = Upload.all
    @user = current_user.cur_cash
  end

  def category
  end
end