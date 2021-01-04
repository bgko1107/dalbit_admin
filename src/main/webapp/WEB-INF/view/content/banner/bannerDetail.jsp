<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div id="wrapper">
    <form id="targetForm"></form>
</div>




<script src="../../../js/lib/jquery.table2excel.js"></script>

<script>
    $(document).ready(function () {
        fnc_bannerDetail.init();
    });


    var fnc_bannerDetail = {};
//=------------------------------ Init / Event / UI--------------------------------------------
    fnc_bannerDetail.targetId= "bannerDetail";
    fnc_bannerDetail.formId= "bannerDetailForm";

    fnc_bannerDetail.init= function() {
        fnc_bannerDetail.target = $("#" + fnc_bannerDetail.targetId);
        fnc_bannerDetail.target.find("#targetForm").attr("id", fnc_bannerDetail.targetId + "Form");
        fnc_bannerDetail.formId = fnc_bannerDetail.targetId + "Form";

        if(common.isEmpty(getSelectDataInfo())){
            fnc_bannerDetail.insertDetail();
        }else{
            console.log(getSelectDataInfo());

            var data = new Object();
            data.banner_idx = getSelectDataInfo().data.banner_idx;

            util.getAjaxData(fnc_bannerDetail.targetId, "/rest/content/banner/detail",data, fnc_bannerDetail.fn_detail_success, fnc_bannerDetail.fn_fail);
        }

        // this.initDetail();
        // this.initDetailEvent();
    };


    // Datapicker
    fnc_bannerDetail.dataPickerSrc= {
        startDate: moment(),
        endDate: moment(),
        // dateLimit: { days: 60 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: false,
        ranges: {
            '1일': [moment(), moment()],
            // '어제': [moment().subtract('days', 1), moment().subtract('days', 1)],
            '7일': [moment(), moment().add('days', 6)],
            '30일': [moment(), moment().add('days', 29)]
        },
        opens: 'left',
        // buttonClasses: ['btn btn-default'],
        // applyClass: 'btn-small btn-primary',
        // cancelClass: 'btn-small',
        format: 'L',
        separator: ' to ',
        locale: {
            customRangeLabel: '직접선택',
        }
    };

    // 초기 설정
    fnc_bannerDetail.initDetail= function(){
        // 캘린더 기능추가
        fnc_bannerDetail.target.find("#banner-startDate, #banner-endDate").daterangepicker(this.dataPickerSrc,
            function (start, end, t1) {
                //console.log(t1);
                fnc_bannerDetail.target.find("#banner-input-startDate").val(start.format('YYYY.MM.DD'));
                fnc_bannerDetail.target.find("#banner-input-endDate").val(end.format('YYYY.MM.DD'));
            }
        );

        // 캘린더 초기값
        fnc_bannerDetail.target.find("#banner-input-startDate").val(moment().format('YYYY.MM.DD'));
        fnc_bannerDetail.target.find("#banner-input-endDate").val(moment().format('YYYY.MM.DD'));

        // 시간 Select CSS 적용
        fnc_bannerDetail.target.find("#banner-div-startDate").find("#timeHour").attr("class", "select-time");
        fnc_bannerDetail.target.find("#banner-div-startDate").find("#timeMinute").attr("class", "select-time");
        fnc_bannerDetail.target.find("#banner-div-endDate").find("#timeHour").attr("class", "select-time");
        fnc_bannerDetail.target.find("#banner-div-endDate").find("#timeMinute").attr("class", "select-time");
    };

    // 이벤트 적용
    fnc_bannerDetail.initDetailEvent= function(){

        //로그인 타입 선택
        fnc_bannerDetail.target.find("input[name='view_type']:radio").change(function () {
            var type = this.value;

            //로그인 사용자일 경우 성별 선택 가능
            if (type == "1") {
                fnc_bannerDetail.target.find("input[name='sex']").prop("disabled", false);
            } else {
                $("input[name='sex']:eq(0)").click();
                $("input[name='sex']:eq(1)").prop("disabled", true);
                $("input[name='sex']:eq(2)").prop("disabled", true);
            }

        });

        //OS 구분
        fnc_bannerDetail.target.find("input[name='platform']").change(function () {
            if ($(this).attr("id").indexOf("-1") > -1) {
                if ($(this).is(":checked")) {
                    fnc_bannerDetail.target.find("input[name='platform']").each(function () {
                        this.checked = true;
                    });
                } else {
                    fnc_bannerDetail.target.find("input[name='platform']").each(function () {
                        this.checked = false;
                    });
                }
            } else {
                if ($(this).is(":checked")) {
                    var cntTotal = fnc_bannerDetail.target.find("input[name='platform']").length;
                    var cntChecked = fnc_bannerDetail.target.find("input[name='platform']:checked").length;
                    if ((cntTotal) == (cntChecked + 1)) {
                        fnc_bannerDetail.target.find("input[name='platform'][id='platform-1']").prop("checked", true);
                    }
                } else {
                    fnc_bannerDetail.target.find("input[name='platform'][id='platform-1']").prop("checked", false);
                }
            }
        });

        // 게시 스케쥴
        fnc_bannerDetail.target.find("input[name='content_scheduleWeek']").change(function () {
            if ($(this).attr("id").indexOf("-1") > -1) {
                if ($(this).is(":checked")) {
                    fnc_bannerDetail.target.find("input[name='content_scheduleWeek']").each(function () {
                        this.checked = true;
                    });
                } else {
                    fnc_bannerDetail.target.find("input[name='content_scheduleWeek']").each(function () {
                        this.checked = false;
                    });
                }
            } else {
                if ($(this).is(":checked")) {
                    var cntTotal = fnc_bannerDetail.target.find("input[name='content_scheduleWeek']").length;
                    var cntChecked = fnc_bannerDetail.target.find("input[name='content_scheduleWeek']:checked").length;
                    if ((cntTotal) == (cntChecked + 1)) {
                        fnc_bannerDetail.target.find("input[name='content_scheduleWeek'][id='content_scheduleWeek-1']").prop("checked", true);
                    }
                } else {
                    fnc_bannerDetail.target.find("input[name='content_scheduleWeek'][id='content_scheduleWeek-1']").prop("checked", false);
                }
            }
        });

        //노출 기간
        fnc_bannerDetail.target.find("input[name='term_type']:radio").change(function () {
            var type = this.value;

            if (type == "1") {  //예약발송
                fnc_bannerDetail.target.find("#banner-div-exposure").show();
            } else {    //상시
                fnc_bannerDetail.target.find("#banner-div-exposure").hide();
            }
        });

        //게시 시간 기간
        fnc_bannerDetail.target.find("input[name='content_scheduleWeekTime']:radio").change(function () {
            var type = this.value;

            if (type == "1") {  //예약발송
                fnc_bannerDetail.target.find("#banner-div-scheduleWeek").show();
            } else {    //상시
                fnc_bannerDetail.target.find("#banner-div-scheduleWeek").hide();
            }
        });

        fnc_bannerDetail.target.find("input[name='position']:radio").change(function () {   // 배너위치
            var type = this.value;
            if (type == 7) {              // 시작팝업
                $("input[name='is_pop']:input[value='0']").prop("checked", true)
            }else if (type == 8) {        // 종료팝업
                $("input[name='is_pop']:input[value='1']").prop("checked", true)
            }

            fnc_bannerDetail.popupBannerDisplayChange();
        });

        fnc_bannerDetail.target.find("input[name='popup_type']:radio").change(function () {   // 배너위치
            var type = this.value;

            //팝업구분 따른 display 변경
            if(type == 0){
                $('._show_popup_image').show();
                $('._show_popup_text').hide();
            }else{
                $('._show_popup_image').hide();
                $('._show_popup_text').show();
            }

        });

        // 등록 버튼
        fnc_bannerDetail.target.find("#insertBtn").on("click", function () {
            if(!confirm("등록 하시겠습니까?")){
                return false;
            }

            var data = fnc_bannerDetail.getDetailData();

            if(!fnc_bannerDetail.isValid(data)){
                return false;
            }

            util.getAjaxData("insert", "/rest/content/banner/insert", data, fnc_bannerDetail.fn_insert_success, fnc_bannerDetail.fn_fail);
        })


        // 수정 버튼
        fnc_bannerDetail.target.find("#updateBtn").on("click", function () {
            if(!confirm("수정 하시겠습니까?")){
                return false;
            }

            var data = fnc_bannerDetail.getDetailData();

            if(!fnc_bannerDetail.isValid(data)){
                return false;
            }

            util.getAjaxData("upldate", "/rest/content/banner/update", data, fnc_bannerDetail.fn_update_success, fnc_bannerDetail.fn_fail);
        })

    };

    fnc_bannerDetail.popupBannerDisplayChange = function(){
        //배너위치에 따른 display 변경
        if(-1 < '|6|11|12|13|14|'.indexOf('|'+$('input[name="position"]:checked').val()+'|')){
            $('._show_popup').show();
            $("input[name='popup_type']:radio").change();


            //배너타입에 따른 display 변경 [이미지/텍스트]
            if($('input[name="popup_type"]:checked').val() == 0){
                    $('._show_popup_image').show();
                    $('._show_popup_text').hide();
            }else{
                $('._show_popup_image').hide();
                $('._show_popup_text').show();
            }
        }else{
            $('._show_popup').hide();
            $('._show_popup_image').show();
            $('._show_popup_text').hide();
        }

    }

    //수정 데이터 조회 후 UI 처리
    fnc_bannerDetail.initUpdateUI= function(){
        var detailData = getSelectDataInfo().detailData;

        //OS 구분
        if(detailData.platform == "111"){
            fnc_bannerDetail.target.find("input[name='platform']").each(function () {
                this.checked = true;
            });
        }else {
            fnc_bannerDetail.target.find("input[name='platform']").each(function () {
                this.checked = false;
            });

            var arrayPlatform = detailData.platform.split('');
            for (var idx in arrayPlatform) {
                if (arrayPlatform[idx] == 1) {
                    var value = parseInt(idx) + 1;
                    fnc_bannerDetail.target.find("input[name='platform'][id='platform" + value + "']").prop("checked", true);
                }
            }
        }

        //OS 구분
        if(detailData.dayOfTheWeek == "1111111"){
            fnc_bannerDetail.target.find("input[name='content_scheduleWeek']").each(function () {
                this.checked = true;
            });
        }else {
            fnc_bannerDetail.target.find("input[name='content_scheduleWeek']").each(function () {
                this.checked = false;
            });

            var arrayDayOfTheWeek = detailData.dayOfTheWeek.split('');
            for (var idx in arrayDayOfTheWeek) {
                if (arrayDayOfTheWeek[idx] == 1) {
                    console.log("-------------------------------------- 1");
                    var value = parseInt(idx) + 1;
                    fnc_bannerDetail.target.find("input[name='content_scheduleWeek'][id='content_scheduleWeek" + value + "']").prop("checked", true);
                }
            }
        }

        $("input:radio[name='position'][value='"+detailData.position+"']").prop("checked", true);

        if(detailData.term_type == "1"){
            fnc_bannerDetail.target.find("#banner-div-exposure").show();

            var sDate = moment(detailData.start_datetime);
            var eDate = moment(detailData.end_datetime);

            // 캘린더 초기값
            fnc_bannerDetail.target.find("#banner-input-startDate").val(sDate.format('YYYY.MM.DD'));
            fnc_bannerDetail.target.find("#banner-input-endDate").val(eDate.format('YYYY.MM.DD'));

            // 시간 Select CSS 적용
            fnc_bannerDetail.target.find("#banner-div-startDate").find("#timeHour").val(sDate.hour().toString().length == 1?("0"+sDate.hour()):sDate.hour());
            fnc_bannerDetail.target.find("#banner-div-startDate").find("#timeMinute").val(sDate.minute().toString().length == 1?("0"+sDate.minute()):sDate.minute());
            fnc_bannerDetail.target.find("#banner-div-endDate").find("#timeHour").val(eDate.hour().toString().length == 1?("0"+eDate.hour()):eDate.hour());
            fnc_bannerDetail.target.find("#banner-div-endDate").find("#timeMinute").val(eDate.minute().toString().length == 1?("0"+eDate.minute()):eDate.minute());
        }

        $("input:radio[name='content_scheduleWeekTime'][value='"+detailData.content_scheduleWeekTime+"']").prop("checked", true);

        if(detailData.content_scheduleWeekTime == "1"){
            fnc_bannerDetail.target.find("#banner-div-scheduleWeek").show();

            var sDate = detailData.weekStartDatetime;
            var eDate = detailData.weekEndDatetime;

            // 시간 Select CSS 적용
            fnc_bannerDetail.target.find("#banner-div-scheduleWeek-startDate").find("#timeHour").val(sDate.substr(0,2));
            fnc_bannerDetail.target.find("#banner-div-scheduleWeek-startDate").find("#timeMinute").val(sDate.substr(2,2));
            fnc_bannerDetail.target.find("#banner-div-scheduleWeek-endDate").find("#timeHour").val(eDate.substr(0,2));
            fnc_bannerDetail.target.find("#banner-div-scheduleWeek-endDate").find("#timeMinute").val(eDate.substr(2,2));
        }


        fnc_bannerDetail.popupBannerDisplayChange();
    };


    // 등록 화면
    fnc_bannerDetail.insertDetail= function() {
        var template = $('#tmp_bannerDetailFrm').html();
        var templateScript = Handlebars.compile(template);

        var detailData = {
            'platform':'0'
            ,'view_type':'0'
            ,'sex':'1'
            ,'is_pop':'1'
            ,'frequency_rate':'100'
            ,'position':'0'
            ,'is_view':'1'
            ,'term_type':'0'
            ,'popup_type':'0'
        }
        var context = detailData;
        var html = templateScript(context);

        fnc_bannerDetail.target.find("#"+this.formId).html(html);

        fnc_bannerDetail.initDetail();
        fnc_bannerDetail.initDetailEvent();

        var scrollPosition = $("#tab_"+fnc_bannerDetail.targetId).offset();
        util.scrollPostion(scrollPosition.top);
    };


    // 수정 화면
    fnc_bannerDetail.updateDetail= function(){
        var detailData = getSelectDataInfo().detailData;
        detailData.rowNum = getSelectDataInfo().data.rowNum;
        dalbitLog(detailData);


        // form 띄우기
        var template = $('#tmp_bannerDetailFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = detailData;
        var html = templateScript(context);
        fnc_bannerDetail.target.find("#"+ fnc_bannerDetail.formId).html(html);

        fnc_bannerDetail.initDetail();
        fnc_bannerDetail.initDetailEvent();
        fnc_bannerDetail.initUpdateUI();

        var scrollPosition = $("#tab_"+fnc_bannerDetail.targetId).offset();
        util.scrollPostion(scrollPosition.top);
    };

//=------------------------------ Option --------------------------------------------

    // 상세 목록 조회 성공 시
    fnc_bannerDetail.fn_detail_success= function(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        setSelectDataInfo("detailData", data.data);

        fnc_bannerDetail.updateDetail();

        var scrollPosition = $("#tab_bannerDetail").offset();
        util.scrollPostion(scrollPosition.top);
    };


    // 등록 성공 시
    fnc_bannerDetail.fn_insert_success= function(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        alert(data.message);

        fnc_bannerList.selectMainList(false);

        //하위 탭 초기화
        initContentTab();
        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#"+fnc_bannerDetail.formId).empty();
    };


    // 수정 성공 시
    fnc_bannerDetail.fn_update_success= function(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        alert(data.message);

        fnc_bannerList.selectMainList(false);

        //하위 탭 초기화
        initContentTab();
        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#"+fnc_bannerDetail.formId).empty();
    };


    // Ajax 실패
    fnc_bannerDetail.fn_fail= function(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };

//=------------------------------ Data Handler ----------------------------------

    // 데이터 가져오기
    fnc_bannerDetail.getDetailData= function(){
        var resultJson ={};

        var formArray = fnc_bannerDetail.target.find("#" + this.formId).serializeArray();
        for (var i = 0; i < formArray.length; i++){
            resultJson[formArray[i]['name']] = formArray[i]['value'];
        }

        //platform
        if(fnc_bannerDetail.target.find("#platform-1").is(":checked")){
            resultJson['platform'] = "111";
        }else{
            var platformCnt = fnc_bannerDetail.target.find("input[name=platform]").length;
            var platform = "";
            for(var i = 1; i < platformCnt; i++){
                if(fnc_bannerDetail.target.find("#platform"+(i)).is(":checked")){
                    platform += "1";
                }else{
                    platform += "0";
                }
            }
            resultJson['platform'] = platform;
        }

        resultJson['is_cookie'] = $('#detail_is_cookie').prop('checked') ? 1 : 0;
        resultJson['is_title_view'] = $('#detail_is_title_view').prop('checked') ? 1 : 0;
        resultJson['is_button_view'] = $('#detail_is_button_view').prop('checked') ? 1 : 0;
        resultJson['iosJudgeViewOn'] = $('#detail_iosJudgeViewOn').prop('checked') ? 1 : 0;

        //예약발송 일경우 Date 처리
        if(fnc_bannerDetail.target.find("input[name='term_type']:radio:checked").val() == "1"){
            var startDiv = fnc_bannerDetail.target.find("#banner-div-startDate");
            resultJson['start_datetime'] = startDiv.find("#banner-input-startDate").val().replace(/[^0-9]/gi, '') + startDiv.find("#timeHour").val() + startDiv.find("#timeMinute").val();
            var endDiv = fnc_bannerDetail.target.find("#banner-div-endDate");
            resultJson['end_datetime'] = endDiv.find("#banner-input-endDate").val().replace(/[^0-9]/gi, '') + endDiv.find("#timeHour").val() + endDiv.find("#timeMinute").val();
        }else{
            resultJson['start_datetime'] = "";
            resultJson['end_datetime'] = "";
        }

        //게시스케쥴 Date 처리
        if(fnc_bannerDetail.target.find("input[name='content_scheduleWeekTime']:radio:checked").val() == "1"){
            var startDiv = fnc_bannerDetail.target.find("#banner-div-scheduleWeek-startDate");
            resultJson['weekStartDatetime'] = startDiv.find("#timeHour").val() + startDiv.find("#timeMinute").val();
            var endDiv = fnc_bannerDetail.target.find("#banner-div-scheduleWeek-endDate");
            resultJson['weekEndDatetime'] = endDiv.find("#timeHour").val() + endDiv.find("#timeMinute").val();
        }else{
            resultJson['weekStartDatetime'] = "0000";
            resultJson['weekEndDatetime'] = "2359";
        }


        //platform
        if(fnc_bannerDetail.target.find("#content_scheduleWeek-1").is(":checked")){
            resultJson['dayOfTheWeek'] = "1111111";
        }else{
            var content_scheduleWeekCnt = fnc_bannerDetail.target.find("input[name=content_scheduleWeek]").length;
            var content_scheduleWeek = "";
            for(var i = 1; i < content_scheduleWeekCnt; i++){
                if(fnc_bannerDetail.target.find("#content_scheduleWeek"+(i)).is(":checked")){
                    content_scheduleWeek += "1";
                }else{
                    content_scheduleWeek += "0";
                }
            }
            resultJson['dayOfTheWeek'] = content_scheduleWeek;
        }

        if(fnc_bannerDetail.target.find('#detail_is_button_view').prop('checked')){
            if(fnc_bannerDetail.target.find("#banner-button_name").val() == ""){
                alert("버튼명을 입력하여 주시기 바랍니다.");
                return;
            }else{
                resultJson['buttonName'] = fnc_bannerDetail.target.find("#banner-button_name").val();
            }
        }

        dalbitLog(resultJson);

        return resultJson
    };


    fnc_bannerDetail.isValid= function(data){

        if(common.isEmpty(data.title)){
            alert("배너 제목을 입력하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=title]").focus();
            return false;
        }

        if(common.isEmpty(data.platform)){
            alert("플랫폼을 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=platform]").focus();
            return false;
        }

        if(common.isEmpty(data.view_type)){
            alert("로그인 구분을 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=view_type]").focus();
            return false;
        }

        if(common.isEmpty(data.sex)){
            alert("성별을 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=sex]").focus();
            return false;
        }

        if(common.isEmpty(data.is_pop)){
            alert("페이지 전환 방식을 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=is_pop]").focus();
            return false;
        }

        if(common.isEmpty(data.frequency_rate)){
            alert("노출 빈도를 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=frequency_rate]").focus();
            return false;
        }

        if(common.isEmpty(data.position)){
            alert("배너 위치를 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=position]").focus();
            return false;
        }

        if(common.isEmpty(data.is_view)){
            alert("게시 여부를 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=position]").focus();
            return false;
        }

        if(common.isEmpty(data.term_type)){
            alert("노출 기간 타입을 선택하여 주시기 바랍니다.");
            fnc_bannerDetail.target.find("input[name=term_type]").focus();
            return false;
        }

        //팝업 선택 시 필수 값 체크
        if(-1 < '|6|11|12|13|14|'.indexOf('|'+$('input[name="position"]:checked').val()+'|')){

            //이미지팝업
            if($('input[name="popup_type"]:checked').val() == 0){
                if($('#banner-pc_img_url').val() == '' && $('#banner-mobile_img_url').val() == ''){
                    alert('이미지링크를 입력해 주시기 바랍니다.');
                    return false;
                }
            }else{
                if(common.isEmpty($('#contents').val())){
                    alert('배너문구를 입력해 주시기 바랍니다.');
                    return false;
                }
            }
        }

        //회원레벨 시작 종료 체크
        var memLevelStart = fnc_bannerDetail.target.find("input[name=memLevelStart]");
        var memLevelEnd = fnc_bannerDetail.target.find("input[name=memLevelEnd]");

        console.log('sss')
        console.log(memLevelStart.val())
        console.log(memLevelEnd.val())

        if(!common.isEmpty(memLevelStart.val()) || !common.isEmpty(memLevelEnd.val())){
            if(common.isEmpty(memLevelStart.val()) || common.isEmpty(memLevelEnd.val())){
                alert('레벨 범위를 입력해주세요.');
                return false;
            }

            if(Number(memLevelEnd.val()) < Number(memLevelStart.val())){
                alert('레벨 범위를 선택해주세요.');
                return false;
            }

        }

        return true;
    };

</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_bannerDetailFrm" type="text/x-handlebars-template">
    <input type="hidden" name="banner_idx" value="{{banner_idx}}" />
    <div class="row col-lg-12">
        <div class="row col-md-12" style="padding-bottom: 15px">
            <div class="pull-left">
                • 배너를 등록/수정 관리하는 페이지 입니다.
                <br>
                • 모든 정보 완료 후 꼭!! 게시 여부와 게시 페이지를 지정한 후 [등록완료]버튼을 클릭해야 사이트 내 적용이 완료됩니다.
                <br>
                • 게시여부>비적용시에도 [등록 완료]가 된 경우 비적용 상태로 리스트에 추가됩니다.
            </div>
            <div class="pull-right">
                {{^banner_idx}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/banner_idx}}
                {{#banner_idx}}<button class="btn btn-default" type="button" id="updateBtn">수정하기</button>{{/banner_idx}}
            </div>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="12.5%" /><col width="12.5%" /><col width="12.5%" /><col width="12.5%" /><col width="12.5%" />
                <col width="12.5%" /><col width="12.5%" /><col width="12.5%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>No</th>
                <td>{{rowNum}}</td>

                <th>배너 제목</th>
                <td colspan="3"><input type="text" class="form-control" id="banner-title" name="title" placeholder="배너 제목을 입력하세요." value="{{title}}"></td>

                <th><span style="color:red">노출상태</span><br />게시여부 + 노출기간</th>
                <td>
                    {{{isCurrentDisplay is_view start_datetime end_datetime}}}
                </td>
            </tr>
            <tr>
                <th>플랫폼</th>
                <td>{{{getCommonCodeHorizontalCheck platform 'content_platform2'}}}</td>
                <th>노출 기간</th>
                <td>
                    <div>
                        {{{getCommonCodeRadio term_type 'banner_exposureType' 'N' 'term_type'}}}
                    </div>
                    <div class="form-inline" id="banner-div-exposure" style="display: none;">
                        <div class="input-group date" id="banner-div-startDate">
                            <span class="input-group-addon" id="banner-startDate"><i class="fa fa-calendar"></i></span>
                            <input type="text" class="form-control" name="startDate" id="banner-input-startDate" style="width:100px; background:white;" readonly>
                            {{{getCommonCodeSelect 00 'timeHour'}}}
                            <span> : </span>
                            {{{getCommonCodeSelect 00 'timeMinute'}}}
                        </div>
                        <span> ~ </span>
                        <div class="input-group date" id="banner-div-endDate">
                            <span class="input-group-addon" id="banner-endDate"><i class="fa fa-calendar"></i></span>
                            <input type="text" class="form-control" name="endDate" id="banner-input-endDate" style="width:100px; background:white;" readonly>
                            {{{getCommonCodeSelect 00 'timeHour'}}}
                            <span> : </span>
                            {{{getCommonCodeSelect 00 'timeMinute'}}}
                        </div>
                    </div>
                </td>
                <th>게시여부</th>
                <td>{{{getCommonCodeRadio is_view 'content_viewOn' 'N' 'is_view'}}}</td>

                <th>IOS심사 중<br />노출여부</th>
                <td class="no-margin">{{{getOnOffSwitch iosJudgeViewOn 'iosJudgeViewOn'}}}</td>
            </tr>

            <tr>
                <th>회원 노출 조건</th>
                <th>회원가일 일 수</th>
                <td colspan="2">회원 가입 <input type="text" class="_onlyNumber" id="memJoinInnerDate" name="memJoinInnerDate" maxlength="6" style="width:50px" value="{{memJoinInnerDate}}" />일 이내</td>
                <th>회원레벨 범위</th>
                <td colspan="3">
                    <input type="text" class="_onlyNumber" id="memLevelStart" name="memLevelStart" maxlength="3" style="width:50px" value="{{memLevelStart}}" /> ~
                    <input type="text" class="_onlyNumber" id="memLevelEnd" name="memLevelEnd" maxlength="3" style="width:50px" value="{{memLevelEnd}}" />
                </td>
            </tr>

            <tr>
                <th rowspan="2">배너위치</th>
                <th>팝업</th>
                <td colspan="6">{{{getCommonCodeRadio '1' 'banner_bannerType_popup' 'Y' 'position'}}}</td>
            </tr>
            <tr>
                <th>배너</th>
                <td colspan="6">{{{getCommonCodeRadio '1' 'banner_bannerType_banner' 'Y' 'position'}}}</td>
            </tr>
            <tr>
                <th>게시 스케쥴</th>
                <td colspan="5">
                    요일 : {{{getCommonCodeHorizontalCheck scheduleWeek 'content_scheduleWeek'}}}<br/>
                    <div class="form-inline" >
                        <div class="col-md-3 no-padding" style="width: 183px;">
                            시간 : {{{getCommonCodeRadio 0 'content_scheduleWeekTime' '0' 'content_scheduleWeekTime'}}}
                        </div>
                        <div class="col-md-8 no-padding">
                            <div id="banner-div-scheduleWeek" style="display: none;">
                                <div class="col-md-1 no-padding" id="banner-div-scheduleWeek-startDate" style="width: 100px;">
                                    {{{getCommonCodeSelect 00 'timeHour'}}}
                                    <span> : </span>
                                    {{{getCommonCodeSelect 00 'timeMinute'}}}
                                    <span> ~ </span>
                                </div>
                                <div class="col-md-2 no-padding" id="banner-div-scheduleWeek-endDate">
                                    {{{getCommonCodeSelect 00 'timeHour'}}}
                                    <span> : </span>
                                    {{{getCommonCodeSelect 00 'timeMinute'}}}
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <th>페이지 전환</th>
                <td>{{{getCommonCodeRadio is_pop 'viewType' 'N' 'is_pop'}}}</td>
            </tr>

            <tr class="_show_popup" style='display:none;'>
                <th rowspan="2">팝업 구분</th>
                <td rowspan="2">{{{getCommonCodeRadio popup_type 'banner_popupType' 'N' 'popup_type'}}}</td>

                <th rowspan="2">오늘하루 열지않기</th>
                <td rowspan="2" class="no-margin">{{{getOnOffSwitch is_cookie 'is_cookie'}}}</td>

                <th rowspan="2">제목 노출 여부</th>
                <td rowspan="2" class="no-margin">{{{getOnOffSwitch is_title_view 'is_title_view'}}}</td>

                <th>버튼 노출 여부</th>
                <td class="no-margin">{{{getOnOffSwitch is_button_view 'is_button_view'}}}</td>
            </tr>

            <tr class="_show_popup" style='display:none;'>
                <th>버튼명</th>
                <td>
                    <input type="text" class="_trim" id="banner-button_name" name="banner-button_name" value="{{buttonName}}" maxlength="20" />
                </td>
            </tr>

            <tr class="_show_popup _show_popup_text" style='display:none;'>
                <th>배너문구</th>
                <td colspan="7">
                    <textarea name="contents" id="contents" style='width:100%;height:100%;' rows="10">{{contents}}</textarea>
                </td>
            </tr>
            <tr class="_show_popup_image">
                <th colspan="8">배너 이미지</th>
            </tr>
            <tr class="_show_popup_image">
                <th>PC<br />(1618px x 000px)</th>
                <td colspan="3">
                    <input type="text" class="_trim" id="banner-pc_img_url" name="pc_img_url" style="width:70%" value="{{pc_img_url}}" >
                    <input type="button" value="미리보기" onclick="getImg('banner-pc_img_url')">
                </td>

                <th>Mobile<br />(1618px x 000px)</th>
                <td colspan="3">
                    <input type="text" class="_trim" id="banner-mobile_img_url" name="mobile_img_url" style="width:70%" value="{{mobile_img_url}}" >
                    <input type="button" value="미리보기" onclick="getImg('banner-mobile_img_url')">
                </td>
            </tr>
            <tr class="_show_popup_image">
                <td colspan="4">
                    <!--미리보기-->
                    <img id="banner-pc_img_urlViewer" class="thumbnail fullSize_background no-margin no-padding" style="border:0px; border-radius:0px; width:100%;" src="" alt="" /></a>
                </td>

                <td colspan="4">
                    <!--미리보기-->
                    <img id="banner-mobile_img_urlViewer" class="thumbnail fullSize_background no-margin no-padding" style="border:0px; border-radius:0px; width:100%;" src="" alt="" /></a>
                </td>
            </tr>
            <tr>
                <th>PC 링크</th>
                <td colspan="3"><input type="text" class="form-control _trim" id="banner-pc_link_url"  name="pc_link_url" placeholder="배너 클릭 시 이동할 링크" value="{{{pc_link_url}}}"></td>

                <th>Mobile 링크</th>
                <td colspan="3"><input type="text" class="form-control _trim" id="banner-mobile_link_url" name="mobile_link_url" placeholder="배너 클릭 시 이동할 링크" value="{{{mobile_link_url}}}"></td>
            </tr>

            <tr>
                <th>등록자</th>
                <td>{{opName}}</td>
                <th>등록일시</th>
                <td>{{moment reg_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                <th>수정자</th>
                <td>{{lastOpName}}</td>
                <th>수정일시</th>
                <td>{{moment lastUpdDate 'YYYY-MM-DD HH:mm:ss'}}</td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="7">
                    <textarea class="form-control" d="banner-desc" name="desc" irows="5" cols="30" placeholder="설명 및 메모를 입력해주세요." style="resize: none" maxlength="200" >{{desc}}</textarea>
                </td>
            </tr>


            <!-- 가려달라고 해서 일단 여기에 모아둠.. -->
            <tr style="display:none;">
                <th>구분</th>
                <td colspan="2">{{{getCommonCodeRadio view_type 'banner_loginType' 'N' 'view_type'}}}</td>

                <th>성별</th>
                <td colspan="2">{{{getCommonCodeRadio sex 'gender' 'N' 'sex'}}}</td>

                <th>노출 빈도</th>
                <td>{{{getCommonCodeRadio frequency_rate 'banner_frequency' 'N' 'frequency_rate'}}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>