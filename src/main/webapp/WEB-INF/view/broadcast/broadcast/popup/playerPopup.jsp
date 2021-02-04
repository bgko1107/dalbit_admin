<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>--%>
<script src="/js/webrtc_adaptor.js"></script>
<%
    Object in_BroadInfo = request.getAttribute("BroadInfo");
    String in_roomNo = request.getParameter("roomNo");
%>

<style>
    ::-webkit-scrollbar{
        display: none;
    }

    .player {
        width: 500px;
        text-align: center;
    }

    .player input[type="text"]{
        width: 400px;
    }

    .liveChat {
        width:500px;
        height:800px;
        position: relative;
        background-size: cover;
    }

    .liveChat__cover {
        position: absolute;
        background-color: black;
        width: 100%;
        height: 100%;
        opacity: 0.5;
        z-index: 1;
    }

    .liveChat__chat {
        text-align: left;
        font-family: 'NanumSquare', sans-serif;
        overflow:auto;
        -ms-overflow-style: none;
        padding: 10px;
        position: absolute;
        width: 100%;
        height: 100%;
        z-index: 2;
    }

    .liveChat__btn {
        position: absolute;
        width: 100%;
        bottom: 15px;
        z-index: 10;
    }

    .liveChat__btn button{
        border-radius: 10px;
        border: 0px;
        background-color: white;
        padding: 1px 10px 1px 10px;
        font-weight: bold;
    }

    .liveChat__btn button:focus {
        outline: 0;
    }

    .liveChat__chat p {
        color: rgb(255, 255, 255);
        font-size: 12px;
        font-weight: 600;
        letter-spacing: -0.3px;
        transform: skew(-0.03deg);
    }

    .liveChat__chat p b.dj {
        background: rgb(133, 86, 246);
        color: rgb(255, 255, 255);
    }

    .liveChat__chat p b.manager {
        background: rgb(254, 172, 44);
        color: rgb(255, 255, 255);
    }

    .liveChat__chat .date{
        display: inline;
        padding-bottom: 9px;
        margin-bottom: 10px;
        font-size: 4px;
        font-weight: normal;
    }

    .liveChat__chat pre {
        display: inline-block;
        color: rgb(255, 255, 255);
        font-size: 12px;
        font-weight: 600;
        line-height: 18px;
        white-space: pre-wrap;
        overflow-wrap: break-word;
        word-break: break-word;
        letter-spacing: -0.35px;
        transform: skew(-0.03deg);
        padding: 9px 14px;
        border-radius: 10px;
        border-width: 0px;
        background: rgba(0, 0, 0, 0.3);
        font-family: 'NanumSquare', sans-serif;
    }

    .liveChat__chat p b {
         display: inline-block;
         margin-right: 5px;
         font-size: 10px;
         padding: 2px 6px;
         border-radius: 20px;
     }

    .liveChat__chat p {
        color: rgb(255, 255, 255);
    }

</style>

<div class="player">
    <div class="header clearfix">
        <h3 class="text-muted" id="title"></h3>
    </div>
    <div>
        <p>
            <audio id="remoteVideo" autoplay="autoplay" controls="controls"></audio>
        </p>
        <p>
            <h5 class="text-muted" id="state" style="color:red;"></h5>
        </p>
        <p>
            <input type="text" class="form-control" value="" id="roomNo" placeholder="Room No" style="display: none">
            <input type="text" class="form-control" value="" id="streamId" placeholder="Type stream ID" style="display: none">
            <input type="text" class="form-control" value="" id="tokenId" placeholder="Type token ID" style="display: none">
        </p>
        <p>
            <button onclick="joinRoom()" class="btn btn-info" id="joinRoom" style="display: none">RoomJoin</button>
            <button onclick="loadChat()" class="btn btn-info" id="callChat" style="display: none">Chat</button>
            <button onclick="play()" class="btn btn-info" id="play" style="display: none">Play</button>
        </p>
    </div>
    <div class="liveChat no-padding">
        <div class="liveChat__chat" id="liveChat__chat">
        </div>
        <div class="liveChat__cover" id="liveChat__cover">
        </div>
        <div class="liveChat__btn" id="liveChat__btn" style="display: none;">
            <button id="btn_scroll_down" onclick="fnScrollDown()">아래로 이동 <i class="fa fa-angle-double-down"></i></button>
        </div>
</div>


<script>
    var pc_config = null;
    var broadInfo = <%=in_BroadInfo%>;
    var roomNo = "<%=in_roomNo%>";


    var sdpConstraints = {
        OfferToReceiveAudio : true,
        OfferToReceiveVideo : true

    };
    var mediaConstraints = {
        video : false,
        audio : false
    };

    console.debug(broadInfo)
    var websocketURL = broadInfo.antUrl + "/" + ANT_APP_NAME + "/websocket";

    if (websocketURL.startsWith("https")) {
        websocketURL = websocketURL.replace("https:", "wss:");
    }else{
        websocketURL = websocketURL.replace("http:", "ws:");
    }

    var webRTCAdaptor = new WebRTCAdaptor({
        websocket_url : websocketURL,
        mediaConstraints : mediaConstraints,
        peerconnection_config : pc_config,
        sdp_constraints : sdpConstraints,
        remoteVideoId : "remoteVideo",
        isPlayMode: true,
        debug: true,
        callback : function(info, description) {
            if (info == "initialized") {
                console.log("initialized");
            } else if (info == "play_started") {
                //joined the stream
                console.log("play started");
                isReloadChat = true;
            } else if (info == "play_finished") {
                //leaved the stream
                isReloadChat = false;
                console.log("play finished");
                alert("방송이 종료되었습니다.");
                // window.close();
                $("#state").text("종료된 방송 입니다.");
                return false;
            }
            else if (info == "closed") {
                if (typeof description != "undefined") {
                    isReloadChat = false;
                    console.log("Connecton closed: " + JSON.stringify(description));
                    alert("방송이 종료되었습니다.");
                    // window.close();
                    $("#state").text("종료된 방송 입니다.");
                    return false;
                }
            }
        },
        callbackError : function(error) {
            //some of the possible errors, NotFoundError, SecurityError,PermissionDeniedError
            console.log("error callback: " + JSON.stringify(error));
            alert("플레이어 실행 오류 발생");
            // window.close();
            $("#state").text("[플레이어 실행 오류] " + JSON.stringify(error));
            return false;
        }
    });

    var streamId;
    var tokenId;
    var lastChatIdx = 0;
    var isReloadChat = true;

    $(document).ready(function(){
        if(common.isEmpty(roomNo)){
            alert("방송방 번호가 없습니다.\n방송방 번호를 확인하여 주시기 바랍니다.");
            window.close();
            return false;
        }
    });

    $(window).load(function(){
        console.log("load");
        console.log(broadInfo);

        if(common.isEmpty(broadInfo)){
            alert("종료된 방송입니다.");
            // window.close();
            $("#state").text("종료된 방송 입니다.");
            // return false;
        }

        streamId = broadInfo.bjStreamId;
        tokenId = broadInfo.bjPlayToken;
        $("#title").html(broadInfo.title);
        $("#streamId").val(streamId);
        $("#tokenId").val(tokenId);
        $(".liveChat").css("background-image", "url("+PHOTO_SERVER_URL + broadInfo.roomBgImg+")");


        setTimeout(function(){
            $("#play").click();
        },1000)
    })

    window.onbeforeunload = function() {
       alert("test");
    };


    /**
     * TEST용
     * room 연결
     * */
    function joinRoom(){
        var roomNo = $("#roomNo").val();

        if (common.isEmpty(roomNo)){
            var streamId = $("#streamId").val();
            var tokenId = $("#tokenId").val();
            console.log(streamId + "/" + tokenId);
            webRTCAdaptor.play(streamId, tokenId);
        }else{
            window.location.search = "?roomNo="+roomNo;
        }
    }



    /**
     * player 연결
     * */
    function play(){
        loadChat();
        webRTCAdaptor.play(streamId, tokenId);
    }



    /**
     * 채팅내용 호출
    * */
    function loadChat(){
        console.log("[loadChat]");
        var data = {
            "room_no" : roomNo
            ,"chatIdx" : lastChatIdx
        }

        util.getAjaxData("upldate", "/rest/broadcast/broadcast/chat", data, fn_chat_load_success);
    }

    function fn_chat_load_success(dst_id, response, dst_params){
        isReloadChat = true;

        if(response.result != "fail" && !common.isEmpty(response.data) && !response.data.length <= 0){
            lastChatIdx = response.data[response.data.length -1 ].chatIdx;

            var template = $('#tmp_liveChat').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html=templateScript(context);

            var scrollTop = $(".liveChat__chat").scrollTop();
            var innerH = $(".liveChat__chat").innerHeight();
            var scrollH = $(".liveChat__chat")[0].scrollHeight;


            $(".liveChat__chat").append(html);

            if((scrollTop + innerH) >= scrollH){    //스크롤 최하단에서는 자동 스크롤 이동
                $(".liveChat__chat").scrollTop($(".liveChat__chat")[0].scrollHeight);
            }else{
                $(".liveChat__btn").show();
            }
        }else{

        }

        // 5초마다 재호출
        setTimeout(function(){
            if(isReloadChat){
                loadChat();
            }
        },5000)
    }


    $(".liveChat__chat").on('scroll',function () {
        var scrollTop = $(".liveChat__chat").scrollTop();
        var innerH = $(".liveChat__chat").innerHeight();
        var scrollH = $(".liveChat__chat")[0].scrollHeight;

        if((scrollTop + innerH) < scrollH){    //스크롤 최하단에서는 자동 스크롤 이동
            $(".liveChat__btn").show();
        }else{
            $(".liveChat__btn").hide();
        }
    });

    /**
     * 스크롤 다운
     * */
    function fnScrollDown(){
        $(".liveChat__chat").scrollTop($(".liveChat__chat")[0].scrollHeight);
        $(".liveChat__btn").hide();
    }


</script>

<script type="text/x-handlebars-template" id="tmp_liveChat">
    {{#each this as |data|}}
        <div class="liveChat__chat-comment ">
            <figure></figure>
            <div>
                <p>
                    {{#dalbit_if auth "==" "3"}}<b class="dj">DJ</b>{{/dalbit_if}}
                    {{#dalbit_if auth "==" "1"}}<b class="manager">매니저</b>{{/dalbit_if}}
                    {{this.nickname}}
                </p>
                <pre>{{this.msg}}</pre>
                <p class="date">{{this.writeDateFormat}}</p>
            </div>
        </div>
    {{/each}}

</script>