class HomeController < ApplicationController  
  def new2
  end

  def main
  end

  def fileupload
    @upload = Upload.new
  end

  def filecheck
    @upload = Upload.new

    pagenum_o = params[:upload][:pagenum]
    @count = 0
    pagenum_c = pagenum_o.split(',')
    pagenum_c.each do |x|
      if x.include? "-"
        pagenum_d = x.split('-')
        @count = @count + (pagenum_d[1].to_i-pagenum_d[0].to_i+1) 
      else
        @count = @count +1
      end
    end
    @count = @count.to_i
  end

  end

  def filecreate
    @upload_c = Upload.new
    @upload.userid = current_user.id
    @upload.stdnum = current_user.stdnum
    @upload_c.progress = "인쇄대기"

    @upload_c.attachment = params[:upload_c][:attachment]
    @upload_c.printer = params[:upload_c][:printer]
    @upload_c.pagenum = params[:upload_c][:pagenum]
    @upload_c.totalpage = params[:upload_c][:totalpage]

    # pagenum_o = params[:upload_c][:pagenum]
    # count = 0
    # pagenum_c = pagenum_o.split(',') # ,에 대해서도  if x.include? "," 추가해주세용 '3'
    # pagenum_c.each do |x|
    #   if x.include? "-"
    #     pagenum_d = x.split('-')
    #     count = count + (pagenum_d[1].to_i-pagenum_d[0].to_i+1) 
    #   else
    #     count = count +1
    #   end
    # end
    # @upload_c.pagenum = count # pagenum은 string 형태 그대로 두고 count를 새로운 column에 저장해야 할 것 같아욤 (detail page에 필요)

    pkupdate = params[:upload_c][:pkupdate]
    @upload.totalpage = params[:upload][:pagenum]
    pagenum_o = @upload.totalpage
    count = 0
    pagenum_c = pagenum_o.split(',') # ,에 대해서도  if x.include? "," 추가해주세용 '3'
    pagenum_c.each do |x|
      if x.include? "-"
        pagenum_d = x.split('-')
        count = count + (pagenum_d[1].to_i-pagenum_d[0].to_i+1) 
      else
        count = count +1
      end
    end
    @upload.pagenum = count # pagenum은 string 형태 그대로 두고 count를 새로운 column에 저장해야 할 것 같아욤 (detail page에 필요)

    pkupdate = params[:upload][:pkupdate]
    if pkupdate == "오늘"
      pkupdate = Date.today
    else
      pkupdate = Date.today+1
    end
    @upload_c.pkupdate = pkupdate

    @upload_c.pkuptime = params[:upload_c][:pkuptime]
    @upload_c.landscape = params[:upload_c][:landscape]
    @upload_c.doublepg = params[:upload_c][:doublepg]
    @upload_c.split = params[:upload_c][:split]
    @upload_c.color = params[:upload_c][:color]
    @upload_c.save

    ## 유저 DB 갱신 (캐시 차감)

    redirect_to '/'
  end

  def filecurrent
    # @upload = Upload.find_by_userid(current_user.userid)
    uploads = Upload.all
    @ongoing_upload = []
    uploads.each do |upload|
      if upload.pkupdate < Date.today
        next

      elsif upload.pkupdate == Date.today
        pkuptime_s = upload.pkuptime.split('~')
        pkuptime_d = pkuptime_s[1].split(':')
        to_compare = Time.utc(upload.pkupdate.year, upload.pkupdate.month, upload.pkupdate.day,
          pkuptime_d[0].to_i, pkuptime_d[1].to_i, 0)
      
        if to_compare >= Time.now
          @ongoing_upload << upload
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

end
