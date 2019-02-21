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
                      var $pkuptime = ''+$("#pkuptimeop").val()
                      var $pkuptime_s = $pkuptime.substring(0,11).split('~');
                      var starttime = $pkuptime_s[0].split(':');

                      var comparetime = new Date($val3.getFullYear(), $val3.getMonth(), $val3.getDate(),
                                    parseInt(starttime[0]), parseInt(starttime[1]), 0, 0);

                      if(today> comparetime-3600000){
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

