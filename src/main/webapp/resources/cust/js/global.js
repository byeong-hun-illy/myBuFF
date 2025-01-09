$(document).ready(function(){

    //header bor
    if($('.item_nav').length > 0){
        $('header').addClass('bor');
    }

    //header category
	$('.category').hover(function() {
        $('.ctg_box').fadeIn(200);
    }, function(){
        $('.ctg_box').fadeOut(200);
    });
    $(document).on('mouseenter','.depth1 > li', function (event) {
        $('.depth2').fadeOut(0);
        $(this).find('.depth2').fadeIn(0);
    }).on('mouseleave','.depth1',  function(){
        $('.depth2').fadeOut(200);
    });

    //header_down
    var didScroll;
	var lastScrollTop = 0;
	var delta = 5;
	var navbarHeight = $('header').outerHeight();
	$(window).scroll(function (event) {
		didScroll = true;
	});
	setInterval(function () {
		if (didScroll) {
			hasScrolled();
			didScroll = false;
		}
	}, 0);
	function hasScrolled() {
		var st = $(this).scrollTop();
		if (Math.abs(lastScrollTop - st) <= delta) return;
		if (st > lastScrollTop && st > navbarHeight) {
			$('header').removeClass('h_down').addClass('h_up');
            if($('.fix_tab').length > 0){
                $('.fix_tab').removeClass('h_down').addClass('h_up');
            }
		} else {
			if (st + $(window).height() < $(document).height()) {
				$('header').removeClass('h_up').addClass('h_down');
                if($('.fix_tab').length > 0){
                    $('.fix_tab').removeClass('h_up').addClass('h_down');
                }
			}
		}
		lastScrollTop = st;
	};

    //item_nav_sd
    var item_sd = new Swiper(".item_nav_sd",{
        slidesPerView:12,
		slidesPerGroup : 12,
        navigation:{
            prevEl: ".item_nav_wrap .prev",
            nextEl: ".item_nav_wrap .next",
        },
    });
	//item_sd.slideTo(12);

    function header_trp(){
        if($(window).scrollTop() > 100){
			$('header.trp').removeClass('active');
		}else if ($(window).scrollTop() < 100) {
			$('header.trp').addClass('active');
		}
    }
    header_trp();
    $(window).scroll(function (event) {
        header_trp();
	});

    //vis
    var vis_sd = new Swiper(".vis_sd",{
		loop:true,
		effect: "fade",
		pagination: {
			el: ".vis_cont .num",
			type: "fraction",
		},
		navigation:{
            prevEl: ".vis_cont .prev",
            nextEl: ".vis_cont .next",
        },
    });
	if($('.vis .swiper-slide:not(.swiper-slide-duplicate)').length > 9){
        $('.vis_cont').addClass('none');
    }

	//top_ban
    var top_ban = new Swiper(".top_ban_sd",{
		loop:true,
		pagination: {
			el: ".tb_cont .num",
			type: "fraction",
		},
		navigation:{
            prevEl: ".tb_cont .prev",
            nextEl: ".tb_cont .next",
        },
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
    });

    //share-copy
    $('.share_box .link a').click(function(){
        $('.link_copy').select();
        document.execCommand("copy");
        try{
            $(".common_pop .popup_txt").html("링크가 복사되었습니다");
            $(".common_pop").fadeIn(200);
    
            $(".common_pop .txt").html("링크가 복사되었습니다");
            popShow(".common_pop");
        } catch (error) {

        }

	});

    //agree_box
    $(".agree_box .all_chk label").click(function(){
        if ($(".agree_box .all_chk input").is(":checked")){
            $('.agree_box ul .chk_type input').prop('checked',true);
        } else {
            $('.agree_box ul .chk_type input').prop('checked',false);
        }
    });
    $(".agree_box .sms_agree .chk_type3 label").click(function(){
        if ($(".agree_box .sms_agree .chk_type3 input").is(":checked")){
            $('.agree_box .sms_agree .chk_type2 input').prop('checked',true);
        } else {
            $('.agree_box .sms_agree .chk_type2 input').prop('checked',false);
            $('.agree_box .all_chk label input').prop('checked',false);
        }
    });
    $(".agree_box .sms_agree .chk_type2 label").click(function(){
        if ($(".agree_box .sms_agree .chk_type2 input").is(":checked")){
            $('.agree_box .sms_agree .chk_type3 input').prop('checked',true);
        } else {
            $('.agree_box .sms_agree .chk_type3 input').prop('checked',false);
        }
    });
    $(".agree_box .chk_type2 label").click(function(){
        if ($(this).find('input').is(":checked") == false){
            $('.agree_box .all_chk label input').prop('checked',false);
        }
    });

    //faq_list
    $(".list_tab ._q").click(function(){
        $(this).closest('.line').next('._a').siblings('._a').find('.box').slideUp(200);
        $(this).closest('.line').siblings('.line').removeClass('open');
        $(this).closest('.line').toggleClass('open');
        $(this).closest('.line').next('._a').find('.box').slideToggle(200);
        return false
    });

    //picture
    var fileTarget = $('.file_box input');
    fileTarget.on('change', function(){
        var file_box = $(this).closest('.file_box');
        var fileCheck = $(this)[0].files;
        var reader = new FileReader();
        if(fileCheck.length < 1){
            $(file_box).css('background-color','transparent');
            $(file_box).css('background-image','url()');
        } else{
            reader.onload = function(event) {
                $(file_box).css('background-color','#fff');
                $(file_box).css('background-image','url('+event.target.result+')');
            };
        }
        reader.readAsDataURL(event.target.files[0]);
    });

    //rcd_code
    $('.rcd_code').click(function(){
        $('.rcd_code input').select();
        document.execCommand("copy");
	});

    //basket_pop
    $(document).on('click', '.amount .down', function(){
        var amount_down = $(this).next('span').text();
		if(amount_down<=1){
            $(this).addClass('disable');
        }
		/*
        if(amount_down>1){
            amount_down--;
            $(this).next('span').text(amount_down);
        }
		*/
	});
    $(document).on('click', '.amount .up', function(){
        $(this).siblings('.down').removeClass('disable');
		/*
        var amount_up = $(this).prev('span').text();
        amount_up++;
        $(this).prev('span').text(amount_up);
		*/
	});

    /*
    $(".popup .amount input").on("propertychange change keyup paste input", function() {
        let content = $(this).val();
        if (this.value.length > this.maxLength){
            this.value = this.value.slice(0, this.maxLength);
        } else {
            if (content.length == 0 || content == '') {
                $(".popup .amount input").css('width','14px');
            } else {
                $(".popup .amount input").css('width',(content.length-1)*10+14+'px');
            }
        }
    });
    */

    //tab_box
    $(document).on('click', '.tab_box ul li', function(){
        var idx = $(this).index();
        $('.tab_box ul li').removeClass('on');
        $(this).addClass('on');
        var con_box = $(this).closest('.tab_box').next('.con_box');
        $(con_box).children('li').removeClass('on')
        $(con_box).children('li').eq(idx).addClass('on');
	});
    //tab_box type1
    $(document).on('click', '.tab_box.type1 ul li', function(){
        var prevWidth = 0;
        $(this).prevAll().each(function(){prevWidth += $(this).outerWidth();});
        $(this).closest('.tab_box.type1').find('.line').css('left',prevWidth);
	});

    //rg_system
    var rg_system = new Swiper(".rg_system_sd",{
        effect: "fade",
        parallax: true,
        speed:500,
        pagination:{
            el:".rg_system .tab",
            clickable: true,
            renderBullet: function (index, className) {
				return '<div class="' + className + '">' + '<span class="tab'+index+'"></span>' + '</div>';
			}
        },
        navigation:{
            prevEl: ".rg_system .prev",
            nextEl: ".rg_system .next",
        },
        on: {
            slideChangeTransitionStart : function() {
                if($('.rg_system_sd .sd1').hasClass('swiper-slide-active')){
                    $('.rg_system').addClass('sd1');
                    $('.rg_system').removeClass('sd2');
                } else if($('.rg_system_sd .sd2').hasClass('swiper-slide-active')){
                    $('.rg_system').addClass('sd2');
                    $('.rg_system').removeClass('sd1');
                }
            },
        },
    });

    //share-copy
    $('.delivery_type ul li').click(function(){
        $(this).addClass('on');
        $(this).siblings('li').removeClass('on');
		it_subs = $(this).attr("data");	
        price_calculate(); //합계금액 다시계산	
	});

    //calendar_pop
    $(document).on('click', '.delivery_type .sel_area .date', function(){
        $('.calendar_pop').fadeIn(200);
	});

    $(document).on('click', '#ct_delivery_day_thank_sam', function(){
        $('.calendar_pop_thank_sam').fadeIn(200);
	});

    $(document).on('click', '.shopping_cart .eco_d .date', function(){
        $('.calendar_pop.rd').fadeIn(200);
	});
    $(document).on('click', '.shopping_cart .eco_pd .date', function(){
        $('.calendar_pop.prd').fadeIn(200);
	});
    var calendar_pop = new Swiper(".calendar_pop .tbl",{
        effect:'fade',
        speed:0,
        parallax: true,
        touchRatio: 0,
        observer: true,
        observeParents: true,
        navigation:{
            prevEl: ".calendar_pop .prev",
            nextEl: ".calendar_pop .next",
        },
		on: {
            slideChangeTransitionEnd : function() {
				//console.log(calendar_pop.realIndex+'번 슬라이드');
				//console.log($("#calendar_table_" + calendar_pop.realIndex).find(".daterow").first().attr("data-month"));
				let setYear = $("#calendar_table_" + calendar_pop.realIndex).find(".daterow").first().attr("data-year");
				let setMonth = $("#calendar_table_" + calendar_pop.realIndex).find(".daterow").first().attr("data-month");
				$("#pop_year").html(setYear);
				$("#pop_month").html(setMonth);				
            },
        },
    });
    $(document).on('click', '.calendar_pop .tbl .on', function(){
        $(this).closest('table').find('td').removeClass('active');
        $(this).addClass('active');
	});

    var calendar_pop_thank_sam = new Swiper(".calendar_pop_thank_sam .tbl",{
        effect:'fade',
        speed:0,
        parallax: true,
        touchRatio: 0,
        observer: true,
        observeParents: true,
        navigation:{
            prevEl: ".calendar_pop_thank_sam .prev",
            nextEl: ".calendar_pop_thank_sam .next",
        },
		on: {
            slideChangeTransitionEnd : function() {
				//console.log(calendar_pop.realIndex+'번 슬라이드');
				//console.log($("#calendar_table_" + calendar_pop.realIndex).find(".daterow").first().attr("data-month"));
				let setYear = $("#calendar_thank_sam_table_" + calendar_pop_thank_sam.realIndex).find(".daterow").first().attr("data-year");
				let setMonth = $("#calendar_thank_sam_table_" + calendar_pop_thank_sam.realIndex).find(".daterow").first().attr("data-month");
				$("#pop_thank_sam_year").html(setYear);
				$("#pop_thank_sam_month").html(setMonth);
            },
        },
    });

    $(document).on('click', '.calendar_pop_thank_sam .tbl .on', function(){
        $(this).closest('table').find('td').removeClass('active');
        $(this).addClass('active');
	});

    //rc_btn
    $(document).on('click', '.rc_btn', function(){
        $(this).toggleClass('on');
	});

    //review more
    $(document).on('click', '.review .more', function(){
        $(this).closest('tr').toggleClass('unfold');
	});
    $(document).on('click', '.review .reply .more_reply', function(){
        $(this).closest('.reply').toggleClass('reply_unfold');
	});
		

    //fix_area
    if($('.fix_tab').length > 0){
        function fix_tab() {
            if($(window).scrollTop() + 200 < $('.con .fix_area2').offset().top){
                $('.fix_tab li').removeClass('on');
                $('.fix_tab .fix_area1').addClass('on');
            } else if($(window).scrollTop() + 200 < $('.con .fix_area3').offset().top){
                $('.fix_tab li').removeClass('on');
                $('.fix_tab .fix_area2').addClass('on');
            } else if($(window).scrollTop() + 200 < $('.con .fix_area4').offset().top){
                $('.fix_tab li').removeClass('on');
                $('.fix_tab .fix_area3').addClass('on');
            } else if($(window).scrollTop() + 200 > $('.con .fix_area4').offset().top){
                $('.fix_tab li').removeClass('on');
                $('.fix_tab .fix_area4').addClass('on');
            }
        }
        fix_tab();
        $(window).scroll(function (event) {
            fix_tab();
        });
    }
    $(document).on('click', '.fix_tab li', function(){
        var fix_class = $(this).attr('date-area');
        $("html, body").animate({
            scrollTop : $('.item_detail .con').find('.'+fix_class).offset().top - 190
        }, 300);
	});

    //sel_area_box
    $('.sel_area_box').each( function() {
        var sel_defult = $(this).find('select option:checked').text();
        $(this).find('.sel_type1').text(sel_defult);
    });
    $(document).on('click', '.sel_area_box .op_box .option', function(){
        var sel_idx = $(this).index();
        var sel_txt = $(this).text();
        $(this).closest('.sel_area_box').find('.sel_type1').text(sel_txt);    	
        $(this).closest('.sel_area_box').find("select option:eq("+sel_idx+")").prop("selected", true).change();
        $(this).closest('.op_box').slideUp(200);
		$(this).siblings('.option').removeClass('sel');
		$(this).addClass('sel');
	});
    $(document).on('click', '.sel_area_box .sel_type1', function(){
		var this_ob = $(this).next('.op_box');
        $('.op_box').not(this_ob).slideUp(200);
        $(this).next('.op_box').slideToggle(200);
	});
	$('html').click(function(e) {   
		if($(e.target).parents('.sel_area_box').length < 1 && !$(e.target).hasClass('sel_type1')){   
			$('.op_box').slideUp(200);
		}
	});

	//coupon_sel
	if($('.option_sel').length > 0){
		$('.delivery .total').addClass('t2');
	}
	var coupon_sel_length = $('.coupon_sel select option').length;
	for(var i=0; i<coupon_sel_length;i++){
		$('.coupon_sel .op_box').append('<div class="option" data-value=""></div>');
	}
	$('.coupon_sel select option').each( function() {
		var cs_idx = $(this).index();
		var cs_text = $(this).text();
		var cs_value = $(this).attr('value');
		$('.coupon_sel .op_box .option').eq(cs_idx).text(cs_text);
		$('.coupon_sel .op_box .option').eq(cs_idx).attr('data-value',cs_value);
    });
	$(document).on('click', '#od_coupon_cancel', function(){
		$('.coupon_sel .sel_type1').eq(0).text('쿠폰을 선택해주세요.');
	});

	//option_sel
	$('.option_sel select').each( function() {
		var option_sel_length = $(this).find('option').length;

		for(var i=0; i<option_sel_length;i++){
			$(this).prev('.op_box').append('<div class="option" data-value=""></div>');
		}
		$(this).find('option').each( function() {
			var cs_idx = $(this).index();
			var cs_text = $(this).text();
			var cs_value = $(this).attr('value');
			$(this).closest('.sel_area_box').find('.option').eq(cs_idx).text(cs_text);
			$(this).closest('.sel_area_box').find('.option').eq(cs_idx).attr('data-value',cs_value);
		});
	});

    //ec_pop
    $(document).on('click', '.sel_area_box .op_box .option', function(){
        if($(this).is('.ec_pop')){
            $('.popup.eco_collect').fadeIn(300);
        }
	});

    //order_list
	if ( $(".order_list ul li").length < 2 ){
		$('.order_list').addClass('one');
	} else {
		$(document).on('click', '.order_sheet .order_list .list_btn', function(){
			$(this).closest('.order_list').toggleClass('open');
			$(this).closest('.order_list').find('ul').slideToggle(200);
		});
	}

    //pay_btn
    $(document).on('click', '.order_sheet .pay li', function(){
        $(this).siblings('li').removeClass('on');
        $(this).addClass('on');
	});

    //address pop
    $(document).on('click', '.popup .address_list li', function(){
        $(this).siblings('li').removeClass('on');
        $(this).addClass('on');
	});

    //r_v_sd
	let options2 = {};
	if ( $(".r_v_sd .swiper-slide").length <= 1 ){
		$('.r_v_sd').css('height','60px');
		options2 = {
			direction: "vertical",
			spaceBetween: 5,
			slidesPerView: 1,
			navigation:{
			    prevEl: ".fix_ban_cen .r_v .up",
			    nextEl: ".fix_ban_cen .r_v .down",
			},
        }
	} else if ( $(".r_v_sd .swiper-slide").length == 2 ){
		$('.r_v_sd').css('height','125px');
		options2 = {
			direction: "vertical",
			spaceBetween: 5,
			slidesPerView: 2,
			navigation:{
			    prevEl: ".fix_ban_cen .r_v .up",
			    nextEl: ".fix_ban_cen .r_v .down",
			},
		}
	} else if ( $(".r_v_sd .swiper-slide").length >= 3 ){
		$('.r_v_sd').css('height','190px');
		options2 = {
			direction: "vertical",
			spaceBetween: 5,
			slidesPerView: 3,
			navigation:{
			    prevEl: ".fix_ban_cen .r_v .up",
			    nextEl: ".fix_ban_cen .r_v .down",
			},
		}
	}
	var r_v_sd = new Swiper('.r_v_sd', options2);

    //event
    $('.__roulette').addClass('on');
    $('.__stamp').addClass('on');

    //imeco_sd
    var imeco_sd = new Swiper(".imeco_sd",{
        spaceBetween: 10,
        slidesPerView: 3,
        loop:true,
		speed:800,
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
    });

	//mo
    function mo_active() {
        $('.mo').each(function (index, item) {
            if($(window).scrollTop() > $(this).offset().top - $(window).height() * 0.7){
                $(this).addClass('active');
            }
        });
    }
    $(window).scroll(function (event) {
        if($('.mo').offset()){
		    mo_active();
        }
	});
    mo_active();

	//list_badge
	$('.list_badge').each( function() {
		if($(this).find('p').length < 1){
			$(this).addClass('none');
		}
	});
	$('.list_badge.type2 p').each( function() {
		if($(this).html() == ""){
			$(this).closest('.list_badge.type2').addClass('none');
		}
	});

	//imeco1
	if($('.imeco1').offset()){
		var ct = true;
		$('.imeco1').addClass('open');
		setTimeout(function() {
			$('.imeco1').addClass('done');
			if($(window).scrollTop() > $('.imeco1 .rig_txt').offset().top - $(window).height() * 0.7 && ct == true){
				ct = false;
		        $('.imeco1 .counter').counterUp({
					delay: 10,
					time: 4000
				});
		    }
		}, 600);
	}

	//counter
	function counter() {
        if($(window).scrollTop() > $('.imeco1 .rig_txt').offset().top - $(window).height() * 0.7 && ct == true && $('.imeco1').hasClass('done')){
			ct = false;
            $('.imeco1 .counter').counterUp({
				delay: 40,
				time: 2000
			});
        }
    }
    $(window).scroll(function (event) {
        if($('.counter').offset()){
		    counter();
        }
	});
    if($('.counter').offset()){
		counter();
    }

	function snow_bg(){
		$('.snow_bg').css({'backgroundPosition':'50% '+ (-1 * ($(window).scrollTop()/3))+'px'});
	}
	$(window).scroll(function (event) {
        if($('.snow').offset()){
		    snow_bg();
        }
	});
	if($('.snow').offset()){
		snow_bg();
    }

});