<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>

<c:set var="readYn" value="N" />
<c:set var="insertYn" value="N" />
<c:set var="deleteYn" value="N" />

<c:forEach var="menu" items="${cfn:getMenuList()}" varStatus="status">
    <c:forEach var="twoDepth" items="${menu.twoDepth}">
        <c:if test="${twoDepth.idx eq 123}">
            <c:set var="readYn" value="${twoDepth.is_read eq 0 ? 'N' : 'Y'}" />
            <c:set var="insertYn" value="${twoDepth.is_insert eq 0 ? 'N' : 'Y'}" />
            <c:set var="deleteYn" value="${twoDepth.is_delete eq 0 ? 'N' : 'Y'}" />
        </c:if>
    </c:forEach>
</c:forEach>

<div>
    <span id="memberAccumData"></span>
    <span id="memberAccumData2"></span>
    <form id="memberInfoFrm"></form>
</div>

<!-- detail -->
<form id="member_detailFrm" class="hide"></form>

<script type="text/javascript" src="/js/util/memberUtil.js"></script>
<script type="text/javascript">

    $("#gender").html(util.getCommonCodeRadio(2, gender, "Y"));

    var memWithdrawal = "0";
    var profImgDel;
    var report;
    var memberInfo_responseDate;
    var withdrawal;
    function info_sel_success(dst_id, response) {
        if(response.result == "fail"){
            alert("회원정보 없음");
            return;
        }
        memberInfo_responseDate = response.data;
        profImgDel = "false";
        memNo = response.data.mem_no;

        if (response.data.memState == 3)
            response.data["block"] = " / 정지기간: " + response.data.block_day + " / 정지종료일: " + response.data.blockEndDateFormat;

        if (response.data.memState == 4){
            response.data["memWithdrawal"] = "1";
        }else{
            response.data["memWithdrawal"] = "0";
        }
        response.data["birthData"] = response.data.birthDate.substr(0, 10);
        if(response.data.broadcastState == "ON")
            response.data["icon_broadcastState"] = '<i class="fa fa-circle" style="color: #ff0000;font-size:20px;"></i> ' + response.data.broadcastState;
        else
            response.data["icon_broadcastState"] = '<i class="fa fa-circle" style="color: #000000;font-size:20px;"></i> ' + response.data.broadcastState;

        if(response.data.listeningState == "ON")
            response.data["icon_listeningState"] = '<i class="fa fa-volume-up" style="color: #a037d9;font-size:20px;"></i> ' + response.data.listeningState;
        else
            response.data["icon_listeningState"] = '<i class="fa fa-volume-off" style="color: #000000;font-size:20px;"></i> ' + response.data.listeningState;

        if(response.data.age < 19){
            response.data["adultYn"] = "n";
        } else {
            response.data["adultYn"] = "y";
        }

        response.data["op_code_stop_cnt"] = Number(response.data.op_code_3_cnt) + Number(response.data.op_code_4_cnt) + Number(response.data.op_code_5_cnt);

        var template = $('#tmp_memberInfoFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#memberInfoFrm").html(html);
        init();

        // $("#txt_birth").val(response.data.birthDate);
        $("#memSlct").html(util.renderSlct(response.data.memSlct, "30"));
        report = "/member/member/popup/reportPopup?"
            + "memNo=" + encodeURIComponent(response.data.mem_no)
            + "&memId=" + encodeURIComponent(response.data.userId)
            + "&memNick=" + encodeURIComponent(common.replaceHtml(response.data.nickName))
            + "&memSex=" + encodeURIComponent(response.data.memSex)
            + "&deviceUuid=" + response.data.deviceUuid
            + "&ip=" + response.data.ip;

        if (response.data.memSlct != "p") {
            $("#div_socialId").empty();
            var tmp = '<label>' + response.data.socialId + '</label>';
            $("#div_socialId").append(tmp);
        }
        if (response.data.memState == 4){
            $("#txt_phon").css("display", "none");
        }else{
            $("#txt_phon").css("display", "");
        }

        if (tmp_bt != "bt_adminMemoList" && tmp_bt != "bt_adminMemo") {
            $("#member_detailFrm").html("");
            $("#tablist_con").find('.active').find('a').click();

            var scrollPosition = $("#tabList_top").offset();
            util.scrollPostion(scrollPosition.top);
        }else{
            getAdminMemoList("bt_adminMemoList", "운영자메모");
        }
    }

    function init(){
        $('#date_birth').datetimepicker({
            format: 'L',
            maxDate:new Date(),
            format: "YYYY-MM-DD",
        })
        $('#date_birth').datetimepicker().on('dp.change',function(e){
            var age = Number(moment().format("YYYY")) + 1 - Number( moment($('#txt_birth').val()).format("YYYY"));
            $("#lb_age").html(age + "세");
        })
        // 버튼
        $('#bt_img').click(function() {				 //이미지초기화
            bt_click(this.id);
        });
        $('#bt_bg_img').click(function() {				 //이미지초기화
            bt_click(this.id);
        });
        $('#bt_socialId').click(function() {            //로그인아이디 변경
            // alert('준비중입니다.');
            // return;
            bt_click(this.id);
        });
        $('#bt_phon').click(function() {                //휴대폰 번호 변경
            bt_click(this.id);
        });
        $('#bt_resatNick').click(function() {           //닉네임 변경
            bt_click(this.id);
        });
        $('#bt_birth').click(function() {               //생일 변경
            bt_click(this.id);
        });
        $('#bt_gender').click(function() {              //성별 변경
            bt_click(this.id);
        });
        $('#bt_resatPass').click(function() {           //비밀번호 초기화
            bt_click(this.id);
        });
        $('#bt_adminMemo').click(function() {           //운영자 메모 등록
            bt_click(this.id);
        });
        $("#bt_fanrankOnOffList").click(function(){     //실시간 팬랭킹 미반영
            getInfoDetail(this.id,"실시간 팬랭킹 미반영");
        });
        $('#bt_adminMemoList').click(function() {       //운영자 메모 리스트
            getAdminMemoList(this.id,"운영자메모");
        });
        $('#bt_couponHistory').click(function() {       //운영자 메모 리스트
            getInfoDetail(this.id,"룰렛 응모권");
        });
        $('.bt_connectState').click(function() {         //접속상태
            $("#tab_connectState").click();
            // getInfoDetail('bt_connectState',"접속상태");
        });
        $('#bt_manager').click(function() {             //매니저 자세히
            getInfoDetail(this.id,"(내가 등록한) 매니저");
        });
        $('#bt_black').click(function() {               //블랙리스트 자세히
            getInfoDetail(this.id,"(내가 등록한) 블랙리스트");
        });
        $('#bt_editHistory').click(function() {         //최근정보 내역
            // getInfoDetail(this.id,"정보수정내역");
            tab_click("tab_editHistory_all");
        });
        $('#bt_profileMsg_editHistory').click(function() {         //프로필메시지 수정내역
            // getInfoDetail("bt_editHistory","프로필메시지 수정내역");
            tab_click("tab_editHistory_profileMsg");
        });
        $('#bt_profileImg_editHistory').click(function() {         //프로필이미지 수정내역
            // getInfoDetail("bt_editHistory","프로필이미지 수정내역");
            tab_click("tab_editHistory_profileImg");
        });
        $('#bt_bgImg_editHistory').click(function() {         //방송방배경이미지 수정내역
            // getInfoDetail("bt_editHistory","방송방배경이미지 수정내역");
            tab_click("tab_editHistory_bgImg");
        });
        $('#bt_reportDetail').click(function() {         //회원상태 상세
            $("#tab_declaration").click();
        });
        $('#bt_levelDetail').click(function() {         //레벨 상세
            $("#tab_levelDetail").click();
        });
        $('.bt_report').click(function() {           // 회원상태(경고/정지)
            reportPopup();
        });
        $('#bt_state').click(function() {           // 상태 정상으로 변경
            stateEdit();
        });

        $('#bt_boostAdd').click(function(){         //부스터 변경
           boostAdd(this);
        });

        $('#boostHist').click(function(){         //부스터 상세
            getInfoDetail('bt_boostHist',"부스터 사용내역");
        });

        $('#bt_dalAdd').click(function() {           // 달변경
            dalbyeolAdd("dal");
        });
        $('#bt_byeolAdd').click(function() {           // 달변경
            dalbyeolAdd("byeol");
        });

        $('#bt_pointHistory').click(function() {           // 달/별 변경 자세히보기
            getInfoDetail(this.id,"보유달/별 수정내역");
        });

        $('#bt_broadCastHide').click(function() {           // 방송 숨김상태 변경
            broadCastHide(1);
        });
        $('#bt_broadCastHideCancel').click(function() {           // 방송 숨김상태 해제
            broadCastHide(0);
        });

        $('#bt_forcedEnd').click(function() {           // 방송 강제종료
            forcedEnd();
        });

        $("#bt_userName").click(function() {        // 이름 변경
            bt_click(this.id);
        });

        $("#bt_profileMsg_del").click(function() {        // 이름 변경
            bt_click(this.id);
        });

        // 버튼 끝
        var data = {
            mem_no : memNo,
        };
        util.getAjaxData("info", "/rest/member/member/accumData", data, info_accumData_success, fn_fail);
    }

    function info_accumData_success(dst_id, response){
        var template = $('#tmp_memberAccumData').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#memberAccumData").html(html);

        var template = $('#tmp_memberAccumData2').html();
        var templateScript = Handlebars.compile(template);
        var goodTotal = response.data.goodCnt + response.data.boostCnt * 10
        response.data.goodTotal = goodTotal;
        var context = response.data;
        var html = templateScript(context);
        $("#memberAccumData2").html(html);

        ui.paintColor();
        ui.tableHeightSet();

    }

    var tmp_bt;
    function bt_click(tmp) {
        tmp_bt = tmp;
        var obj = new Object();
        // 이전 데이터 추가
        obj.beforeMemberData = JSON.stringify(memberInfo_responseDate);
        if (memNo == "unknown") {
            alert("변경대상 회원을 선택해 주십시오.");
            return;
        }
        if (tmp == "bt_adminMemo") {            //운영자 메모 변경
            if (common.isEmpty($("#txt_adminMemo").val())) {
                alert("등록할 운영자 메모를 입력해 주십시오.");
                return;
            }
            obj.mem_no = memNo;
            obj.memo = $("#txt_adminMemo").val();
            util.getAjaxData("adminMemoAdd", "/rest/member/member/adminMemoAdd", obj, adminMemo_success, fn_fail);
        } else if(tmp == "bt_socialId" ){       // 로그인ID변경
            if (common.isEmpty($("#txt_socialId").val())) {
                alert("로그인 아이디를 입력해 주십시오.");
                return;
            }
            if(memberInfo_responseDate.socialId == $("#txt_socialId").val()){
                alert("동일한 로그인 아이디 입니다. 변경할 아이디를 입력해 주세요.");
                return;
            }
            if(confirm("로그인 아이디를 변경 하시겠습니까?")) {
                obj.mem_no = memNo;
                obj.socialId = $("#txt_socialId").val().replace(/-/gi, "");
                obj.before_socialId = memberInfo_responseDate.socialId;
                util.getAjaxData("editor", "/rest/member/member/socialId_edit", obj, update_success, fn_fail);
            }else return;
        }else{
            var sendNoti;
            obj.mem_no = memNo;
            if(tmp == "bt_img"){                        //사진초기화
                if(common.isEmpty(memberInfo_responseDate.profileImage)){
                    alert("이미 초기화된 프로필 이미지 입니다. 프로필 초기화가 불가능합니다.");
                    return;
                }
                if(confirm("프로필 이미지를 초기화 하시겠습니까?")){
                    sendNoti = 1;
                    obj.notiContents = memberMessage.profileReset;
                    obj.notiMemo = memberMessage.profileReset;
                    // sockat set
                    obj.profileImage = "";
                    obj.memSex = $('input[name="memSex"]:checked').val();
                    obj.beforNickName = memberInfo_responseDate.nickName;
                }else return;

            }else if(tmp == "bt_bg_img"){                        //배경사진초기화
                if(memberInfo_responseDate.broadcastState != "ON"){
                    alert("종료된 방송방은 수정이 불가능 합니다.");
                    return;
                }

                if(memberInfo_responseDate.roomBgImage.indexOf("/bg_3/roombg") > -1){
                    alert("이미 기본 배경이미지 입니다.");
                    return;
                }

                if(confirm("방송방 배경 이미지를 초기화 하시겠습니까?")){
                    obj.mem_no = memNo;
                    obj.room_no = memberInfo_responseDate.room_no;

                    util.getAjaxData("initBgImg", "/rest/member/member/initBgImg", obj, member_update_success, fn_fail);
                    return;
                }else return;

            }else if(tmp == "bt_resatPass"){
                if(common.isEmpty($("#txt_phon").val().replace(/-/gi, ""))){
                    alert("전화번호를 입력해 주십시오.");
                    return;
                }
                var tmp_phone = $("#txt_phon").val().replace(/-/gi, "");
                console.log(tmp_phone);
                if (tmp_phone.substring(0, 3) != "010" || (tmp_phone.length > 11 || tmp_phone.length < 10)) {
                    alert("전화번호를 정확히 입력해 주십시오.");
                    return;
                }

                //비밀번호 변경 후 문자 보내기
                if (confirm($("#bt_resatPass").data('nickname') + memberMessage.passwordReset)) {
                    obj.passwdReset = "Reset";
                    obj.phoneNum = tmp_phone;                   //0
                    sendNoti = 0;
                    obj.notiContents = memberMessage.passwordResetSms;
                    obj.notiMemo = memberMessage.passwordResetSms;
                }else return;
            }else if(tmp == "bt_resatNick"){
                if(memberInfo_responseDate.nickName == $("#td_userid").data("userid")){
                    alert("이미 초기화된 닉네임 입니다. 닉네임 초기화가 불가능합니다.");
                    return;
                }
                if(confirm("닉네임을 초기화 하시겠습니까?")) {
                    sendNoti = 1;
                    obj.notiContents = memberMessage.nickNameReset;
                    obj.notiMemo = memberMessage.nickNameReset;

                    // sockat set
                    obj.profileImage = memberInfo_responseDate.profileImage;
                    obj.memSex = $('input[name="memSex"]:checked').val();
                    obj.nickName = $("#td_userid").data("userid");
                }else return;
            }else if(tmp == "bt_phon"){
                if(common.isEmpty($("#txt_phon").val().replace(/-/gi, ""))){
                    alert("전화번호를 입력해 주십시오.");
                    return;
                }
                if(memberInfo_responseDate.phoneNum == $("#txt_phon").val().replace(/-/gi, "")){
                    alert("동일한 전화번호 입니다. 변경할 전화번호를 입력해주세요.");
                    return;
                }
                var tmp_phone = $("#txt_phon").val().replace(/-/gi, "");
                if (tmp_phone.substring(0, 3) != "010" || (tmp_phone.length > 11 || tmp_phone.length < 10)) {
                    alert("전화번호를 정확히 입력해 주십시오.");
                    return;
                }

                if(confirm("연락처를 변경 하시겠습니까?")) {
                    obj.phoneNum = tmp_phone;                   //0
                    sendNoti = 0;
                }else return;
            }else if(tmp == "bt_birth"){
                if(memberInfo_responseDate.birthDate.substr(0, 10) == $("#txt_birth").val()){
                    alert("생년월일을 변경해주세요.");
                    return;
                }
                if(confirm("생년월일을 변경 하시겠습니까?")) {
                    obj.birthDate = $("#txt_birth").val();
                    sendNoti = 0;
                }else return;
            }else if(tmp == "bt_gender"){
                if(memberInfo_responseDate.memSex == $('input[name="memSex"]:checked').val()){
                    alert("성별을 변경해 주세요.");
                    return;
                }
                if(memberInfo_responseDate.memSex != "n" && $('input[name="memSex"]:checked').val() == "n"){
                    alert("성별을 알수없음으로 변경이 불가능합니다.");
                    return false;
                }
                if(confirm("성별을 변경 하시겠습니까?")) {
                    obj.photoUrl = PHOTO_SERVER_URL;
                    sendNoti = 2;
                    obj.notiContents = memberMessage.profileReset;
                    obj.notiMemo = memberMessage.profileReset;

                    // sockat set
                    obj.profileImage = memberInfo_responseDate.profileImage;
                    obj.memSex = $('input[name="memSex"]:checked').val();
                    obj.beforNickName = memberInfo_responseDate.nickName;
                }else return;
            }else if(tmp == "bt_userName"){
                if(common.isEmpty($("#txt_userName").val())){
                    alert("이름을 입력해 주십시오.");
                    return;
                }
                if(memberInfo_responseDate.userName == $("#txt_userName").val()){
                    alert("동일한 이름 입니다. 변경할 이름을 입력해주세요.");
                    return;
                }

                if(confirm("이름을 변경 하시겠습니까?")) {
                    obj.name = $("#txt_userName").val();                   //0
                    sendNoti = 0;
                }else return;
            }else if(tmp == "bt_profileMsg_del"){       // 프로필 메시지 변경
                if(common.isEmpty(memberInfo_responseDate.profileMsg)){
                    alert("프로필 메시지가 없습니다");
                    return;
                }
                if(confirm("프로필 메시지를 삭제 하시겠습니까?")) {
                    sendNoti = 1;
                    obj.profileMsg = "";
                    obj.notiContents = memberMessage.profileMsgReset;
                    obj.notiMemo = memberMessage.profileMsgReset;
                }else return;
            }
            obj.beforProfileImage = memberInfo_responseDate.profileImage;
            obj.sendNoti=sendNoti;

            util.getAjaxData("editor", "/rest/member/member/editor", obj, member_update_success, fn_fail);
        }
    }

    function adminMemo_success(dst_id, response) {
        alert(response.message);
        getMemNo_info_reload(memNo)
    }
    function member_update_success(dst_id, response) {
        if(response.code == 0){
            if (tmp_bt == "bt_img" || tmp_bt == "bt_bg_img") {                        //사진변경
                alert("프로필 이미지가 초기화 되었습니다.");
            } else if (tmp_bt == "bt_phon") {                 //휴대폰 번호 변경
                if(response == 0){
                    alert("비정상적인 연락처 입니다. 연락처를 확인 해주십시오.");ㅅ
                    return;
                }
                alert("연락처가 변경되었습니다.");
            } else if (tmp_bt == "bt_resatNick") {            // 닉네임 변경
                alert("닉네임이 변경되었습니다.");
            } else if (tmp_bt == "bt_birth") {                //생일 변경
                alert("생년월일이 변경되었습니다.");
            } else if (tmp_bt == "bt_gender") {               //성별 변경
                alert("성별이 변경되었습니다.");
            } else if (tmp_bt == "bt_resatPass") {            //비밀번호 초기화
                if(response == 0){
                    alert("비정상적인 연락처 입니다. 연락처를 확인 해주십시오.");
                    return;
                }
                alert("비밀번호가 초기화 되었습니다.");
            } else if (tmp_bt == "bt_socialId") {            //비밀번호 초기화
                if(response.code == "1"){
                    alert(response.message);
                }else{
                    alert("로그인 아이디가 변경되었습니다.");
                }
            }
        }else{
            alert(response.message);
        }

        getMemNo_info_reload(memNo);
    }
    function getMemNo_info_reload(memNo){
        var data = new Object;
        data.mem_no = memNo;

        util.getAjaxData("info", "/rest/member/member/info", data, info_sel_success, fn_fail);
    }
    function reportPopup(){
        console.log(report);
        util.windowOpen(report,"750","885","경고/정지");
    }

    function fnChkByte(obj) {
        var maxByte = 11; //최대 입력 바이트 수
        var str = obj.value;
        var str_len = str.length;
        var rbyte = 0;
        var rlen = 0;
        var one_char = "";
        var str2 = "";
        for (var i = 0; i < str_len; i++) {
            one_char = str.charAt(i);
            if (escape(one_char).length > 4) {
                rbyte += 2; //한글2Byte
            } else {
                rbyte++; //영문 등 나머지 1Byte
            }
            if (rbyte <= maxByte) {
                rlen = i + 1; //return할 문자열 갯수
            }
        }
        if (rbyte > maxByte) {
            str2 = str.substr(0, rlen); //문자열 자르기
            obj.value = str2;
            fnChkByte(obj, maxByte);
        }
    }

    function getInfoDetail(buttonId, tabName) {     // 상세보기

        var template = $('#tmp_member_detailFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#member_detailFrm").html(templateScript);

        $('#tab_memberInfoDetail').text(tabName);           //텝 이름 변경
        $('#member_detailFrm').addClass("show");
        if(buttonId.indexOf("_") > 0){ buttonId = buttonId.split("_"); buttonId = buttonId[1]; }

        console.log(buttonId);

        var source = MemberDataTableSource[buttonId];
        console.log(source);
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            if(buttonId == "connectState"){
                data.sortDate = "1";
            }else if(buttonId == "manager" || buttonId == "black" ){
                data.slctType = "1";
            }
        }
        console.log(dtList_info_detail_data)
        console.log(source)
        dtList_info_detail = new DalbitDataTable($("#info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.createDataTable();

        if(buttonId == "manager" || buttonId == "black"){
            $('#detail2').addClass("show");
            getInfoDetail2(buttonId);
        }

        var scrollPosition = $("#tab_infoDetail").offset();
        util.scrollPostion(scrollPosition.top);
    }
    function getInfoDetail2(buttonId){
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.slctType = "2";
        }
        if(buttonId == "manager") {
            $('#tab_memberInfoDetail2').text("(나를 등록한) 매니저");           //텝 이름 변경
            var source = MemberDataTableSource["meManager"];
        }else if(buttonId == "black") {
            $('#tab_memberInfoDetail2').text("(나를 등록한) 블랙리스트");           //텝 이름 변경
            var source = MemberDataTableSource["meBlack"];
        }

        dtList_info_detail = new DalbitDataTable($("#info_detail2"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.createDataTable();
    }

    var dtMemoList;

    var inputSearchMemoSlct = 1;
    function getAdminMemoList(buttonId,tabName) {     // 상세보기
        var template = $('#tmp_member_detailFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#member_detailFrm").html(templateScript);

        $('#tab_memberInfoDetail').text(tabName);           //텝 이름 변경
        $('#member_detailFrm').addClass("show");
        if(buttonId.indexOf("_") > 0){ buttonId = buttonId.split("_"); buttonId = buttonId[1]; }

        console.log(buttonId);

        var source = MemberDataTableSource[buttonId];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.memoSlct = inputSearchMemoSlct;
        };
        console.log(source)
        dtMemoList = new DalbitDataTable($("#info_detail"), dtList_info_detail_data, source);
        dtMemoList.useCheckBox(true);
        dtMemoList.useIndex(true);
        dtMemoList.createDataTable();

        var scrollPosition = $("#tab_infoDetail").offset();
        util.scrollPostion(scrollPosition.top);

        var adminMemoDel = '<input type="button" value="삭제" class="btn btn-danger btn-sm" id="btn_adminMemoDel" style="margin-right: 3px;"/>';
        $("#memberInfoDetail").find(".footer-left").append(adminMemoDel);

        $("#tab_adminMemo").show();

        adminMemoDelInit();
    }
    function adminMemoDelInit(){
        $("#btn_adminMemoDel").on("click", function () { //운영자 메모 삭제
            adminMemoDel();
        });
    }

    function adminMemoSubTabClick(memoSlct){
        inputSearchMemoSlct = memoSlct;
        dtMemoList.reload();

        var scrollPosition = $("#tab_infoDetail").offset();
        util.scrollPostion(scrollPosition.top);
    }

    function adminMemoDel(){
        if(dtMemoList.getCheckedData().length <= 0){
            alert("삭제할 메모를 선택해 주세요.");
            return;
        }
        var data = {};
        console.log(dtMemoList.getCheckedData()[0].memNo);
        data.mem_no = memNo;
        data.delList =  dtMemoList.getCheckedData();
        console.log(data);
        util.getAjaxData("adminMemoDel", "/rest/member/member/admin/memoDel",data, function(){
            dtMemoList.reload();
        });
    }

    function getCouponHistory(buttonId,tabName) {     // 상세보기
        var template = $('#tmp_member_detailFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#member_detailFrm").html(templateScript);

        $('#tab_memberInfoDetail').text(tabName);           //텝 이름 변경
        $('#member_detailFrm').addClass("show");
        if(buttonId.indexOf("_") > 0){ buttonId = buttonId.split("_"); buttonId = buttonId[1]; }

        console.log(buttonId);

        var source = MemberDataTableSource[buttonId];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.memoSlct = inputSearchMemoSlct;
        };
        console.log(source)
        dtMemoList = new DalbitDataTable($("#info_detail"), dtList_info_detail_data, source);
        dtMemoList.useCheckBox(true);
        dtMemoList.useIndex(true);
        dtMemoList.createDataTable();

        var scrollPosition = $("#tab_infoDetail").offset();
        util.scrollPostion(scrollPosition.top);

        var adminMemoDel = '<input type="button" value="삭제" class="btn btn-danger btn-sm" id="btn_adminMemoDel" style="margin-right: 3px;"/>';
        $("#memberInfoDetail").find(".footer-left").append(adminMemoDel);

    }

    function stateEdit() {
        if(confirm("상태를 정상으로 변경 하시겠습니까?")) {
            var obj = new Object();
            obj.mem_no = memNo;
            util.getAjaxData("editor", "/rest/member/member/state_edit", obj, function(dst_id, response){
                getMemNo_info_reload(memNo);
            });
        }return false;
    }

    $(document).on('click', 'input:radio[name="memSex"]', function(title, content){
        if(memberInfo_responseDate.memState == 4){
            return false;
        }
        if(memberInfo_responseDate.memSex != "n" && $('input[name="memSex"]:checked').val() == "n"){
            alert("성별을 알수 없음으로 변경이 불가능합니다.");
            return false;
        }
    });

    function boostAdd(btn){
        var boostCnt = $('#txt_boostAddCnt');

        if(common.isEmpty(boostCnt.val())){
            alert('부스터 갯수를 입력해주세요.');
            boostCnt.focus();
            return;
        }else if(isNaN(boostCnt.val())){
            alert('부스터 갯수는 숫자로만 입력해주세요.');
            boostCnt.focus();
            return;
        }

        if($('#boostPlusMinus').val() == '3' && $(btn).data('boostcnt') < Number(boostCnt.val())){
            alert('보유수량보다 많은 수량을 차감할 수 없습니다.');
            return;
        }

        if($('#boostPlusMinus').val() == '1' && 9999 < Number($(btn).data('boostcnt')) + Number(boostCnt.val())){
            alert('아이템 갯수는 9999까지만 가능합니다.');
            return;
        }

        var msg = '부스터 ' + boostCnt.val() +'개를 지급하시겠습니까?';
        var dst_id = 'boostAdd';
        if($('#boostPlusMinus').val() == '3'){
            msg = '부스터 ' + boostCnt.val() +'개를 차감하시겠습니까?';
            dst_id = 'boostSubtract';
        }

        if(confirm(msg)){
            var data = {
                mem_no : $(btn).data('memno')
                , itemType : 1
                , slctType : $('#boostPlusMinus').val()
                , itemCnt : boostCnt.val()
            }

            util.getAjaxData(dst_id, "/rest/member/member/boostItemChange", data, function(dst_id, response){
                var responseMsg = '부스터 ' + boostCnt.val() + '개를 지급하였습니다.';
                if($('#boostPlusMinus').val() == '3'){
                    responseMsg = '부스터 ' + boostCnt.val() + '개를 차감하였습니다.';
                }
                alert(responseMsg);
                location.reload();
            });
        }
    }

    function dalbyeolAdd(tmp){
        var data = new Object();
        data.mem_no = memNo;

        if(tmp == "dal" ){
            if($("#sp_dalPointEdit").find("select[name='pointEditStory']").val() == "-1"){
                alert("달 변경 사유를 선택해 주세요.");
                return;
            }
            if($("#txt_dalAddCnt").val() == ""){
                alert("달 수 를 입력해주세요");
                return;
            }
            if($("select[name='dalPlusMinus']").val() == 2){
                if(memberInfo_responseDate.totalDal < $("#txt_dalAddCnt").val()){
                    alert("적용할 수 없는 수치입니다.");
                    return;
                }
                data.addDalCnt = "-" + $("#txt_dalAddCnt").val();
            }else{
                data.addDalCnt = $("#txt_dalAddCnt").val();
            }
            if(confirm($("#txt_dalAddCnt").val() + "달을 변경하시겠습니까?")) {
                // if($("#sp_dalPointEdit").find("select[name='pointEditStory']").val() == '2'){
                //     data.type = '7'
                // }else{
                //     data.type = '12'
                // }
                data.type = $("#sp_dalPointEdit").find("#pointEditStory option:checked").val();

                data.pointEditStroy=$("#sp_dalPointEdit").find("#pointEditStory option:checked").text();
                util.getAjaxData("dalAdd", "/rest/member/member/daladd", data, dalbyeoladd_success, fn_fail);
            } else return;
        }else if(tmp == "byeol"){
            if($("#sp_byeolPointEdit").find("select[name='pointEditStory']").val() == "-1"){
                alert("달 변경 사유를 선택해 주세요.");
                return;
            }
            if($("#txt_byeolAddCnt").val() == ""){
                alert("별 수 를 입력해주세요");
                return;
            }
            if($("select[name='byeolPlusMinus']").val() == 2){
                if(memberInfo_responseDate.byeol < $("#txt_byeolAddCnt").val()){
                    alert("적용할 수 없는 수치입니다.");
                    return;
                }
                data.addByeolCnt = "-" + $("#txt_byeolAddCnt").val();
            }else{
                data.addByeolCnt = $("#txt_byeolAddCnt").val();
            }

            if(confirm($("#txt_byeolAddCnt").val() + "별을 변경하시겠습니까?")) {
                // if($("#sp_byeolPointEdit").find("select[name='pointEditStory']").val() == '2'){
                //     data.type = '4'
                // }else{
                //     data.type = '6'
                // }
                data.type = $("#sp_byeolPointEdit").find("#pointEditStory option:checked").val();

                data.pointEditStroy=$("#sp_byeolPointEdit").find("#pointEditStory option:checked").text();
                util.getAjaxData("byeoladd", "/rest/member/member/byeoladd", data, dalbyeoladd_success, fn_fail);

            }else return;
        }
    }

    function dalbyeoladd_success(dst_id, response) {
        if(response.code == "0"){
            alert("지급이 정상 처리 되었습니다.");
        }else{
            alert(response.message);
        }
        var obj = new Object();
        obj.mem_no = memNo;
        obj.memWithdrawal = memWithdrawal;
        util.getAjaxData("info", "/rest/member/member/info", obj, info_sel_success, fn_fail);
    }

    function broadCastHide(hide){
        var tmp;
        if(hide == 1)
            tmp = "방송방 숨김 처리 하시겠습니까?";
        else
            tmp = "방송방 숨김 해제 하시겠습니까?";

        if(confirm(tmp)) {
            var data = {};
            data.mem_no = memNo;
            data.hide = hide;
            data.room_no = memberInfo_responseDate.room_no;
            data.title = memberInfo_responseDate.title
            util.getAjaxData("info", "/rest/member/member/update/broadCastHide", data, broadcast_hide_success, fn_fail);
        }else return;
    }

    function broadcast_hide_success(dst_id, response) {
        if(response.code != 0){
            alert(response.message);
            return;
        }
        getMemNo_info_reload(memNo);
    }

    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }

    function forcedEnd(){
        if(confirm("방송강제 종료 시도 하시겠습니까?")){
            var data = {};
            data.mem_no = memNo;
            util.getAjaxData("forcedEnd", "/rest/member/broadcast/forcedEnd",data, forced_success);
        }
    }

    function forcedListenExit(){
        if(confirm("청취강제 종료 시도 하시겠습니까?")) {
            var data = {};
            data.mem_no = memNo;
            util.getAjaxData("forcedExit", "/rest/member/listen/forcedExit", data, forced_success);
        }
    }

    $(document).on('click', '#bt_listenExit', function(){
        var listen_title = $(this).data('listen_title');
        var listen_room_no = $(this).data('listen_room_no');
        if(confirm(listen_title + "방 청취를 종료 하시겠습니까?")) {
            var data = {};
            data = {
                mem_no : memNo
                , room_no : listen_room_no
            }
            util.getAjaxData("forcedExit", "/rest/member/listen/forcedExit", data, forced_success);
        }
    });

    function forced_success(dst_id, response) {
        alert(response.message);
        getAdminMemoList("bt_adminMemoList", "운영자메모");
    }

    //법정대리인 동의정보
    $(document).on('click', '#bt_agree_info', function(){

        var detailData = {};
        detailData.memNo = memNo

        util.getAjaxData("parents", "/rest/member/member/parents", detailData, fn_succ_parents_detail);
    });

    function fn_succ_parents_detail(dist_id, response){
        var template = $('#tmp_layer_detail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detail;
        var html = templateScript(context);
        $("#detailView").html(html);

        showModal();
    }

    function showModal(){
        $("#showModal").click();
    }

    function closeModal(){
        $("#layerCloseBtn").click();
    }

    //법정대리인(보호자) 동의 철회
    $(document).on('click', '#bt_recant', function(){

        var result = confirm("법정대리인의 보호자 동의를 철회하시는 경우\n해당 회원은 추 후 법정대리인 동의를 다시 받아야 합니다.\n법정대리인(동의)를 철회하시겠습니까?");
        if(result){
            var detailData = {};
            detailData.memNo = memNo

            util.getAjaxData("recant", "/rest/member/member/recant", detailData, fn_succ_recant);
        }

    });

    //법정대리인(보호자) 동의 복귀
    $(document).on('click', '#bt_back_recant', function(){

        var result = confirm("법정대리인(동의)를 복귀하시겠습니까?");
        if(result){
            var detailData = {};
            detailData.memNo = memNo

            util.getAjaxData("backrecant", "/rest/member/member/back/recant", detailData, fn_succ_back_recant);
        }
    });

    $(document).on('click', '#bt_cancel_cert', function(){
        var data = {
            memNo : memNo
        }
        util.getAjaxData("cancelCert", "/rest/member/member/cancel/cert", data, function(dst_id, response){
            alert("본인인증 정보가 철회되었습니다.");
            getMemNo_info_reload(memNo);
        });
    });

    $(document).on('click', '#bt_rollback_cert', function(){
        var data = {
            memNo : memNo
        }
        util.getAjaxData("cancelCert", "/rest/member/member/rollback/cert", data, function(dst_id, response){
            alert("본인인증 정보가 복귀되었습니다.");
            getMemNo_info_reload(memNo);
        });
    });

    //수동인증
    $(document).on('click', '#bt_auth', function(){
        var data = {
            memNo : memNo
            , userName : memberInfo_responseDate.userName
            , phoneNo : memberInfo_responseDate.phoneNum
            , birth : memberInfo_responseDate.birthData
            , userId : memberInfo_responseDate.userId
            , memSex : memberInfo_responseDate.memSex
        }
        console.log("수동인증", data);
        util.getAjaxData("insertAuth", "/rest/member/member/auth", data, function(dst_id, response){
            alert("수동으로 인증정보를 추가하였습니다.");
            getMemNo_info_reload(memNo);
        });

    });


    function fn_succ_recant(){
        alert("법정대리인(동의)를 철회하였습니다.");
        getMemNo_info_reload(memNo);
    }

    function fn_succ_back_recant() {
        alert("법정대리인(동의)를 복귀하였습니다.");
        getMemNo_info_reload(memNo);
    }

    $(document).on('click','#bt_profileAlbum', function (){
        report = "/member/member/popup/albumPopup?memNo=" + memNo
                + "&memNick=" + encodeURIComponent(memberInfo_responseDate.nickName)
                + "&memSex=" + encodeURIComponent(memberInfo_responseDate.memSex)
        ;
        util.windowOpen(report,"1000","800","프로필목록");
    })


</script>

<script id="tmp_memberInfoFrm" type="text/x-handlebars-template">

    <table class="table table-bordered table-dalbit borderBlack" style="margin-bottom: 0px;">
        <colgroup>
            <col width="6%"/>
            <col width="18%"/>
            <col width="6%"/>
            <col width="18%"/>
            <col width="6%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="9%"/>
            <col width="4%"/>
        </colgroup>
        <tbody>
        <tr>
            <th rowspan="5">
                프로필<br>이미지
                {{#equal memWithdrawal '0'}}
                <br><button type="button" id="bt_img" class="btn btn-default btn-sm no-margin" style="margin-left: 10px" data-memno="{{mem_no}}" data-nickname="{{nickName}}">초기화</button>
                <br><button type="button" id="bt_profileImg_editHistory" class="btn btn-default btn-sm">상세</button>
                {{/equal}}
            </th>
            <td rowspan="5">
                <div class="col-md-8 no-padding">
                    <form id="profileImg" method="post" enctype="multipart/form-data">
                        <img id="image_section" class="thumbnail fullSize_background no-padding" src="{{renderProfileImage profileImage memSex}}" alt="your image" style="width: 150px;height: 150px" />
                    </form>
                </div>
                <div class="col-md-2 no-padding">
                    <button type="button" id="bt_profileAlbum" class="btn btn-default btn-sm mt5">상세</button>
                </div>
            </td>
            <th rowspan="5">
                방송방<br>배경이미지
                {{#equal memWithdrawal '0'}}
                <br><button type="button" id="bt_bg_img" class="btn btn-default btn-sm no-margin" style="margin-left: 10px" data-memno="{{mem_no}}" data-nickname="{{nickName}}">초기화</button>
                <br><button type="button" id="bt_bgImg_editHistory" class="btn btn-default btn-sm mt5">상세</button>
                {{/equal}}
            </th>
            <td rowspan="5">
                <form id="bgImg" method="post" enctype="multipart/form-data">
                    <img id="image_bg_section" class="thumbnail fullSize_background no-padding" src="{{renderProfileImage roomBgImage memSex}}" alt="your image" style="width: 150px;height: 150px" />
                </form>
            </td>
        </tr>
        <tr>
            <th>회원레벨</th>
            <td style="text-align: left">{{level}} 레벨</td>
            <th>레벨등급</th>
            <td colspan="2" style="text-align: left">{{grade}}</td>
            <th>경험치</th>
            <td style="text-align: left;border-right-color:white;border-right-width:0px;">{{addComma exp}}({{substr expPer '0' '5'}}%)</td>
            <td>
                <button type="button" class="btn btn-default btn-sm pull-right" id="bt_levelDetail">상세</button>
            </td>
        </tr>
        <tr>
            <th>회원상태</th>
            <td style="text-align: left">
                {{#dalbit_if memState '==' 5}}
                    {{#dalbit_if block_type '==' 1}}
                        임시정지
                    {{else}}
                        <span {{#dalbit_if memState '==' 7}} style="color:blue" {{/dalbit_if}}>{{{getCommonCodeLabel memState 'mem_state'}}}</span>
                    {{/dalbit_if}}
                {{else}}
                    <span {{#dalbit_if memState '==' 7}} style="color:blue" {{/dalbit_if}}>{{{getCommonCodeLabel memState 'mem_state'}}}</span>
                {{/dalbit_if}}
            </td>
            <td colspan="4" style="text-align: center;">
                <%--{{{block}}}--%>
                경고 : {{op_code_2_cnt}}회,  정지 : {{op_code_stop_cnt}}회,  영구정지 : {{op_code_6_cnt}}회
            </td>
            <td colspan="2" style="border-right-color:white;border-right-width:0px;">
                {{#equal memWithdrawal '0'}}
                <button type="button" class="btn btn-default btn-sm pull-left bt_report">경고/정지</button>
                {{/equal}}
                <button type="button" class="btn btn-info btn-sm pull-left ml5" id="bt_state">정상변경</button>
                <button type="button" class="btn btn-default btn-sm pull-right" id="bt_reportDetail">상세</button>
            </td>
        </tr>
        <tr>
            <th>접속정보</th>
            <td colspan="5" style="text-align: left;">
                <span>
                    * MobileID : {{deviceUuid}} <br>
                    * IP : {{ip}} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 접속기기 : {{deviceModel}}<br>
                    * 접속상태 : {{connectState}}
                </span>
            </td>
            <td colspan="2" style="border-right-color:white;border-right-width:0px;">
                <button type="button" class="btn btn-danger btn-sm pull-left bt_report">기기 차단</button>
                <button type="button" class="btn btn-danger btn-sm pull-left bt_report ml5">IP 차단</button>

                <button type="button" class="btn btn-default btn-sm pull-right bt_connectState">상세</button>
            </td>
            <%--<span class="pr15 pl15"></span>--%>
            <%--<span class="pr15 pl15">* 접속상태 : {{connectState}}</span>--%>
            <%--<button type="button" class="btn btn-default btn-sm pull-right bt_connectState">자세히</button>--%>
            <%--<button type="button" class="btn btn-danger btn-sm pull-right bt_report">기기 차단</button>--%>
            <%--<button type="button" class="btn btn-default btn-sm pull-right bt_connectState">자세히</button>--%>
            <%--<button type="button" class="btn btn-danger btn-sm pull-right bt_report">IP 차단</button>--%>
        </tr>
        <tr>
            <th>최초<br>방송일시</th>
            <td colspan="3" style="text-align: left">{{firstBroadcastDate}}</td>
            <th>최근<br>방송일시</th>
            <td colspan="3" style="text-align: left">{{lastBroadcastDate}}</td>
        </tr>
        <tr>
            <th rowspan="2">프로필<br>메시지</th>
            <td rowspan="2" colspan="3" style="text-align: left" id="memberProfileMsg">
                <span style="display:inline-block;width:65%" id="profileMsg">{{profileMsg}}</span>
                <button type="button" id="bt_profileMsg_editHistory" class="btn btn-default btn-sm pull-right ml5">상세</button>
                <button type="button" id="bt_profileMsg_del" class="btn btn-default btn-sm pull-right " style="background-color: #46B0CF; border-color: #46B0CF">삭제</button>
            </td>
            <th>방송상태</th>
            <td colspan="3" style="text-align: left;{{#dalbit_if type_media '==' 'v'}} background-color: #fbe5d6 {{/dalbit_if}} ">
                {{{icon_broadcastState}}}
                {{#equal broadcastState 'ON'}}
                - 방송제목 : {{{roomNoLink ../title ../room_no}}}
                {{/equal}}
                {{#dalbit_if type_media '==' 'a'}}
                    <img src="https://image.dalbitlive.com/svg/ico_live_audio.svg" alt="your image" style="width: 33px;height: 33px" />
                {{/dalbit_if}}
                {{#dalbit_if type_media '==' 'v'}}
                    <img src="https://image.dalbitlive.com/svg/ico_live_video_b.svg" alt="your image" style="width: 33px;height: 33px" />
                {{/dalbit_if}}
            </td>
            <th>마이크</th>
            <td colspan="2" style="border-right-color:white;border-right-width:0px;">
                {{#dalbit_if micState '==' 'ON'}}
                    <i class="fa fa-microphone" style="color: #a037d9;font-size:20px;"></i>{{micState}}
                {{else}}
                    <i class="fa fa-microphone-slash" style="color: #000000;font-size:20px;"></i>{{micState}}
                {{/dalbit_if}}
            </td>
            <td>
                <button type="button" id="bt_forcedEnd" class="btn btn-danger btn-sm pull-right">방송강제종료</button>
                {{#equal broadcastState 'ON'}}
                {{#equal ../hide 0}}
                <button type="button" id="bt_broadCastHide" class="btn btn-info btn-sm pull-right">방송방 숨김</button>
                {{/equal}}
                {{#equal ../hide 1}}
                <button type="button" id="bt_broadCastHideCancel" class="btn btn-info btn-sm pull-right">방송방 숨김 해제</button>
                {{/equal}}
                {{/equal}}
            </td>
        </tr>
        <tr>
            <th>청취상태</th>
            <td colspan="6" style="text-align: left;border-right-color:white;border-right-width:0px;">
                {{{icon_listeningState}}}
                {{#equal listeningState 'ON'}}
                - 방송제목 : {{{roomNoLink ../listen_title ../listen_room_no}}}
                <button type="button" id="bt_listenExit"
                        class="btn btn-danger btn-sm pull-right"
                        data-listen_title="{{../listen_title}}"
                        data-listen_room_no="{{../listen_room_no}}">청취종료</button>
                {{/equal}}
            </td>
            <td>
                <button type="button" id="bt_forcedExit" class="btn btn-danger btn-sm pull-right" onclick="forcedListenExit();">청취강제종료</button>
            </td>
        </tr>
        <tr>
            <th>회원No</th>
            <td style="text-align: left" id="memberNo">{{mem_no}}</td>
            <th>UserID</th>
            <td style="text-align: left" id="td_userid" data-userid="{{userId}}">
                {{userId}}<br>
            </td>
            <th>클립 등록</th>
            <td colspan="3"><a href="javascript: $('#tab_clipList').click();">{{addComma clipCnt}} 건</a></td>
            <th>클립 청취</th>
            <td colspan="3"><a href="javascript: $('#tab_clipListenList').click();">{{addComma clipPlayCnt}} 건 ( {{addComma clipListenCnt}} 건)</a></td>
        </tr>
        <tr>
            <th>닉네임</th>
            <td style="text-align: left;">
                {{nickName}}
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_resatNick" class="btn btn-default btn-sm pull-right" data-memno="{{mem_no}}" data-nickname="{{nickName}}" data-userId="{{userId}}">초기화</button>
                {{/equal}}
            </td>
            <%--<td colspan="2">--%>
            <th>내/외국인</th>
            <td style="text-align: left">{{local}}</td>
            <%--</td>--%>
            <th>보유달</th>
            <td colspan="6" style="text-align: left;">
                <span class="col-md-5 no-padding">
                    <span class="font-bold">{{addComma totalDal}}</span> 달 (구매 : {{addComma money}} 달 / 무료 : {{addComma dal}} 달)
                </span>
                <c:if test="${insertYn eq 'Y'}">
                    {{#equal memWithdrawal '0'}}
                    <span class="col-md-7 no-padding" id="sp_dalPointEdit">
                            <select id="dalPlusMinus" name="dalPlusMinus" class="form-control searchType">
                                <option value="1">+</option>
                                <option value="2">-</option>
                            </select>
                            <input type="text" class="form-control" id="txt_dalAddCnt" style="width: 100px">
                            {{{getCommonCodeSelect pointEditStory 'dalPointEditStory' 'Y' 'pointEditStory'}}}
                            <button type="button" id="bt_dalAdd" class="btn btn-default btn-sm" data-memno="{{mem_no}}">변경</button>
                        </span>
                    {{/equal}}
                </c:if>
            </td>
            <td rowspan="2">
                <c:if test="${readYn eq 'Y'}">
                    <button type="button" id="bt_pointHistory" class="btn btn-default btn-sm pull-right">상세</button>
                </c:if>
            </td>
        </tr>
        <tr>
            <th>이름</th>
            <td>
                <input type="text" class="form-control" id="txt_userName" value="{{userName}}" style="width:75%;">
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_userName" class="btn btn-default btn-sm" data-memno="{{mem_no}}" data-nickname="{{nickName}}">변경</button>
                {{/equal}}
            </td>

            <th>보유뱃지</th>
            <td style="text-align: left">
                <!--팬뱃지 : {{{getBadgeList fanBadgeList '100px' '20px' 10 '15px' '15px'}}}<br />-->

                {{{getBadgeList liveBadgeList '100px' '20px' 10 '15px' '15px'}}}

                {{#dalbit_if recomm_badge '==' '1'}}
                    {{{getBadge '#d943c1' '#d943c1' '' '추천' '100px' '20px' 10 '15px' '15px'}}}
                {{/dalbit_if}}

                {{#dalbit_if newdj_badge '==' '1'}}
                    {{{getBadge '#d9c811' '#d9c811' '' '신입' '100px' '20px' 10 '15px' '15px'}}}
                {{/dalbit_if}}

                {{#dalbit_if specialdj_badge '==' '1'}}
                    {{{getBadge 'red' 'red' '' '스패셜DJ' '100px' '20px' 10 '15px' '15px'}}}
                {{/dalbit_if}}

                {{#dalbit_if specialdj_badge '==' '2'}}
                    {{{getBadge '#632BEB' '#632BEB' '' '베스트DJ' '100px' '20px' 10 '15px' '15px'}}}
                {{/dalbit_if}}

            </td>
            <th>보유별</th>
            <td colspan="6" style="text-align: left">
                <span class="col-md-3 no-padding">
                    {{addComma byeol}} 별
                </span>
                <c:if test="${insertYn eq 'Y'}">
                    {{#equal memWithdrawal '0'}}
                    <span class="col-md-7 no-padding pull-right" id="sp_byeolPointEdit">
                            <select id="byeolPlusMinus" name="byeolPlusMinus" class="form-control searchType">
                                <option value="1">+</option>
                                <option value="2">-</option>
                            </select>
                            <input type="text" class="form-control" id="txt_byeolAddCnt" style="width: 100px">
                            {{{getCommonCodeSelect pointEditStory 'byeolPointEditStory' 'Y' 'pointEditStory'}}}
                            <button type="button" id="bt_byeolAdd" class="btn btn-default btn-sm" data-memno="{{mem_no}}">변경</button>
                        </span>
                    {{/equal}}
                </c:if>
            </td>
        </tr>
        <tr>
            <th>로그인ID</th>
            <td style="text-align: left;border-right-color:white;border-right-width:0px;">
                <div id="div_socialId">
                    <input type="text" class="form-control" id="txt_socialId" value="{{socialId}}" onkeyup="fnChkByte(this);" style="width:75%;">
                    {{#equal memWithdrawal '0'}}
                    <button type="button" id="bt_socialId" class="btn btn-default btn-sm" data-memno="{{mem_no}}" data-nickname="{{nickName}}">변경</button>
                    {{/equal}}
                </div>
            </td>
            <td colspan="2"></td>

            <th>부스터</th>
            <td colspan="3" style="text-align: left">
                <span class="col-md-3 no-padding" style="text-align: left">
                    {{addComma boostCnt}} 개
                </span>
                <c:if test="${insertYn eq 'Y'}">
                    <span class="col-md-9 no-padding" id="">
                        <select id="boostPlusMinus" name="boostPlusMinus" class="form-control searchType">
                            <option value="1">+</option>
                            <option value="3">-</option>
                        </select>
                        <input type="text" class="form-control" id="txt_boostAddCnt" style="width:50px" maxlength="4">
                        <button type="button" id="bt_boostAdd" class="btn btn-default btn-sm" data-memno="{{mem_no}}" data-boostcnt="{{boostCnt}}">변경</button>
                        <button type="button" id="boostHist" class="btn btn-default btn-sm pull-right">상세</button>
                    </span>
                </c:if>
            </td>

            <th>매니저</th>
            <td style="text-align: left">
                <%--{{addComma managerICnt}} 명 / {{addComma managerMeCnt}} 명--%>
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_manager" class="btn btn-default btn-sm pull-right">상세</button>
                {{/equal}}
            </td>
            <th>블랙리스트</th>
            <td style="text-align: left">
                <%--{{addComma blackICnt}} 명 / {{addComma blackMeCnt}} 명--%>
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_black" class="btn btn-default btn-sm pull-right">상세</button>
                {{/equal}}
            </td>
        </tr>
        <tr>
            <th>연락처</th>
            <td style="text-align: left;border-right-color:white;border-right-width:0px;">
                <input type="text" class="form-control" id="txt_phon" value="{{phoneNum}}" style="width:75%;">
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_phon" class="btn btn-default btn-sm" data-memno="{{mem_no}}" data-nickname="{{nickName}}">변경</button>
                {{/equal}}
            </td>
            <td colspan="2"></td>
            <th>회원<br>가입일시</th>
            <td colspan="3" style="text-align: left">{{joinDate}} <label class="no-margin" id="memSlct"></label></td>
            <th>회원<br>탈퇴일시</th>
            <td colspan="3" style="text-align: left">
                {{#equal memWithdrawal '1'}}
                {{../last_upd_date}}
                {{/equal}}
            </td>
        </tr>
        <tr>
            <th>본인인증</th>
            <td class="font-bold">
                {{#equal auth_yn 'Yes'}}
                    {{../comm_company}} &nbsp&nbsp|&nbsp&nbsp <label style="color: red; font-weight: bold">{{../auth_yn}}</label>
                    <button type="button" id="bt_cancel_cert" class="btn btn-default btn-sm pull-right ml5" style="background-color: #46B0CF; border-color: #46B0CF">철회</button>
                {{/equal}}
                {{#equal auth_yn 'No'}}
                    <label style="font-weight: bold;">{{../auth_yn}}</label>
                    {{#equal ../certificationBakYn 'Y'}}
                        <button type="button" id="bt_rollback_cert" class="btn btn-default btn-sm pull-right ml5" style="background-color: #46B0CF; border-color: #46B0CF">복귀</button>
                    {{/equal}}
                    <button type="button" id="bt_auth" class="btn btn-default btn-sm pull-right ml5">수동인증</button>
                {{/equal}}
            </td>
            <th>법정대리인<br>(보호자)</br>동의</th>
            <td>
                {{#equal parents_agree_yn 'y'}}
                <label style="color: red; font-weight: bold;">Yes</label>
                <button type="button" id="bt_recant" class="btn btn-default btn-sm pull-right ml5" style="background-color: #46B0CF; border-color: #46B0CF">철회</button>
                <button type="button" id="bt_agree_info" class="btn btn-default btn-sm pull-right">동의정보</button>
                {{else}}
                <label style="font-weight: bold;">No</label>
                <button type="button" id="bt_back_recant" class="btn btn-default btn-sm pull-right ml5" style="background-color: #46B0CF; border-color: #46B0CF">복귀</button>
                <button type="button" id="bt_agree_info" class="btn btn-default btn-sm pull-right">동의정보</button>
                {{/equal}}
            </td>
            <th>최근정보<br/>수정일시</th>
            <td colspan="3" style="text-align: left">{{lastOpDate}}</td>
            <th>최근정보<br/>수정자</th>
            <td colspan="2" style="text-align: left;border-right-color:white;border-right-width:0px;">{{lastOpName}}</td>
            <td>
                <button type="button" id="bt_editHistory" class="btn btn-default btn-sm pull-right">상세</button>
            </td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td style="text-align: left">
                <div class="input-group date" id="date_birth" style="width:75%;">
                    <input type="text" class="form-control" id="txt_birth" value="{{{birthData}}}">
                    {{#equal memWithdrawal '0'}}
                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    {{/equal}}
                </div>
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_birth" class="btn btn-default btn-sm" data-memno="{{../mem_no}}" data-nickname="{{../nickName}}">변경</button>
                {{/equal}}
            </td>
            <th>나이</th>
            <%--<td style="text-align: left">{{koreaAge birthData}}세 (만 {{age}}세)</td>--%>
            <td style="text-align: left">{{koreaAge birthData}}세</td>
            <th rowspan="2">운영자<br>메모</th>
            <td rowspan="2" colspan="7" style="text-align: left;">
                <textarea type="textarea" class="form-control" id="txt_adminMemo" style="width: 90%;height: 76px"></textarea>
                <button type="button" id="bt_adminMemo" class="btn btn-default btn-sm pull-right" data-memno="{{mem_no}}" data-nickname="{{nickName}}">등록</button>
            </td>
        </tr>
        <tr>
            <th>성별</th>
            <td colspan="3" style="text-align: left">
                <label class="mt5">{{{getCommonCodeRadio memSex 'memSex'}}}</label>
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_gender" class="btn btn-default btn-sm pull-right" data-memno="{{mem_no}}" data-nickname="{{nickName}}">변경</button>
                {{/equal}}
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td style="text-align: left">
                {{#equal memWithdrawal '0'}}
                <button type="button" id="bt_resatPass" class="btn btn-default btn-sm" data-memno="{{mem_no}}" data-nickname="{{nickName}}">초기화</button>
                {{/equal}}
            </td>

            <th>실시간<br />팬랭킹<br />미반영</th>
            <td>
                <span style="">{{addComma fanrankOnOffCnt}} 건</span>
                <button type="button" id="bt_fanrankOnOffList" class="btn btn-default btn-sm pull-right">상세</button>
            </td>

            <th>최근메모<br>등록</th>
            <td colspan="2" style="text-align: left;border-right-color:white;border-right-width:0px;">등록: {{addComma opMemoCnt}} 건</td>
            <td>
                <button type="button" id="bt_adminMemoList" class="btn btn-default btn-sm pull-right">상세</button>
            </td>
            <th>룰렛<br />응모권</th>
            <td colspan="2" style="text-align: left;border-right-color:white;border-right-width:0px;">{{addComma couponCnt}} 개</td>
            <td>
                <button type="button" id="bt_couponHistory" class="btn btn-default btn-sm pull-right">상세</button>
            </td>
        </tr>
        </tbody>
    </table>
</script>

<!-- info detail -->
<script id="tmp_member_detailFrm" type="text/x-handlebars-template">
    <div class="widget-content mt5">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tab_infoDetail">
            <li class="active" id="detail1"><a href="#memberInfoDetail" role="tab" data-toggle="tab" id="tab_memberInfoDetail"></a></li>
            <li class="hide" id="detail2"><a href="#memberInfoDetail2" role="tab" data-toggle="tab" id="tab_memberInfoDetail2"></a></li>
        </ul>
        <div class="tab-content" style="padding-top: 0px;">
            <div class="tab-pane fade in active" id="memberInfoDetail">
                <div class="widget-content mt5">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tab_adminMemo" style="display: none">
                        <li class="active"><a href="#memoContent" role="tab" data-toggle="tab" id="tab_memoMember" onclick="adminMemoSubTabClick(1)">회원</a></li>
                        <li><a href="#memoContent" role="tab" data-toggle="tab" id="tab_memoBroadcast" onclick="adminMemoSubTabClick(2)">방송방</a></li>
                        <li><a href="#memoContent" role="tab" data-toggle="tab" id="tab_memoCast" onclick="adminMemoSubTabClick(3)">클립</a></li>
                    </ul>
                    <div class="tab-pane fade in active" id="memoContent">
                        <div class="widget widget-table">
                            <div class="widget-content">
                                <table id="info_detail" class="table table-sorting table-hover table-bordered datatable">
                                    <thead id="tableTop_detail">
                                    </thead>
                                    <tbody id="tableBody_detail">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="memberInfoDetail2">
                <div class="widget widget-table">
                    <div class="widget-content">
                        <table id="info_detail2" class="table table-sorting table-hover table-bordered datatable">
                            <thead id="tableTop_detail2">
                            </thead>
                            <tbody id="tableBody_detail2">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_layer_detail">
    <div class="modal-dialog" style="max-width: 700px;min-width: 400px; width: auto; display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="layerCloseBtn">&times;</button>
                <h4 class="modal-title" id="_layerTitle" style="font-weight: bold">법정대리인 (보호자) 동의정보</h4>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 form-inline block _modalLayer">
                    <table id="list_info" class="table table-sorting table-hover table-bordered">
                        <tbody id="tableBody">
                        {{#if parents_name}}
                        <tr>
                            <th>보호자 이름</th>
                            <td>
                                &nbsp;{{parents_name}}
                            </td>
                        </tr>
                        <tr>
                            <th>성 별</th>
                            <td>
                                &nbsp;{{{sexIcon parents_sex}}}
                            </td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td>
                                &nbsp;{{parents_birth_year}}{{parents_birth_month}}{{parents_birth_day}}
                            </td>
                        </tr>
                        <tr>
                            <th>통 신 사</th>
                            <td>
                                &nbsp;{{parents_comm_company}}
                            </td>
                        </tr>
                        <tr>
                            <th>휴대폰 번호</th>
                            <td>
                                &nbsp;{{parents_phone}}
                            </td>
                        </tr>
                        <tr>
                            <th>내 / 외국인</th>
                            <td>
                                &nbsp;{{parents_foreign_yn}}
                            </td>
                        </tr>
                        <tr>
                            <th>철회 여부</th>
                            <td>
                                {{#equal recant_yn 'n'}}
                                &nbsp;<label style="font-weight: bold">No</label>
                                {{else}}
                                &nbsp;<label style="color: red; font-weight: bold">Yes</label>
                                {{/equal}}
                            </td>
                        </tr>
                        <tr>
                            <th>가족관계증명</br>서류</th>
                            <td>
                                {{#if add_file}}
                                <a href="javascript://">
                                    <img src="{{renderImage add_file}}" class="_fullWidth _openImagePop thumbnail" />
                                </a>
                                {{else}}
                                가족관계증명서류가 없습니다.
                                {{/if}}
                            </td>
                        </tr>
                        {{else}}
                        법정대리인 보호자 동의 정보가 없습니다.
                        {{/if}}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="tmp_memberAccumData" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered borderBlack _tableHeight" style="width: 60%;margin-bottom: 5px;" data-height="23px">
        <tr>
            <th colspan="3" class="_bgColor" data-bgcolor="#b4c6e7">달</th>
            <th colspan="4" class="_bgColor" data-bgcolor="#fff5a3">별</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 결제(취소)</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 결제(취소) 금액</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">직접 보낸/받은 달</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">누적 환전</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">누적 환전(불가) 금액</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">누적 교환</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">누적 교환 별</th>
        </tr>
        <tr>
            <td>{{addComma payCnt}} ({{addComma payCanCnt}})</td>
            <td>{{addComma payAmt}} ({{addComma payCanAmt}})</td>
            <td>{{addComma sendDal}} / {{addComma giftedDal}}</td>
            <td>{{addComma exchangeCnt}} ({{addComma exchangeCancelCnt}})</td>
            <td>{{addComma exchangeAmt}} ({{addComma exchangeCancelAmt}})</td>
            <td>{{addComma changeCnt}}</td>
            <td>{{addComma changeByeol}}</td>
        </tr>
    </table>
</script>

<script id="tmp_memberAccumData2" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered borderBlack _tableHeight" style="width: 75%;margin-bottom: 5px;" data-height="23px">
        <tr>
            <th colspan="7" class="_bgColor" data-bgcolor="#b4c6e7">방송</th>
            <th colspan="3" class="_bgColor" data-bgcolor="#fff5a3">청취</th>
            <th colspan="4" class="_bgColor" data-bgcolor="#b4c6e7">클립</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 방송 개설</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 방송 시간</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">방송중 받은 별</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 청취자</th>
            <th class="_bgColor" data-bgcolor="#f4d9d9">좋아요 합계</th>
            <th class="_bgColor" data-bgcolor="#f4d9d9">누적 좋아요</th>
            <th class="_bgColor" data-bgcolor="#f4d9d9">받은 부스터</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">총 청취</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">누적 청취 시간</th>
            <th class="_bgColor" data-bgcolor="#fff2cc">청취 중 보낸 달</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 등록</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 받은 별</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 청취자</th>
            <th class="_bgColor" data-bgcolor="#d9e2f4">누적 좋아요</th>
        </tr>
        <tr>
            <td>{{addComma brodCnt}}</td>
            <td>{{timeStampDay broadTime}}</td>
            <td>{{addComma byeolCnt}}</td>
            <td>{{addComma listenerCnt}}</td>
            <td>{{addComma goodTotal}}</td>
            <td>{{addComma goodCnt}}</td>
            <td>{{addComma boostCnt}} 개</td>
            <td>{{addComma listenCnt}}</td>
            <td>{{timeStampDay listenTime}}</td>
            <td>{{addComma dalCnt}}</td>
            <td>{{addComma clipCnt}}</td>
            <td>{{addComma clipByeol}}</td>
            <td>{{addComma clipPlay}}</td>
            <td>{{addComma clipGood}}</td>
        </tr>
    </table>
</script>