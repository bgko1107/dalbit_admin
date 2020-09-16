/* 화면 로딩 시 검색박스 안에 dummy를 넣어서 검색어에 엔터 누를 시 submit을 방지한다. */
$(function(){
    $("#searchForm").append('<input type="text" id="dummy" style="display:none;" />');
});

/* 팝업창 */
$(document).on('click', '._openPop', function(){
    util.windowOpen($(this).data('url'),$(this).data('width'),$(this).data('height'),$(this).data('url'));
});

/*회원정보보기 팝업*/
$(document).on('click', '._openMemberPop', function(){
    var moveTabId = '';
    if(!common.isEmpty($(this).data('tabid'))){
        moveTabId = '&moveTabId=' + encodeURIComponent($(this).data('tabid') +'');
    }

    var url = "/member/member/popup/memberPopup?memNo="+encodeURIComponent($(this).data('memno')) + moveTabId;
    util.windowOpen(url, 1460, 825, 'memberInfo' + $(this).data('memno'));
});

/*방송정보보기 팝업*/
$(document).on('click', '._openBroadcastPop', function(){
    var url = "/broadcast/broadcast/popup/broadcastPopup?roomNo="+encodeURIComponent($(this).data('roomno'));
    util.windowOpen(url, 1250, 700, 'broadcastInfo' + $(this).data('roomno'));
});

/*방송방메시지보내기 팝업*/
$(document).on('click', '._openAdminMessagePop', function(){
    var url = "/content/message/popup/messagePopup?roomNo="+encodeURIComponent($(this).data('roomno'))+"&djmemno=" + encodeURIComponent($(this).data('djmemno'));
    util.windowOpen(url, 800, 435, 'adminMessageInfo');
});

/*방송방플레이어 팝업*/
$(document).on('click', '._openPlayerPop', function(){
    var url = "/broadcast/broadcast/popup/playerPopup?roomNo="+encodeURIComponent($(this).data('roomno'));
    util.windowOpen(url, 530, 980, 'roomPlayer');
});

/*클립 플레이어 팝업*/
var clipPlayer;
$(document).on('click', '._openClipPlayerPop', function(){
    if($(this).find("i").is(".fa-pause")){
        console.log("[일시정지]");
        clipPlayer.ClipPause();
        clipPlayer.focus();
        return;
    }

    if(!common.isEmpty(clipPlayer) && $(this).data('clipno') == clipPlayer.clipNo){
        console.log("[재생]");
        clipPlayer.ClipPlay();
        clipPlayer.focus();
        return;
    }

    var url = "/clip/history/popup/clipPlayerPopup?clipPath="+encodeURIComponent($(this).data('clippath')) + "&clipNo="+encodeURIComponent($(this).data('clipno'));
    util.windowOpen(url, 340, 135, 'clipPlayer');
});

/*클립 상세 팝업*/
$(document).on('click', '._openClipInfoPop', function(){
    var url = "/clip/history/popup/clipInfoPopup?clipNo="+encodeURIComponent($(this).data('clipno'));

    util.windowOpen(url, 1050, 730, 'clipInfo');
});

/*문자 발송 팝업*/
$(document).on('click', '._openSmsSendPop', function(){
    var url = "/customer/sms/popup/smsSendPopup?cmid="+encodeURIComponent($(this).data('cmid'))+"&rownum="+encodeURIComponent($(this).data('rownum'))+"&logtable="+encodeURIComponent($(this).data('logtable'));;

    util.windowOpen(url, 775, 560, 'smsSend');
});

/*인싸티콘 카테고리 리스트 팝업*/
$(document).on('click', '._openCategoryListPop', function(){
    var url = "/content/emoticon/popup/category/list";

    util.windowOpen(url, 530, 500, 'categoryList');
});

$(document).on('click', 'img._imageFullPop', function(){
    $("#_imgFullLayer").html(util.imageFullSize("_imgFullLayer_modal", $(this).attr('src')));
    $('#_imgFullLayer_modal').modal('show');
});

$(document).on('focusout', '._trim', function(){
    var a = $(this).val().replace(/(\s*)/gi, '');
    $(this).val(a);
});