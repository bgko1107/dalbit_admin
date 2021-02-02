<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>--%>
<script src="/js/webrtc_wowza_play.js"></script>
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

    .liveChat__chat-comment{
        display: flex;
    }

    .liveChat__chat-comment .profileImg {
        position: relative;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        cursor: pointer;
    }


    video#remoteVideo {
        position: fixed; right: 0; bottom: 0;
        min-width: 100%; min-height: 100%;
        width: auto; height: auto; z-index: -100;
        background-size: cover;
    }

    ._title {
        background-color : #555;
        color : white;
    }

</style>

<div class="player">
    <div class="header clearfix">
        <h3><span id="title" class="_title"></span></h3>
        <button class="btn btn-info pull-right" id="chatToggle">채팅</button>
    </div>
    <div>
        <p>
            <%--<audio id="remoteVideo" autoplay="autoplay" controls="controls"></audio>--%>
            <video id="remoteVideo" autoplay="autoplay" controls="controls">

            </video>
        </p>
        <p>
            <h5 class="text-muted" id="state" style="color:red;"></h5>
        </p>
        <p style="display:none;">
            <input type="text" class="form-control" value="wss://devwv.dalbitlive.com/webrtc-session.json" id="sdpURL" placeholder="wowza URL">
            <input type="text" class="form-control" value="edge" id="applicationName" placeholder="edge or origin">
            <input type="text" class="form-control" value="" id="streamName" placeholder="streamName">
        </p>
        <p style="display: none">
            <button onclick="loadChat()" class="btn btn-info" id="callChat">Chat</button>
            <button onclick="go()" class="btn btn-info" id="play" value="play">Play</button>
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
</div>

<script>
    var pc_config = null;
    var broadInfo = <%=in_BroadInfo%>;
    var roomNo = "<%=in_roomNo%>";

    var remoteVideo;
    var adapter;

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
            alert("방송방 정보가 없습니다.");
            return false;
        }

        //$("#sdpURL").val(broadInfo.wsUrl);
        //$("#applicationName").val(broadInfo.applicationName);
        $("#streamName").val(broadInfo.streamName);

        $("#title").html(broadInfo.title);
        //$(".liveChat").css("background-image", "url("+PHOTO_SERVER_URL + broadInfo.roomBgImg+")");

        if(broadInfo.state == 4){
            alert("종료된 방송입니다.");
            // window.close();
            $("#state").text("종료된 방송 입니다.");
            isReloadChat = false;
            loadChat();
            return false;
        }

        setTimeout(function(){
            $("#play").click();
        },1000)
    })


    function go() {
        var type = $("#play").val();
        if (type == 'play') {
            play();
        }

        if (type == 'stop') {
            stop();
        }
    }


    /**
     * player 연결
     * */
    var errorCnt = 0;
    function play(){
        console.log("Play")

        let wsUrl = $('#sdpURL').val();
        let applicationName = $('#applicationName').val();
        let streamName = $('#streamName').val();

        let info = {
            wsUrl,
            applicationName,
            streamName
        };

        adapter = WebRTCPlayAdapter();
        adapter.on('error', error => {
            //some of the possible errors, NotFoundError, SecurityError,PermissionDeniedError
            console.log("error callback: " + error);
            if(error !== undefined){
                isReloadChat = false;
                //alert("플레이어 실행 오류 발생");
                // window.close();
                $("#state").text(++errorCnt + " [플레이어 실행 오류] " + error);

                return false;
            }
        });

        adapter.on('pcStateChange', state => {
            console.log('pcStateChange => ', state);

            //connecting
            if(state == 'connecting'){
                $("#state").text("방송방 연결중....");
            }

            // 청취가 시작되었다. 뭔가하자.
            if (state == 'connected') {
                isReloadChat = true;

                $("#play").text("stop");
                $("#play").val("stop");

                $("#state").text("");

                // 플레이어 세팅.
                remoteVideo = document.getElementById('remoteVideo');
                try{
                    remoteVideo.srcObject = adapter.getStream();
                } catch (error){
                    remoteVideo.src = window.URL.createObjectURL(adapter.getStream());
                }
            }

            // 끊어지거나 뭔가 잘못됐다.
            if (state == 'disconnected' || state == 'failed') {
                stop();
                isReloadChat = false;
                console.log("Connecton closed: " + state);
                alert("방송이 종료되었습니다.");
                $("#state").text("종료된 방송 입니다.");
                return false;
            }
        });

        adapter.start(info);
        $("#state").text("방송방 연결시도중..");
        loadChat();
    }


    function stop(){
        isReloadChat = false;
        $("#play").text("play");
        $("#play").val("play");

        if (adapter) adapter.stop();
        adapter = undefined;

        if(remoteVideo){
            remoteVideo.src = "";
        }
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

        util.getAjaxData("upldate", "/rest/broadcast/broadcast/chat", data, fn_chat_load_success, null, null, false);
    }

    function fn_chat_load_success(dst_id, response, dst_params){
        console.log(response);
        // isReloadChat = true;

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
                //play();
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

    $(document).on('click', '#chatToggle', function(){
        var isvisible = 0 < $("#liveChat__cover:visible").length;
        if(isvisible){
            $("#liveChat__cover").hide();
            $("#liveChat__chat").hide();
        }else{
            $("#liveChat__cover").show();
            $("#liveChat__chat").show();
        }
    });

</script>

<script type="text/x-handlebars-template" id="tmp_liveChat">
    {{#each this as |data|}}
        <div class="liveChat__chat-comment">
            <div class="profileImg" style="background-image: url({{this.image_profile.url}}?60x60);"></div>
            <figure></figure>
            <div class="ml5 mb5">
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