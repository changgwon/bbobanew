	// Requires jQuery

	$(document).on('click','.js-menu_toggle.closed',function(e){
		e.preventDefault(); $('.list_load, .list_item').stop();
		$(this).removeClass('closed').addClass('opened');

		$('.side_menu').css({ 'left':'0px' });

		var count = $('.list_item').length;
		$('.list_load').slideDown( (count*.6)*100 );
		$('.list_item').each(function(i){
			var thisLI = $(this);
			timeOut = 100*i;
			setTimeout(function(){
				thisLI.css({
					'opacity':'1',
					'margin-left':'0'
				});
			},100*i);
		});

	});

	$(document).on('click','.js-menu_toggle.opened',function(e){
		e.preventDefault(); $('.list_load, .list_item').stop();
		$(this).removeClass('opened').addClass('closed');

		$('.side_menu').css({ 'left':'-250px' });

		var count = $('.list_item').length;
		$('.list_item').css({
			'opacity':'0',
			'margin-left':'-20px'
		});
		$('.list_load').slideUp(300);
	});

//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

jQuery(document).ready(function($){

      $(".check").click(function(){

            var time_check = function(){

                  var $val3 = $("#pkupdateop").val();

                  var msg = "";
                  var today = new Date();

                    if($val3=="오늘"){$val3=today;}
                    else{$val3=today+1;}

                    if ($val3 == today){
                      var $pkuptime = $("#pkuptimeop").val().split('~');
                      var starttime = $pkuptime[1].split(':');

                      var comparetime = new Date($val3.getFullYear(), $val3.getMonth(), $val3.getDate(),
                                    parseInt(starttime[0]), parseInt(starttime[1]), 0, 0);

                      if(comparetime<today){
                        msg+="신청 가능한 시간이 아닙니다!";
                      }
                    }
                    
                  return msg;                  
            }

            var timeerror = time_check();

            if (timeerror){
               alert(timeerror);
            }

            else{
                  if(animating) return false;
                  animating = true;
                  
                  current_fs = $(this).parent();
                  next_fs = $(this).parent().next();
                  
                  //activate next step on progressbar using the index of next_fs
                  $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
                  
                  //show the next fieldset
                  next_fs.show(); 
                  //hide the current fieldset with style
                  current_fs.animate({opacity: 0}, {
                        step: function(now, mx) {
                              //as the opacity of current_fs reduces to 0 - stored in "now"
                              //1. scale current_fs down to 80%
                              scale = 1 - (1 - now) * 0.2;
                              //2. bring next_fs from the right(50%)
                              left = (now * 50)+"%";
                              //3. increase opacity of next_fs to 1 as it moves in
                              opacity = 1 - now;
                              current_fs.css({
                    'transform': 'scale('+scale+')',
                    'position': 'absolute'
                  });
                              next_fs.css({'left': left, 'opacity': opacity});
                        }, 
                        duration: 800, 
                        complete: function(){
                              current_fs.hide();
                              animating = false;
                        }, 
                        //this comes from the custom easing plugin
                        easing: 'easeInOutBack'
                  });                  
            }            
      });

      $(".next").click(function(){
            
            if(animating) return false;
            animating = true;
            
            current_fs = $(this).parent();
            next_fs = $(this).parent().next();
            
            //activate next step on progressbar using the index of next_fs
            $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
            
            //show the next fieldset
            next_fs.show(); 
            //hide the current fieldset with style
            current_fs.animate({opacity: 0}, {
                  step: function(now, mx) {
                        //as the opacity of current_fs reduces to 0 - stored in "now"
                        //1. scale current_fs down to 80%
                        scale = 1 - (1 - now) * 0.2;
                        //2. bring next_fs from the right(50%)
                        left = (now * 50)+"%";
                        //3. increase opacity of next_fs to 1 as it moves in
                        opacity = 1 - now;
                        current_fs.css({
              'transform': 'scale('+scale+')',
              'position': 'absolute'
            });
                        next_fs.css({'left': left, 'opacity': opacity});
                  }, 
                  duration: 800, 
                  complete: function(){
                        current_fs.hide();
                        animating = false;
                  }, 
                  //this comes from the custom easing plugin
                  easing: 'easeInOutBack'
            });
      });

      $(".previous").click(function(){
            if(animating) return false;
            animating = true;
            
            current_fs = $(this).parent();
            previous_fs = $(this).parent().prev();
            
            //de-activate current step on progressbar
            $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
            
            //show the previous fieldset
            previous_fs.show(); 
            //hide the current fieldset with style
            current_fs.animate({opacity: 0}, {
                  step: function(now, mx) {
                        //as the opacity of current_fs reduces to 0 - stored in "now"
                        //1. scale previous_fs from 80% to 100%
                        scale = 0.8 + (1 - now) * 0.2;
                        //2. take current_fs to the right(50%) - from 0%
                        left = ((1-now) * 50)+"%";
                        //3. increase opacity of previous_fs to 1 as it moves in
                        opacity = 1 - now;
                        current_fs.css({'left': left});
                        previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
                  }, 
                  duration: 800, 
                  complete: function(){
                        current_fs.hide();
                        animating = false;
                  }, 
                  //this comes from the custom easing plugin
                  easing: 'easeInOutBack'
            });
      });

      //       $(".submit").click(function(){
      //             return false;
      // });
});

$(function(){function c(){p();var e=h();var r=0;var u=false;l.empty();while(!u){if(s[r]==e[0].weekday){u=true}else{l.append('<div class="blank"></div>');r++}}for(var c=0;c<42-r;c++){if(c>=e.length){l.append('<div class="blank"></div>')}else{var v=e[c].day;var m=g(new Date(t,n-1,v))?'<div class="today">':"<div>";l.append(m+""+v+"</div>")}}var y=o[n-1];a.css("background-color",y).find("h1").text(i[n-1]+" "+t);f.find("div").css("color",y);l.find(".today").css("background-color",y);d()}function h(){var e=[];for(var r=1;r<v(t,n)+1;r++){e.push({day:r,weekday:s[m(t,n,r)]})}return e}function p(){f.empty();for(var e=0;e<7;e++){f.append("<div>"+s[e].substring(0,3)+"</div>")}}function d(){var t;var n=$("#calendar").css("width",e+"px");n.find(t="#calendar_weekdays, #calendar_content").css("width",e+"px").find("div").css({width:e/7+"px",height:e/7+"px","line-height":e/7+"px"});n.find("#calendar_header").css({height:e*(1/7)+"px"}).find('i[class^="icon-chevron"]').css("line-height",e*(1/7)+"px")}function v(e,t){return(new Date(e,t,0)).getDate()}function m(e,t,n){return(new Date(e,t-1,n)).getDay()}function g(e){return y(new Date)==y(e)}function y(e){return e.getFullYear()+"/"+(e.getMonth()+1)+"/"+e.getDate()}function b(){var e=new Date;t=e.getFullYear();n=e.getMonth()+1}var e=480;var t=2013;var n=9;var r=[];var i=["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"];var s=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];var o=["#16a085","#1abc9c","#c0392b","#27ae60","#FF6860","#f39c12","#f1c40f","#e67e22","#2ecc71","#e74c3c","#d35400","#2c3e50"];var u=$("#calendar");var a=u.find("#calendar_header");var f=u.find("#calendar_weekdays");var l=u.find("#calendar_content");b();c();a.find('i[class^="icon-chevron"]').on("click",function(){var e=$(this);var r=function(e){n=e=="next"?n+1:n-1;if(n<1){n=12;t--}else if(n>12){n=1;t++}c()};if(e.attr("class").indexOf("left")!=-1){r("previous")}else{r("next")}})})