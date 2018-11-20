class HomeController < ApplicationController  
  def new2
  end

  def main
    @upload = Upload.new
  end

  def fileupload
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
    if params[:upload][:split].to_i % 2 == 0
      @count = @count / params[:upload][:split].to_i
    else
      @count = @count / params[:upload][:split].to_i + 1
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
    @upload.save

    ## 유저 DB 갱신 (캐시 차감)

    redirect_to '/'
  end

  def filecurrent
    @uploads = Upload.where(userid:current_user.userid)
    @ongoing_upload = []
    @past_upload = []
    @uploads.each do |upload|
      if upload.pkupdate < Date.today
        @past_upload << upload

      elsif upload.pkupdate == Date.today
        pkuptime_s = upload.pkuptime.split('~')
        pkuptime_d = pkuptime_s[1].split(':')
        to_compare = Time.utc(upload.pkupdate.year, upload.pkupdate.month, upload.pkupdate.day,
                              pkuptime_d[0].to_i, pkuptime_d[1].to_i, 0)
      
        if to_compare >= Time.now
          @ongoing_upload << upload
        else
          @past_upload << upload
        end
      
      else
        @ongoing_upload << upload
      end

    end
  end

  def ownerpage
    @todayuploads = []
    Upload.all.each do |x|
      if x.pkupdate == Date.today
        @todayuploads << x
      end
    end
  end

  def changeState
    upload = Upload.find(params[:id])
    upload.progress = "인쇄완료"
    upload.save

    # redirect_to home_ownerpage_path
    redirect_back(fallback_location: home_ownerpage_path)
  end

  def index
    if user_signed_in?
      redirect_to "/home/main"
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

end
