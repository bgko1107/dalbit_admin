<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div id="wrapper">
    <form id="targetForm"></form>
</div>




<script src="../../../js/lib/jquery.table2excel.js"></script>

<script>
    $(document).ready(function () {
        fnc_pushDetail.init();
    });


    var fnc_pushDetail = {};
//=------------------------------ Init / Event / UI--------------------------------------------
    fnc_pushDetail.targetId= "pushDetail";
    fnc_pushDetail.formId= "pushDetailForm";

    fnc_pushDetail.init= function() {
            fnc_pushDetail.target = $("#"+fnc_pushDetail.targetId);
            fnc_pushDetail.target.find("#targetForm").attr("id", fnc_pushDetail.targetId + "Form");
            this.formId = fnc_pushDetail.targetId + "Form";

            if(common.isEmpty(getSelectDataInfo())){
                fnc_pushDetail.insertDetail();
            }else{
                var data = new Object();
                data.push_idx = getSelectDataInfo().data.push_idx;

                util.getAjaxData(fnc_pushDetail.targetId, "/rest/content/push/detail",data, fnc_pushDetail.fn_detail_success, fnc_pushDetail.fn_fail);
            }

            // this.initDetail();
            // this.initDetailEvent();
    };


        // 초기 설정
    fnc_pushDetail.initDetail= function() {
            // 캘린더
            fnc_pushDetail.target.find('.input-group.date').datetimepicker({
                format: 'L'
                , date: new Date()
            });

            // 시간 Select CSS 적용
            fnc_pushDetail.target.find("#timeHour").attr("class", "select-time");
            fnc_pushDetail.target.find("#timeMinute").attr("class", "select-time");
    };

        // 이벤트 적용
    fnc_pushDetail.initDetailEvent= function() {

            //수신대상 선택
            fnc_pushDetail.target.find("input[name='is_all']").change(function () {
                if ($(this).val() == "7") { //지정
                    fnc_pushDetail.target.find("#btn_selectMember").prop("disabled", false);
                    fnc_pushDetail.target.find("#div_selectTarget").show();

                    // 플랫폼 선택
                    fnc_pushDetail.target.find("input[name='platform']").prop("disabled", true);
                    fnc_pushDetail.target.find("input[name='platform']").prop("checked", true);
                } else {
                    fnc_pushDetail.target.find("#btn_selectMember").prop("disabled", true);
                    fnc_pushDetail.target.find("#div_selectTarget").hide();
                    fnc_pushDetail.target.find("#div_selectTarget").empty();

                    fnc_pushDetail.target.find("input[name='platform']").prop("disabled", false);
                }
            });

            //OS 구분
            fnc_pushDetail.target.find("input[name='platform']").change(function () {
                if ($(this).val() == "-1") {
                    if ($(this).is(":checked")) {
                        fnc_pushDetail.target.find("input[name='platform']").each(function () {
                            this.checked = true;
                        });
                    } else {
                        fnc_pushDetail.target.find("input[name='platform']").each(function () {
                            this.checked = false;
                        });
                    }
                } else {
                    if ($(this).is(":checked")) {
                        var cntTotal = fnc_pushDetail.target.find("input[name='platform']").length;
                        var cntChecked = fnc_pushDetail.target.find("input[name='platform']:checked").length;
                        if ((cntTotal) == (cntChecked + 1)) {
                            fnc_pushDetail.target.find("input[name='platform'][value='-1']").prop("checked", true);
                        }
                    } else {
                        fnc_pushDetail.target.find("input[name='platform'][value='-1']").prop("checked", false);
                    }
                }
            });


            // 발송 형태
            fnc_pushDetail.target.find("input[name='send_type']").change(function () {

                if ($(this).val() == "0") {
                    fnc_pushDetail.target.find("input[name='is_direct'][value='0']").click();
                }
                if ($(this).val() == "2") {
                    fnc_pushDetail.target.find("input[name='is_direct'][value='0']").click();

                    fnc_pushDetail.target.find("input[name='slct_push']").prop('checked', false);

                    fnc_pushDetail.target.find("#label_targetType").text("");
                    fnc_pushDetail.target.find("#input_targetLink").hide();
                    fnc_pushDetail.target.find("#input_targetLink").val("");
                    fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                    fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();
                }else{
                    fnc_pushDetail.target.find("input[name='is_direct']").prop("disabled", false);

                    fnc_pushDetail.target.find("input[name='slct_push']").prop("disabled", false);
                    fnc_pushDetail.target.find("input[name='slct_push'][value='2']").click();
                }
            });


            //발송여부 선택
            fnc_pushDetail.target.find("input[name=is_direct]:radio").click(function () {
                if(fnc_pushDetail.target.find("input[name='send_type']:checked").val() != '1'){
                    if($(this).val() != 0){
                        alert("전체 발송 및 알림 발송은 즉시 발송만 가능합니다.");
                        return false;
                    }
                }
            });

            fnc_pushDetail.target.find("input[name='is_direct']:radio").change(function () {
                var type = this.value;

                var sendDate = moment();

                // 캘린더 초기값
                fnc_pushDetail.target.find("#push-div-sendDate").find("#push-sendDate").val(sendDate.format('YYYY.MM.DD'));

                // 시간 Select CSS 적용
                fnc_pushDetail.target.find("#push-div-sendDate").find("#timeHour").val(sendDate.hour().toString().length == 1?("0"+sendDate.hour()):sendDate.hour());
                fnc_pushDetail.target.find("#push-div-sendDate").find("#timeMinute").val(sendDate.minute().toString().length == 1?("0"+sendDate.minute()):sendDate.minute());

                //예약 발송 일 경우 날짜 추가
                if (type == "1") {
                    fnc_pushDetail.target.find("#push-div-sendDate").show();
                } else {
                    fnc_pushDetail.target.find("#push-div-sendDate").hide();

                }
            });


            //푸시 타입 선택
            fnc_pushDetail.target.find("input[name=slct_push]:radio").click(function () {
                if(fnc_pushDetail.target.find("input[name='send_type']:checked").val() == '2'){
                    alert("푸시 타입은 푸시 발송 시에만 선택 가능 합니다.");
                    return false;
                }
            });

            fnc_pushDetail.target.find("input[name=slct_push]:radio").change(function () {
                var type = this.value;
                if(type == "1"){ //room_no
                    fnc_pushDetail.target.find("#label_targetType").text("방송방 번호:");
                    fnc_pushDetail.target.find("#input_targetLink").show();
                    fnc_pushDetail.target.find("#input_targetLink").val("");
                    fnc_pushDetail.target.find("#input_targetLink").attr("disabled", true);
                    fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                    fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").show();

                }else if(type == "31" || type == "35" || type == "36"){ //mem_no
                    fnc_pushDetail.target.find("#label_targetType").text("회원 번호:");
                    fnc_pushDetail.target.find("#input_targetLink").show();
                    fnc_pushDetail.target.find("#input_targetLink").val("");
                    fnc_pushDetail.target.find("#input_targetLink").attr("disabled", true);
                    fnc_pushDetail.target.find("#btn_selectMember_link").show();
                    fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();

                }else if(type == "5" || type == "6" || type == "7"){ //board_idx
                    fnc_pushDetail.target.find("#label_targetType").text("게시 번호:");
                    fnc_pushDetail.target.find("#input_targetLink").show();
                    fnc_pushDetail.target.find("#input_targetLink").val("");
                    fnc_pushDetail.target.find("#input_targetLink").attr("disabled", false);
                    fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                    fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();
                }else{
                    fnc_pushDetail.target.find("#label_targetType").text("");
                    fnc_pushDetail.target.find("#input_targetLink").hide();
                    fnc_pushDetail.target.find("#input_targetLink").val("");
                    fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                    fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();
                }
            });

            // 지정회원 - 수신대상
            fnc_pushDetail.target.find("#btn_selectMember").on("click", function () {
                showPopMemberList(fnc_pushDetail.choiceMember);
            });

            // 이동대상지정 - 회원 조회 팝업
            fnc_pushDetail.target.find("#btn_selectMember_link").on("click", function(){
                showPopMemberList(fnc_pushDetail.choiceMember_link);
            });

            // 이동대상지정 - 방송방 조회 팝업
            fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").on("click", function(){
                showPopBroadcastLiveList(fnc_pushDetail.choiceBroadcastLive_link);
            });

            // 등록 버튼
            fnc_pushDetail.target.find("#insertBtn").on("click", function () {
                if(!confirm("등록 하시겠습니까?")){
                    return false;
                }

                var data = fnc_pushDetail.getDetailData();

                if(!fnc_pushDetail.isValid(data)){
                    return false;
                }

                util.getAjaxData("insert", "/rest/content/push/insert", data, fnc_pushDetail.fn_insert_success, fnc_pushDetail.fn_fail);
            })


            // 수정 버튼
            fnc_pushDetail.target.find("#updateBtn").on("click", function () {
                if(!confirm("재발송 하시겠습니까?")){
                    return false;
                }

                var data = fnc_pushDetail.getDetailData();

                if(!fnc_pushDetail.isValid(data)){
                    return false;
                }

                util.getAjaxData("upldate", "/rest/content/push/insert", data, fnc_pushDetail.fn_update_success, fnc_pushDetail.fn_fail);
            })
    };


        //수정 데이터 조회 후 UI 처리
    fnc_pushDetail.initUpdateUI= function(){
            var detailData = getSelectDataInfo().detailData;
            console.log(detailData);


            //OS 구분
            if(detailData.platform == "111"){
                fnc_pushDetail.target.find("input[name='platform']").each(function () {
                    this.checked = true;
                });
            }else{
                fnc_pushDetail.target.find("input[name='platform']").each(function () {
                    this.checked = false;
                });

                var arrayPlatform = detailData.platform.split('');
                for(var idx in arrayPlatform){
                    if(arrayPlatform[idx] == 1){
                        var value = parseInt(idx) + 1;
                        fnc_pushDetail.target.find("input[name='platform'][value='"+ value +"']").prop("checked", true);
                    }
                }
            }


            //수신대상선택
            fnc_pushDetail.target.find("input[name=is_all][value='"+ detailData.is_all +"']").prop("checked", true);

            //발송 형태
            if (detailData.send_type == "2") {
                fnc_pushDetail.target.find("input[name='is_direct'][value='0']").click();

                fnc_pushDetail.target.find("input[name='slct_push']").prop('checked', false);

                fnc_pushDetail.target.find("#label_targetType").text("");
                fnc_pushDetail.target.find("#input_targetLink").hide();
                fnc_pushDetail.target.find("#input_targetLink").val("");
                fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();
            }


            var type = detailData.slct_push;
            if(type == "1"){ //room_no
                fnc_pushDetail.target.find("#label_targetType").text("방송방 번호:");
                fnc_pushDetail.target.find("#input_targetLink").show();
                fnc_pushDetail.target.find("#input_targetLink").attr("disabled", true);
                fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").show();

            }else if(type == "31" || type == "35" || type == "36"){ //mem_no
                fnc_pushDetail.target.find("#label_targetType").text("회원 번호:");
                fnc_pushDetail.target.find("#input_targetLink").show();
                fnc_pushDetail.target.find("#input_targetLink").attr("disabled", true);
                fnc_pushDetail.target.find("#btn_selectMember_link").show();
                fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();

            }else if(type == "5" || type == "6" || type == "7"){ //board_idx
                fnc_pushDetail.target.find("#label_targetType").text("게시 번호:");
                fnc_pushDetail.target.find("#input_targetLink").show();
                fnc_pushDetail.target.find("#input_targetLink").attr("disabled", false);
                fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();
            }else{
                fnc_pushDetail.target.find("#label_targetType").text("");
                fnc_pushDetail.target.find("#input_targetLink").hide();
                fnc_pushDetail.target.find("#btn_selectMember_link").hide();
                fnc_pushDetail.target.find("#btn_selectBroadcastLive_link").hide();
            }


            // 지정회원일 경우 추가처리
            if(detailData.is_all == "7"){
                var selectTarget = detailData.mem_info;
                var data = {};
                for(var idx in selectTarget){
                    var data = selectTarget[idx];
                    fnc_pushDetail.choiceMember(data);
                }
            }

            //예약 발송 일 경우 날짜 데이터 추가
            if (detailData.is_direct == "1") {
                fnc_pushDetail.target.find("#push-div-sendDate").show();

                var sendDate = moment(detailData.send_datetime);
            }else{
                var sendDate = moment();
            }
            // 캘린더 초기값
            fnc_pushDetail.target.find("#push-div-sendDate").find("#push-sendDate").val(sendDate.format('YYYY.MM.DD'));

            // 시간 Select CSS 적용
            fnc_pushDetail.target.find("#push-div-sendDate").find("#timeHour").val(sendDate.hour().toString().length == 1?("0"+sendDate.hour()):sendDate.hour());
            fnc_pushDetail.target.find("#push-div-sendDate").find("#timeMinute").val(sendDate.minute().toString().length == 1?("0"+sendDate.minute()):sendDate.minute());
    };


        // 등록 화면
    fnc_pushDetail.insertDetail= function() {
            var template = $('#tmp_pushDetailFrm').html();
            var templateScript = Handlebars.compile(template);

            var detailData = {
                'send_type' : 1
                ,'is_direct' : 0
                ,'slct_push' : 2
            };

            var context = detailData;
            var html = templateScript(context);
            fnc_pushDetail.target.find("#"+this.formId).html(html);

            fnc_pushDetail.initDetail();
            fnc_pushDetail.initDetailEvent();

            var scrollPosition = $("#tab_"+fnc_pushDetail.targetId).offset();
            util.scrollPostion(scrollPosition.top);
    };

        // 수정 화면
    fnc_pushDetail.updateDetail= function(){
            var detailData = getSelectDataInfo().detailData;
            detailData.rowNum = getSelectDataInfo().data.rowNum;
            dalbitLog(detailData);


            // form 띄우기
            var template = $('#tmp_pushDetailFrm').html();
            var templateScript = Handlebars.compile(template);
            var context = detailData;
            var html = templateScript(context);
            fnc_pushDetail.target.find("#"+ fnc_pushDetail.formId).html(html);

            fnc_pushDetail.initDetail();
            fnc_pushDetail.initDetailEvent();
            fnc_pushDetail.initUpdateUI();

            var scrollPosition = $("#tab_"+fnc_pushDetail.targetId).offset();
            util.scrollPostion(scrollPosition.top);
    };

//=------------------------------ Option --------------------------------------------

        // 상세 목록 조회 성공 시
    fnc_pushDetail.fn_detail_success= function(dst_id, data, dst_params){
            if(data.result == "fail"){
                alert(data.message);
                return false;
            }

            setSelectDataInfo("detailData", data.data);

            fnc_pushDetail.updateDetail();
    };


        // 등록 성공 시
    fnc_pushDetail.fn_insert_success= function(dst_id, data, dst_params){
            if(data.result == "fail"){
                alert(data.message);
                return false;
            }

            if(data.data.is_all == "11"){    //전체발송
                if(Number(data.sucCnt) > "0") {
                    alert(data.message);
                }
            }else{
                alert(
                    data.message +
                    '\n- 성공 : ' + data.data.sucCnt + '건' +
                    (data.data.notMemNoCnt != "0" ? '\n- mem_no 미존재 : ' + data.data.notMemNoCnt + '건' : '') +
                    (data.data.notTokenCnt != "0" ? '\n- token 미존재 : ' + data.data.notTokenCnt + '건' : '') +
                    (data.data.failCnt != "0" ? '\n- 실패 : ' + data.data.failCnt + '건' : '')
                );
            }

            fnc_pushList.selectMainList(false);

            //하위 탭 초기화
            initContentTab();
            //상단 이동
            $('html').animate({scrollTop : 0}, 100);
            $("#"+fnc_pushDetail.formId).empty();
    };


        // 수정 성공 시
    fnc_pushDetail.fn_update_success= function(dst_id, data, dst_params){
            if(data.result == "fail"){
                alert(data.message);
                return false;
            }

            if(data.data.is_all == "11"){    //전체발송
                if(Number(data.sucCnt) > "0") {
                    alert(data.message);
                }
            }else{
                alert(
                    data.message +
                    '\n- 성공 : ' + data.data.sucCnt + '건' +
                    (data.data.notMemNoCnt != "0" ? '\n- mem_no 미존재 : ' + data.data.notMemNoCnt + '건' : '') +
                    (data.data.notTokenCnt != "0" ? '\n- token 미존재 : ' + data.data.notTokenCnt + '건' : '') +
                    (data.data.failCnt != "0" ? '\n- 실패 : ' + data.data.failCnt + '건' : '')
                );
            }

            fnc_pushList.selectMainList(false);

            //하위 탭 초기화
            initContentTab();
            //상단 이동
            $('html').animate({scrollTop : 0}, 100);
            $("#"+fnc_pushDetail.formId).empty();
    };


        // Ajax 실패
    fnc_pushDetail.fn_fail= function(data, textStatus, jqXHR){
            alert(data.message);

            console.log(data, textStatus, jqXHR);
    };

//=------------------------------ Data Handler ----------------------------------

        // 데이터 가져오기
    fnc_pushDetail.getDetailData= function(){
            var resultJson ={};

            var formArray = fnc_pushDetail.target.find("#" + this.formId).serializeArray();
            for (var i = 0; i < formArray.length; i++){
                resultJson[formArray[i]['name']] = formArray[i]['value'];
            }


            //platform
            if(fnc_pushDetail.target.find("#platform-1").is(":checked")){
                resultJson['platform'] = "111";
            }else{
                var platformCnt = fnc_pushDetail.target.find("input[name=platform]").length;
                var platform = "1";
                for(var i = 1; i < platformCnt; i++){
                    if(fnc_pushDetail.target.find("#platform"+(i+1)).is(":checked")){
                        platform += "1";
                    }else{
                        platform += "0";
                    }
                }
                resultJson['platform'] = platform;
            }

            //Date 처리이이이~~~
            var sendDateDiv = fnc_pushDetail.target.find("#push-div-sendDate");
            resultJson['send_datetime'] = sendDateDiv.find("#push-sendDate").val().replace(/[^0-9]/gi, '') + sendDateDiv.find("#timeHour").val() + sendDateDiv.find("#timeMinute").val();

            //지정회원 parsing
            var selectTarget = [];
            var send_cnt = -1;
            if (fnc_pushDetail.target.find("input[name=is_all]:checked").val() == "7") {
                send_cnt = fnc_pushDetail.target.find("#div_selectTarget").find("p").length;
                fnc_pushDetail.target.find("#div_selectTarget").find("p").each(function () {
                    var id = $(this).prop("id");
                    selectTarget.push(id);
                })

                resultJson['mem_nos'] = selectTarget.toString().replace(/,/gi , "|");
            }
            resultJson['send_cnt'] = send_cnt;


            //푸시 타입 선택
            var type = fnc_pushDetail.target.find("input[name=slct_push]:radio:checked").val()
            if(type == "1"){ //room_no
                resultJson['room_no'] = fnc_pushDetail.target.find("#input_targetLink").data("targetinfo");
                resultJson['target_info'] = fnc_pushDetail.target.find("#input_targetLink").data("targetinfo");

            }else if(type == "31" || type == "35" || type == "36"){ //mem_no
                resultJson['target_mem_no'] = fnc_pushDetail.target.find("#input_targetLink").data("targetinfo");
                resultJson['target_info'] = fnc_pushDetail.target.find("#input_targetLink").data("targetinfo");

            }else if(type == "5" || type == "6" || type == "7"){ //board_idx
                resultJson['board_idx'] = fnc_pushDetail.target.find("#input_targetLink").val();
                resultJson['target_info'] = fnc_pushDetail.target.find("#input_targetLink").val();
            }

            // 발송상태
            resultJson['status'] = 0;
            resultJson['msg_type'] = 0;

            // 푸시디자인
            if(type == "5" || type == "6"){
                resultJson['image_type'] = "102";
            }else{
                resultJson['image_type'] = "101";
            }

            if(common.isEmpty(resultJson['slct_push'])){
                resultJson['slct_push'] = "9";
            }

            dalbitLog(resultJson)
            return resultJson;
    };


    fnc_pushDetail.isValid= function(data) {

            if (common.isEmpty(data.platform) || data.platform == "100") {
                alert("노출 OS 구분을 선택하여 주시기 바랍니다.");
                fnc_pushDetail.target.find("input[name=platform]").focus();
                return false;
            }

            if (common.isEmpty(data.send_title)) {
                alert("메시지 제목을 입력하여 주시기 바랍니다.");
                fnc_pushDetail.target.find("input[name=title]").focus();
                return false;
            }

            if (common.isEmpty(data.send_cont)) {
                alert("메시지 내용을 입력하여 주시기 바랍니다.");
                fnc_pushDetail.target.find("input[name=send_cont]").focus();
                return false;
            }

            if (common.isEmpty(data.is_all)) {
                alert("수신대상 구분을 선택하여 주시기 바랍니다.");
                fnc_pushDetail.target.find("input[name=is_all]").focus();
                return false;
            }

            if (data.is_all == "7") {
                if (common.isEmpty(data.mem_nos)) {
                    alert("발송 대상을 선택하여 주시기 바랍니다.");
                    fnc_pushDetail.target.find("#btn_selectMember").focus();
                    return false;
                }
            }

            /*
            if (common.isEmpty(data.msg_type)) {
                alert("메시지 구분을 선택하여 주시기 바랍니다.");
                fnc_pushDetail.target.find("input[name=msg_type]").focus();
                return false;
            }
            */

            if (common.isEmpty(data.is_direct)) {
                alert("발송 구분을 선택하여 주시기 바랍니다.");
                fnc_pushDetail.target.find("input[name=is_direct]").focus();
                return false;
            }

            if (data.is_direct == "1") {
                var sendDate = common.stringToDateTime(data.send_datetime);
                if(sendDate < moment()){
                    if(!confirm("예약발송 시간이 현재 시간보다 이전 시간 입니다.\n그래도 예약발송을 진행 하시겠습니까?")){
                        return false;
                    }
                }
            }

            if(data.send_type != "2"){
                if (common.isEmpty(data.slct_push)) {
                    alert("푸시 타입을 선택하여 주시기 바랍니다.");
                    fnc_pushDetail.target.find("input[name=slct_push]").focus();
                    return false;
                }

                //푸시 타입 선택
                var type = data.slct_push;
                if(type == "1"){ //room_no
                    if (common.isEmpty(data.room_no)) {
                        alert("방송방을 선택하여 주시기 바랍니다.");
                        fnc_pushDetail.target.find("#input_targetLink").focus();
                        return false;
                    }
                }else if(type == "31" || type == "35" || type == "36"){ //mem_no
                    if (common.isEmpty(data.target_mem_no)) {
                        alert("회원을 선택하여 주시기 바랍니다.");
                        fnc_pushDetail.target.find("#input_targetLink").focus();
                        return false;
                    }
                }else if(type == "5" || type == "6" || type == "7"){ //board_idx
                    if (common.isEmpty(data.board_idx)) {
                        alert("게시물 번호를 입력하여 주시기 바랍니다.");
                        fnc_pushDetail.target.find("#input_targetLink").focus();
                        return false;
                    }
                }
            }

            return true;
    };


//=------------------------------ Modal ----------------------------------

        // [수신대상 선택 - 지정회원] 회원 추가
    fnc_pushDetail.choiceMember= function(data) {
            console.log(data);
            var html = '<p id="' + data.mem_no + '">' + data.mem_nick + '(' +data.mem_userid+ ') <a style="cursor: pointer;" onclick="fnc_pushDetail.delMember($(this))">[X]</a></p>'

            if(fnc_pushDetail.target.find("#div_selectTarget").find("p").length >= 20){
                alert("수신대상자는 최대 20명까지 지정 가능합니다.");
                return false;
            }

            fnc_pushDetail.target.find("#div_selectTarget").append(html);
    };

        // [수신대상 선택 - 지정회원] 회원 삭제
    fnc_pushDetail.delMember= function(dom) {
            dom.parent("p").remove();
    };



        // 이동대상지정 - 방송방
    fnc_pushDetail.choiceBroadcastLive_link= function(data) {
            console.log(data);
            var html = '<p id="' + data.room_no + '">' + data.title + '<a style="cursor: pointer;" onclick="fnc_pushDetail.delMember($(this))">[X]</a></p>'

            fnc_pushDetail.target.find("#input_targetLink").val(data.room_no);
            fnc_pushDetail.target.find("#input_targetLink").data("targetinfo", data.room_no);
    };


        // 이동대상지정 - 회원
    fnc_pushDetail.choiceMember_link= function(data) {
            console.log(data);
            var html = '<p id="' + data.mem_no + '">' + data.mem_nick + '(' +data.mem_userid+ ') <a style="cursor: pointer;" onclick="fnc_pushDetail.delMember($(this))">[X]</a></p>'

            fnc_pushDetail.target.find("#input_targetLink").val(data.mem_no);
            fnc_pushDetail.target.find("#input_targetLink").data("targetinfo", data.mem_no);
    };
</script>






<!-- =------------------ Handlebars ---------------------------------- -->

<script id="tmp_pushDetailFrm" type="text/x-handlebars-template">
    <input type="hidden" name="push_idx" value="{{push_idx}}" />
    <div class="row col-md-12">
        <div class="row col-md-12" style="padding-bottom: 15px">
            <div class="pull-left">
                ㆍ <b>*</b> 는 필수 입력사항 입니다. <br>
                ㆍ 발송 상태를 확인하시고 미발송 또는 발송오류 시 해당 정보가 맞는지 확인한 후 수정완료를 하시면 재발송이 가능합니다.
            </div>
            <div class="pull-right">
                {{^push_idx}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/push_idx}}
                {{#push_idx}}<button class="btn btn-default" type="button" id="updateBtn">재발송</button>{{/push_idx}}
            </div>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>No</th>
                <td>{{rowNum}}</td>

                <!--
                <th>발송상태</th>
                <td colspan="3">
                    {{^push_idx}}
                        {{{getCommonCodeLabelAndHidden 0 'push_snedStatus' 'status'}}}
                    {{/push_idx}}
                    {{#push_idx}}
                        {{{getCommonCodeLabelAndHidden ../status 'push_snedStatus' 'status'}}}
                    {{/push_idx}}
                </td>
                 -->

                <th>노출 OS구분</th>
                <%--<td colspan="5">{{{getCommonCodeRadio -1 'push_platform'}}}</td>--%>
                <td colspan="2">
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform-1" value="-1" checked="true"><span>전체</span> </label>
                    <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform1" value="1" checked="true"><span>PC</span></label>--%>
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform2" value="2" checked="true"><span>Android</span></label>
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform3" value="3" checked="true"><span>IOS</span></label>
                </td>

                <th>발송형태</th>
                <td colspan="2">
                    {{{getCommonCodeRadio send_type 'push_sendType' 'Y'}}}

                    <%--<label class="control-inline fancy-radio custom-color-green"><input type="radio" value="0" id="is_noti0" name="is_noti" class="form-control" checked disabled><span><i></i>미표시</span> </label>--%>
                    <%--<label class="control-inline fancy-radio custom-color-green"><input type="radio" value="1" id="is_noti1" name="is_noti" class="form-control" disabled><span><i></i>표시</span> </label>--%>
                    <%--<p class="no-padding no-margin" style="color:red; font-size:0.9em;"> * 수신대상이 '지정 회원'일 경우만 가능</p>--%>
                </td>

                <th>발송일시</th>
                <td colspan="3">{{send_datetime}}</td>
            </tr>
            <tr>
                <th>메시지 제목</th>
                <td colspan="5" style="width:50%;"><input type="text" class="form-control" name="send_title" id="push-send_title" placeholder="제목을 입력해주세요." value="{{send_title}}"></td>

                <th rowspan="2">수신대상 선택</th>
                <td rowspan="2" colspan="5" style="width:50%;">
                    <div>
                        <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="21" id="is_all21" name="is_all" class="form-control"><span><i></i>전체(회원+비회원)</span> </label>
                        <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="11" id="is_all11" name="is_all" class="form-control"><span><i></i>회원</span> </label>
                        <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="31" id="is_all31" name="is_all" class="form-control"><span><i></i>비회원</span> </label>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="is_all" value="3" checked="true"><span>남자</span></label>--%>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="is_all" value="4" checked="true"><span>로그인</span></label>--%>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="is_all" value="5" checked="true"><span>비로그인</span></label>--%>
                        <label class="control-inline fancy-radio custom-color-green"><input type="radio" id="is_all99" name="is_all" value="99" class="form-control"><span><i></i>테스트 계정</span></label>
                        <div>
                            <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="7" id="is_all7" name="is_all" class="form-control" checked="checked"><span><i></i>지정 회원 </span></label>
                            <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember"/>
                        </div>
                    </div>
                    <div id="div_selectTarget" style="padding-left: 30px;">
                    </div>
                </td>
            </tr>
            <tr>
                <th rowspan="2">메시지 내용</th>
                <td rowspan="2" colspan="5">
                    <div>
                        <textarea class="form-control" name="send_cont" id="push-send_cont" rows="5" cols="30" placeholder="방송 시스템에 적용되는 내용을 작성해주세요." style="resize: none" maxlength="150">{{send_cont}}</textarea>
                        <span style="color: red">* 메시지 내용은 10자~150자(한글) 입력 가능합니다.</span>
                    </div>
                </td>
            </tr>
            <!--
            <tr>
            <th>메시지 구분</th>
            <td colspan="5">{{{getCommonCodeRadio msg_type 'push_messageType' 'N' 'msg_type'}}}</td>
            </tr>
            -->
            <tr>
                <th>발송여부</th>
                <td colspan="5">
                    <div>
                        {{{getCommonCodeRadio is_direct 'push_isDirect' 'N' 'is_direct'}}}
                    </div>
                    <div class="input-group date" id="push-div-sendDate" style="display:none;">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        <input type="text" class="form-control" id="push-sendDate" style="width:100px; height:35px;">
                        {{{getCommonCodeSelect 00 'timeHour'}}}
                        <span> : </span>
                        {{{getCommonCodeSelect 00 'timeMinute'}}}
                    </div>
                </td>
            </tr>
            <tr>
                <th>이동대상지정</th>
                <td colspan="11">
                    <div>
                        <label id="label_targetType"></label>
                        <input type="text" id="input_targetLink" value="{{target_info}}" data-targetinfo="{{target_info}}" style="display:none;">
                        <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember_link" style="display:none;"/>
                        <input type="button" value="라이브방송방검색" class="btn btn-success btn-xs" id="btn_selectBroadcastLive_link" style="display:none;"/>
                    </div>
                    <div style="padding-left: 30px;">
                    </div>
                </td>

                <!--  ==================================== 이미지 사용 O
                <th>이동대상지정</th>
                <td colspan="5">
                    <div>
                        <label id="label_targetType"></label>
                        <input type="text" id="input_targetLink" value="{{target_info}}" data-targetinfo="{{target_info}}" style="display:none;">
                        <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember_link" style="display:none;"/>
                        <input type="button" value="라이브방송방검색" class="btn btn-success btn-xs" id="btn_selectBroadcastLive_link" style="display:none;"/>
                    </div>

                    <div style="padding-left: 30px;">

                    </div>
                </td>

                <th>푸시 이미지</th>
                <td colspan="4">
                    <input type="text" class="_trim" id="push-send_url" name="send_url" style="width:70%" value="{{send_url}}" >
                    <input type="button" value="미리보기" onclick="getImg('push-send_url')">
                    <br><span style="color: red"> * Photo 서버에 업로드된 파일만 등록 가능합니다.</span>
                </td>
                <td colspan="1">
                    <img id="push-send_urlViewer" class="thumbnail fullSize_background no-margin no-padding" style="border:0px; border-radius:0px;" src="" alt="" /></a>
                </td>
                -->
            </tr>
            <tr>
                <th>푸시 타입<br>(이동경로)</th>
                <td colspan="11">{{{getCommonCodeRadio slct_push 'push_slctPush2' 'N' 'slct_push'}}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>