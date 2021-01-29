var ui = {};

/*검색결과 영역이 접혀 있을 시 열기*/
ui.toggleSearchList = function(){
    var toggleIcon = $('#_searchToggleIcon');
    if (toggleIcon.hasClass('fa-chevron-down')) {
        toggleIcon.click();
    }
}

/*검색결과에 따라 선택삭제 or excel 버튼 컨트롤*/
ui.toogleSearchListFooter = function(searchCnt){
    var target = $("#_searchToggleIcon").closest('.widget').find('.widget-footer');
    0 < searchCnt ? target.show() : target.hide();
}

/*인포렉스 메뉴를 클릭 했을 시*/
ui.loadInforexAdminPage = function(menu, historyBack){

    if(!historyBack){
        ui.saveHistory(menu);
    }

    //left menu
    var marginLeft = 240;

    //iframe 세팅
    var html = '<iframe src="'+$(menu).data('url')+'" style="';
        html += 'width: ' + ($("#main-content-wrapper").width() - marginLeft) + 'px;';
        html += 'margin-left: ' + marginLeft + 'px;';
        html += 'height: ' + ($("#left-sidebar").height() - 40) + 'px;';
        html += 'border: 0px;">';
        html += '</iframe>';

    $('#main-content-wrapper').empty().append(html);

    //이전 메뉴 비활성화/ 클릭한 메뉴 활성화 처리
    $('ul.sub-menu li.active, .main-menu li.page.active').removeClass('active');
    $(menu).parent().addClass('active');
}

ui.loadBaseAdminPage = function(menu, historyBack){

    var url = $(menu).data('url');
    if(url == ''){
        return false;
    }

    if(!historyBack){
        ui.saveHistory(menu);
    }

    /*if(!0 == url.indexOf("http")){
        url = ADMIN_SERVER_URL + $(menu).data('url');
    }*/

    //left menu
    var marginLeft = 210;

    //iframe 세팅
    var html = '<iframe src="'+$(menu).data('url')+'" onload="ui.iframeBodyAutoResize(this)" style="';
    html += 'width: ' + ($("#main-content-wrapper").width() - marginLeft) + 'px;';
    html += 'margin-left: ' + marginLeft + 'px;';
    html += 'height: ' + ($("#left-sidebar").height() - 40) + 'px;';
    html += 'border: 0px;" id="iframePageContent">';
    html += '</iframe>';

    $('#main-content-wrapper').empty().append(html);

    //이전 메뉴 비활성화/ 클릭한 메뉴 활성화 처리
    $('ul.sub-menu li.active, .main-menu li.page.active').removeClass('active');
    $(menu).parent().addClass('active');
}

ui.saveHistory = function(menu){

    var url = $(menu).data('url');
    var menuArr = (history.state == null || history.state.menuArr == null) ? [] : history.state.menuArr;

    menuArr.push($(menu).data('url'));
    history.pushState({menuArr: menuArr}, $(menu).find('span').text(), '?menuUrl='+$(menu).data('url'));
}

ui.iframeBodyAutoResize = function(iframe){

    var the_height= document.getElementById('iframePageContent').contentWindow.document.body.scrollHeight + 1000;

    //change the height of the iframe
    document.getElementById('iframePageContent').height= the_height;

    //document.getElementById('the_iframe').scrolling = "no";
    document.getElementById('iframePageContent').style.overflow = "hidden";

}

ui.topScroll = function(){
    //window.scrollTo(0,0);
    $('html').animate({scrollTop : 0}, 100);
}

ui.bottomScroll = function(){
    $('html').animate({scrollTop : $(document).height()}, 100);
}

ui.targetScroll = function(element){
    $('html').animate({scrollTop : element.offset().top}, 100);
}

/* 원하는 element로 이동 */
ui.scrollIntoView = function(elementId) {
    document.getElementById(elementId).scrollIntoView();
}

ui.checkBoxInit = function(tableId){

    $("#"+tableId+"-select-all").remove();

    $(document).on('click', '#'+tableId+' .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')){
            $('#'+tableId+' .dt-body-center input[type="checkbox"]').removeAttr('checked');
            $(this).prop('checked', 'checked');
        }
    });
}

ui.checkBoxUnbind = function(tableId, func){

    $("#"+tableId+"-select-all").unbind('click');

    $(document).on('click', "#"+tableId+"-select-all", func);
}

ui.unCheck = function(tableId) {
    $('#' + tableId + ' .dt-body-center input[type="checkbox"]').prop('checked', false);
}

ui.leftActiveFocus = function(){
    /*var menu = $('ul.main-menu li.active ul.sub-menu li.active').parent();
    if(0 < menu.length){
        $('._leftFixed').scrollTop(menu.offset().top);
    }*/

}

ui.imageLayerView = function(){
    var yOffset = 30;
    var height = 0;
    var imageY;

    $(document).on("mouseover",".thumbnail",function(e){ //마우스 오버
        try {
            if (common.isEmpty($(this).attr("src"))) {
                return;
            }
            $("body").append("<p id='preview'><img id='previewImage'  src='" + $(this).attr("src") + "' width='300px' /></p>"); //이미지
            $("#previewImage").load(function () {
                height = $(this).height();
            });
            $("#preview")
                .css("top", (e.pageY - ((height / 2) + (height / 2)) + 30) + "px")
                .css("left", (e.pageX + yOffset) + "px")
                .fadeIn("fast");
            imageY = $("#previewImage").offset().top;
            if (imageY < 0) {
                $("#preview")
                    .css("top", (e.pageY - (height / 2) + 100) + "px")
                    .css("left", (e.pageX + yOffset) + "px")
            }
        }catch (exception){

        }
    });
    $(document).on("mousemove",".thumbnail",function(e){ //마우스 이동
        try {
            $("#preview")
                .css("top", (e.pageY - ((height / 2) + (height / 2)) + 30) + "px")
                .css("left", (e.pageX + yOffset) + "px")
            imageY = $("#previewImage").offset().top;
            if (imageY < 0) {
                $("#preview")
                    .css("top", (e.pageY - (height / 2) + 100) + "px")
                    .css("left", (e.pageX + yOffset) + "px")
                if ((e.pageY - (height / 2) + 100) < 10) {
                    $("#preview").css("top", "0px");
                }
            }
        }catch (exception){

        }
    });
    $(document).on("mouseout",".thumbnail",function(){ //마우스 아웃
        $("#preview").remove();
    });
};
ui.imageLayerView();

// 마우스 오버시 움직이는 이미지 추가
ui.webpImageView = function() {
    var yOffset = 30;
    var height = 0;
    var imageY;
    $(document).on("mouseover", "._webpImage", function (e) { //마우스 오버
        if (common.isEmpty($(this).attr("data-webpImage"))) {
            return;
        }
        $("body").append("<p id='preview'><img id='previewWebpImage' src='" + $(this).attr("data-webpImage") + "' width='300px' style='width: auto;max-height: 500px'/></p>"); //이미지
        $("#previewWebpImage").load(function () {
            height = $(this).height();
        });
        $("#preview")
            .css("top",(e.pageY - ((height/2) + (height/2)) + 30) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");
        imageY = $("#previewWebpImage").offset().top;
        if(imageY < 0){
            $("#preview")
                .css("top",(e.pageY - (height/2) + 100) + "px")
                .css("left",(e.pageX + yOffset) + "px")
        }
    });
    $(document).on("mousemove", "._webpImage", function (e) { //마우스 이동

        $("#preview")
            .css("top",(e.pageY - ((height/2) + (height/2)) + 30) + "px")
            .css("left",(e.pageX + yOffset) + "px")

        imageY = $("#previewWebpImage").offset().top;

        if(imageY < 0){
            $("#preview")
                .css("top",(e.pageY - (height/2) + 100) + "px")
                .css("left",(e.pageX + yOffset) + "px")
            if((e.pageY - (height/2) + 100) < 10){
                $("#preview").css("top","0px")
            }
        }


        // $("#preview")
        //     .css("top", (e.pageY - ((height / 2) + (height / 2)) + 30) + "px")
        //     .css("left", (e.pageX + yOffset) + "px");
    });
    $(document).on("mouseout", "._webpImage", function () { //마우스 아웃
        $("#preview").remove();
    });
}
ui.webpImageView();

$(document).on("click",".fullSize_background",function(){ //이미지 원본 크기
    util.fullSize_background($(this).prop('src'));
});


$(document).on('click', '._openImagePop', function(){
    /*util.imagePopup($(this));*/
    var url = $(this).prop('src');
    var title = $(this).prop('src');
    var option = ''//"width=" + (obj.width + 20) + ", height=" + (obj.height + 20) + ",fullscreen=yes";

    window.open(url, title, option);
});


ui.paintColor = function(){
    $('._bgColor').each(function () {
        var bgcolor = $(this).data('bgcolor');
        if (bgcolor != null && bgcolor != '') {
            $(this).css('background', bgcolor);
        }
    });

    $('._fontColor').each(function () {
        var fontcolor = $(this).data('fontcolor');
        if (fontcolor != null && fontcolor != '') {
            $(this).css('color', fontcolor);
        }
    });

    $('._borderColor').each(function () {
        var bordercolor = $(this).data('bordercolor');
        if (bordercolor != null && bordercolor != '') {
            $(this).css('border-color', bordercolor);
        }
    });

    $('._noBorder').each(function () {
        var noborderwidth = $(this).data('noborderwidth');
        $(this).css("background-color", 'white')
            .css("border-bottom", "hidden")
            .css("border-top", "hidden");
        if (noborderwidth != null && noborderwidth != '') {
            $(this).css("width", noborderwidth);
        }
    });
}

 ui.tableHeightSet = function(){
    $('._tableHeight').each(function () {
        var table = $(this);
        var height = table.data('height');

        if (height != null && height != '') {
            table.find('tr').each(function(){
                $(this).css('height', height);
            });
            table.find('td').each(function(){
                $(this).css('height', height);
            });
            table.find('th').each(function(){
                $(this).css('height', height);
            });
        }

        var height_tr = table.data('height-tr');
        if (height_tr != null && height_tr != "") {
            table.find('tr').each(function(){
                $(this).css('height', height_tr);
            });
        }

        var height_td = table.data('height-td');
        if (height_td != null && height_td != "") {
            table.find('td').each(function(){
                $(this).css('height', height_td);
            });
        }
        var height_th = table.data('height-th');
        if (height_th != null && height_th != "") {
            table.find('th').each(function(){
                $(this).css('height', height_th);
            });
        }
    });

     $('._stateTopTh').css('background-color','#b4c7e7');
     $('._stateSubTh').css('background-color','#dae3f3');
     $('._stateSumTd').css('background-color','#f2f2f2');
}