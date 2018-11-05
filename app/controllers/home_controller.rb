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

  end
  def filecreate
    @upload = Upload.new
    # @upload.userid = current_user.id
    # @upload.stdnum = current_user.stdnum

    @upload.userid = "aa"
    @upload.stdnum = 1
    @upload.progress = "인쇄대기"

    @upload.attachment = params[:upload][:attachment]
    @upload.printer = params[:upload][:printer]

    pagenum_o = params[:upload][:pagenum]
    count = 0
    pagenum_c = pagenum_o.split(',')
    pagenum_c.each do |x|
      if x.include? "-"
        pagenum_d = x.split('-')
        count = count + (pagenum_d[1].to_i-pagenum_d[0].to_i+1) 
      else
        count = count +1
      end
    end
    @upload.pagenum = count

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
end
