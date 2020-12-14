<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<form id="eventInfoForm"></form>
<input type="hidden" id="prizewinner"/>

<div id="eventDetail_fullSize"></div>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");

    function initDetail_insert() {
        var template = $('#tmp_eventInfoForm').html();
        var templateScript = Handlebars.compile(template);
        $("#eventInfoForm").html(templateScript);

        $('#etcUrl').attr('readonly', true);

        $('._calendar').datepicker('._calendar', new Date()).on('changeDate', function(dateText, inst) {
            var selectDate = moment(dateText.date).format('YYYY.MM.DD');
            $(this).val(selectDate);
        });
    }

    function initDetail() {
        var data = {
            eventIdx : $("#eventidx").val()
        };
        util.getAjaxData("eventInfo", "/rest/content/event/management/info", data, function fn_eventInfo_success(dst_id, response) {
            var template = $('#tmp_eventInfoForm').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);

            $('#eventInfoForm').html(html);

            $('#eventInfoForm #datail_eventIdx').val($("#eventidx").val());
            $('#prizeslct').val(response.data.prizeSlct);

            $('._calendar').datepicker('._calendar', new Date()).on('changeDate', function(dateText, inst) {
                var selectDate = moment(dateText.date).format('YYYY.MM.DD');
                $(this).val(selectDate);
            });

            // 상시 이벤트 disabled 설정
            if(response.data.alwaysYn == 1) {

                $('#eventEndDate').val("");
                $('#eventEndDate').prop('disabled', true);

                $('#alwaysYnCheck').attr('checked', true);
            }

            // 추가 정보 readonly 속성 설정
            if(response.data.addInfoSlct != 9) {
                $('#etcUrl').attr('readonly', true);
            }

            // 당첨자 선정 완료 구분값 받아서 당첨자 발표 탭 disabled
            var prizeWinner = response.data.prizeWinner;
            $('#prizewinner').val(prizeWinner);
            if(prizeWinner == 1) {
                $('#tab_eventWinnerAnnounce').removeAttr('disabled');
            } else if(prizeWinner == 0) {
                $('#tab_eventWinnerAnnounce').attr('disabled', true);
            }

            // 당첨자 발표 날짜가 빈 값일 시 처리
            if(response.data.announcementDate == '0000-00-00 00:00:00') {
                $('#announcementDate').val('-');
            }
        });
    }

    $(document).on('click', '#alwaysYnCheck', function() {
        if($(this).prop('checked')) {
            $('#eventStartDate').val(dateTime);
            $('#eventEndDate').val("");
            $('#eventEndDate').prop('disabled', true);
        } else {
            $('#eventEndDate').prop('disabled', false);
            $('#eventEndDate').val(dateTime);
        }
    });

    $(document).on('change', '#addInfoSlct', function() {
        if($(this).val() == 9) {
            $('#etcUrl').attr('readonly', false);
        } else {
            $('#etcUrl').attr('readonly', true);
            $('#etcUrl').val("");
        }
    });

    function inputValidation() {
        var title = $('#eventInfoForm #title');
        if(common.isEmpty(title.val())) {
            alert('이벤트 제목을 입력해주세요.');
            title.focus();
            return false;
        }

        var viewyn = $('input[name="viewYn"]:checked').val();
        if(common.isEmpty(viewyn)) {
            alert('이벤트 노출 여부를 선택해주세요.');
            return false;
        }

        if($('#prizewinner') == 1) {
            var announceyn = $('input[name="announceYn"]:checked').val();
            if (common.isEmpty(announceyn)) {
                alert('발표결과 노출 여부를 선택해주세요.');
                return false;
            }
        }

        if($('#addInfoSlct').val() == 9) {
            if(common.isEmpty($('#etcUrl').val())) {
                alert('추가 정보를 입력해주세요.');
                return false;
            }
        }

        if(common.isEmpty($('#pcLinkUrl').val())) {
            alert('PC 링크를 입력해주세요.');
            return false;
        }

        if(common.isEmpty($('#mobileLinkUrl').val())) {
            alert('Mobile 링크를 입력해주세요.');
            return false;
        }

        if(common.isEmpty($('#listImgUrl').val())) {
            alert('목록에 보일 이벤트 이미지 url을 입력해주세요.');
            return false;
        }

        var contentCheck = true;
        $('._eventContent').each(function(){
            var me = $(this);
            var contentType = me.find('.content_type:checked').val();
            if(contentType == 'image'){

                var imagePcUrl = me.find('.image_pc_url');
                if (common.isEmpty(imagePcUrl.val())) {
                    alert('pc 이미지 url을 입력해주세요.');
                    imagePcUrl.focus();
                    contentCheck = false;
                    return false;
                }

                var imageMobileUrl = me.find('.image_mobile_url');
                if (common.isEmpty(imageMobileUrl.val())) {
                    alert('모바일 이미지 url을 입력해주세요.');
                    imageMobileUrl.focus();
                    contentCheck = false;
                    return false;
                }

            }else if(contentType == 'button'){
                var buttonType = me.find('.button_type:checked');
                if(common.isEmpty(buttonType.val())){
                    alert('버튼타입을 선택해주세요.');
                    buttonType.focus();
                    contentCheck = false;
                    return false;
                }

                var buttonColor = me.find('.button_color');
                if(common.isEmpty(buttonColor.val())){
                    alert('버튼색상을 입력해주세요.');
                    buttonColor.focus();
                    contentCheck = false;
                    return false;
                }

                var buttonName = me.find('.button_name');
                if(common.isEmpty(buttonName.val())){
                    alert('버튼명을 입력해주세요.');
                    buttonName.focus();
                    contentCheck = false;
                    return false;
                }

                var buttonNameColor = me.find('.button_name_color');
                if(common.isEmpty(buttonNameColor.val())){
                    alert('버튼명 색상을 입력해주세요.');
                    buttonNameColor.focus();
                    contentCheck = false;
                    return false;
                }

                var buttonPcLink = me.find('.button_pc_link');
                if (common.isEmpty(buttonPcLink.val())) {
                    alert('pc 링크를 입력해주세요.');
                    buttonPcLink.focus();
                    contentCheck = false;
                    return false;
                }

                var buttonMobileLink = me.find('.button_mobile_link');
                if (common.isEmpty(buttonMobileLink.val())) {
                    alert('모바일 링크를 입력해주세요.');
                    buttonMobileLink.focus();
                    contentCheck = false;
                    return false;
                }
            }
        });

        return contentCheck;

    }

    function getAddParameter() {
        return data = {
            title : $('#title').val()
            , alwaysYn : $('input[name="alwaysYnCheck"]').is(':checked') ? 1 : 0
            , startDate : $('#eventStartDate').val().replace(/\./g, '-')
            , endDate : $('#eventEndDate').val().replace(/\./g, '-')
            , viewYn : $('input[name="viewYn"]:checked').val()
            , announceYn : $('input[name="announceYn"]:checked').val()
            , prizeSlct : $('#prizeSlct').val()
            , addInfoSlct : $('#addInfoSlct').val()
            , etcUrl : $('#etcUrl').val()
            , pcLinkUrl : $('#pcLinkUrl').val()
            , mobileLinkUrl : $('#mobileLinkUrl').val()
            , listImgUrl : $('#listImgUrl').val()
            , announcementDate : $('#announcementDate').val() == '-' ? '' : $('#announcementDate').val().replace(/\./g, '-')
            , contentJsondata : getContentJsondata()
            , foldYn : $('input:radio[name="foldYn"]:checked').val()
            , notice : $('#eventNotice').val()
        };
    }

    $(document).on('click', '#bt_registerEvent', function() {
        if(checkDate()) {
            if (inputValidation()) {
                if (confirm('등록하시겠습니까?')) {
                    util.getAjaxData("eventAdd", "/rest/content/event/management/add", getAddParameter(), function fn_eventAdd_success(dst_id, response) {
                        alert(response.message);
                        location.reload();
                    });
                }
            }
        }
    });

    function getUpdateParameter() {

        return data = {
            eventIdx : $('#eventidx').val()
            , title : $('#title').val()
            , alwaysYn : $('input[name="alwaysYnCheck"]').is(':checked') ? 1 : 0
            , startDate : $('#eventStartDate').val().replace(/\./g, '-')
            , endDate : $('#eventEndDate').val().replace(/\./g, '-')
            , viewYn : $('input[name="viewYn"]:checked').val()
            , announceYn : $('input[name="announceYn"]:checked').val()
            , prizeSlct : $('#prizeSlct').val()
            , addInfoSlct : $('#addInfoSlct').val()
            , etcUrl : $('#etcUrl').val()
            , pcLinkUrl : $('#pcLinkUrl').val()
            , mobileLinkUrl : $('#mobileLinkUrl').val()
            , listImgUrl : $('#listImgUrl').val()
            , announcementDate : $('#announcementDate').val() == '-' ? null : $('#announcementDate').val().replace(/\./g, '-')
            , contentJsondata : getContentJsondata()
            , foldYn : $('input:radio[name="foldYn"]:checked').val()
            , notice : $('#eventNotice').val()
        };
    }

    function getContentJsondata(){
        var contentList = new Array();
        $('._manageContent').each(function(index){
            var content_type = $(this).find('.content_type:checked').val();

            if(content_type == 'image'){
                var data = {
                    content_type : $(this).find('.content_type:checked').val()
                    , content_order : index
                    , image_pc_url : $(this).find('.image_pc_url').val()
                    , image_mobile_url : $(this).find('.image_mobile_url').val()
                }

            }else if(content_type == 'button'){
                var data = {
                    content_type : $(this).find('.content_type:checked').val()
                    , content_order : index
                    , button_type : $(this).find('.button_type:checked').val()
                    , button_color : $(this).find('.button_color').val()
                    , button_name : $(this).find('.button_name').val()
                    , button_name_color : $(this).find('.button_name_color').val()
                    , button_pc_link : $(this).find('.button_pc_link').val()
                    , button_mobile_link : $(this).find('.button_mobile_link').val()
                }
            }

            contentList.push(data);
        });
        return JSON.stringify(contentList);
    }

    $(document).on('click', '#bt_updateEvent', function() {
        if(checkDate()) {
            if (inputValidation()) {
                if (confirm('수정하시겠습니까?')) {
                    util.getAjaxData("eventUpdate", "/rest/content/event/management/edit", getUpdateParameter(), function fn_eventUpdate_success(dst_id, response) {
                        alert(response.message);
                        location.reload();
                    });
                }
            }
        }
    });

    $(document).on('click', '#bt_deleteOneEvent', function() {
        if(confirm('해당 이벤트를 삭제하시겠습니까?')) {
            var data = {
                eventIdx : $('#eventidx').val()
            };
            util.getAjaxData("eventDeleteOne", "/rest/content/event/management/delete", data, function fn_eventDeleteOne_success(dst_id, response) {
                alert(response.message);
                location.reload();
            });
        }
    });

    function checkDate() {
        var alwaysCheck = $('input[name="alwaysYnCheck"]').is(':checked') ? 1 : 0;
        if (alwaysCheck == 0) {
            if ($('#eventStartDate').val() != '-' && $('#eventEndDate').val() != '-') {
                var startDate = $('#eventStartDate').val().replace(/\./gi, '');
                var endDate = $('#eventEndDate').val().replace(/\./gi, '');

                if (startDate > endDate) {
                    alert('이벤트 기간 날짜를 확인해주세요.');
                    return false;
                } else if (startDate <= endDate) {
                    return true;
                }
            } else if ($('#eventStartDate').val() == '-' || $('#eventEndDate').val() == '-') {
                alert('이벤트 기간 날짜를 확인해주세요.');
                return false;
            }
        }
        if (alwaysCheck == 1) {
            return true;
        }
    }

    function getImg(targetName) {
        var imgUrl = $('input[name="'+targetName+'"]').val();
        if(imgUrl.length == 0) {
            alert('이미지 url을 확인하여 주시기 바랍니다.');
            return false;
        }
        $('#'+targetName+'Viewer').attr('src', imgUrl);
        $('#'+targetName+'Viewer').attr('onerror', 'imgError(this.src)');
    }

    function imgError(imgURL) {
        if(imgURL.length > 0){
            alert("이미지 URL이 정상적이지 않습니다.\n입력 URL :" + imgURL);
        }
    }

    function eventDetail_fullSize(url) {     // 이미지 full size
        $("#eventDetail_fullSize").html(util.imageFullSize("eventDetailFullSize",url));
        $('#eventDetailFullSize').modal('show');
    }

    function getPCWindowOpen(targetName) {
        var url = 'https://www.dalbitlive.com' + $('input[name="' + targetName +'"]').val();
        if(url.length == 0) {
            alert('url 주소를 확인하여 주시기 바랍니다.');
            return false;
        }
        util.windowOpen(url, '1000', '800', '이벤트 상세 링크');
    }

    function getMobileWindowOpen(targetName) {
        var url = 'https://m.dalbitlive.com' + $('input[name="' + targetName +'"]').val();
        if(url.length == 0) {
            alert('url 주소를 확인하여 주시기 바랍니다.');
            return false;
        }
        util.windowOpen(url, '800', '800', '이벤트 상세 링크');
    }

    $(document).on('click', '#addContentBtn', function(){
        var template = $('#tmp_eventContent').html();
        var templateScript = Handlebars.compile(template);
        var context = {
            randomData : Math.floor(Math.random() * 10000)
        };
        var html = templateScript(context);

        var lastContent = $('._eventContent:last');
        if(lastContent.length == 0){
            $("#eventDetail table").after(html);
        }else{
            lastContent.after(html);
        }
    });

    $(document).on('change', '.content_type', function(){
        var me = $(this);
        var table = me.closest('table')

        $(table).find('._tr_imageArea').hide();
        $(table).find('._tr_buttonArea').hide();

        if(me.val() == 'image'){
            $(table).find('._tr_imageArea').show();
        }else if(me.val() == 'button'){
            $(table).find('._tr_buttonArea').show();
        }
    });

    $(document).on('click', '._up', function(){
        var me = $(this);
        var targetTable = me.closest('table');
        var selector = $('._eventContent');
        var targetIndex = selector.index(targetTable);
        if(0 < selector.index(targetTable)){
            $(selector[targetIndex-1]).before(targetTable);
        }
    });

    $(document).on('click', '._down', function(){
        var me = $(this);
        var targetTable = me.closest('table');
        var selector = $('._eventContent');
        var targetIndex = selector.index(targetTable);
        if(targetIndex < selector.length -1){
            $(selector[targetIndex+1]).after(targetTable);
        }
    });

    $(document).on('click', '._delete', function(){
        if(confirm('삭제하시겠습니까?')){
            var me = $(this);
            var targetTable = me.closest('table');

            targetTable.remove();
        }
    });

    $(document).on('click', '.previewImage', function(){
        var me = $(this);
        var url = me.parent().find('input[type="text"]').val();
        var img = me.parent().parent().find('img');
        img.prop('src', url);
    });

</script>

<script id="tmp_eventInfoForm" type="text/x-handlebars-template">
    <input type="hidden" name="datail_eventIdx" id="datail_eventIdx"/>
    <div class="row col-lg-12">
        <table class="table table-bordered table-dalbit" id="eventDetail">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="10%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>이벤트 제목</th>
                <td colspan="5"><input type="text" class="form-control" style="width:100%;" id="title" name="title" placeholder="이벤트 제목을 입력하세요." value="{{replaceHtml title}}"></td>
                <th>이벤트 상태</th>
                <td>{{{getCommonCodeLabel state 'event_stateSlct'}}}</td>
            </tr>
            <tr>
                <th>이벤트 기간</th>
                <td colspan="3">
                    <div class="form-inline" id="eventPeriod">
                        <div class="input-group date" id="div-eventStartDate">
                            <label for="eventStartDate" class="input-group-addon">
                                <span><i class="fa fa-calendar" id="eventStartDateBtn"></i></span>
                            </label>
                            <input type="text" class="form-control _calendar" id="eventStartDate" name="eventStartDate" value="{{convertToDate startDate 'YYYY.MM.DD'}}">
                        </div>
                        <span> ~ </span>
                        <div class="input-group date" id="div-eventEndDate">
                            <label for="eventEndDate" class="input-group-addon">
                                <span><i class="fa fa-calendar" id="eventEndDateBtn"></i></span>
                            </label>
                            <input type="text" class="form-control _calendar" id="eventEndDate" name="eventEndDate" value="{{convertToDate endDate 'YYYY.MM.DD'}}">
                        </div>
                    </div>
                    <input type="checkbox" id="alwaysYnCheck" name="alwaysYnCheck"/> <label for="alwaysYnCheck">상시 이벤트</label>
                </td>
                <th>노출여부</th>
                <td>
                    {{{getCommonCodeRadio viewYn 'event_viewYn'}}}
                </td>
                <th>당첨자 발표</th>
                <td>
                    {{#equal prizeWinner '1'}}
                        {{{getCommonCodeRadio ../announceYn 'event_announceYn_radio'}}}
                    {{else}}
                        (당첨자 집계 중)
                    {{/equal}}
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>{{regDate}}</td>
                <th>등록자</th>
                <td>{{regOpName}}</td>
                <th>최종수정일</th>
                <td>{{lastUpdDate}}</td>
                <th>최종수정자</th>
                <td>{{lastOpName}}</td>
            </tr>
            <tr>
                <th>추가 정보</th>
                <td colspan="3">
                    {{{getCommonCodeSelect addInfoSlct 'event_addInfoSlct'}}}
                    <input type="text" style="width:80%;" id="etcUrl" name="etcUrl" class="form-control _trim" value="{{etcUrl}}" placeholder="기타 선택 시 추가 URL을 입력해주세요."/>
                </td>
                <th>경품 구분</th>
                <td>{{{getCommonCodeSelect prizeSlct 'event_prizeSlct'}}}</td>
                <th>당첨자 발표 날짜</th>
                <td>
                    <div class="form-inline">
                        <div class="input-group date" id="div-announcementDate">
                            <label for="announcementDate" class="input-group-addon" style="width:10%;">
                                <span><i class="fa fa-calendar" id="announcementDateBtn"></i></span>
                            </label>
                            <input type="text" style="width:100%;" class="form-control _calendar" id="announcementDate" name="announcementDate" value="{{convertToDate announcementDate 'YYYY.MM.DD'}}">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>이벤트 상세(PC)</th>
                <td colspan="7">
                    <input type="text" class="form-control _trim pull-left" id="pcLinkUrl" name="pcLinkUrl" placeholder="PC 링크" style="width:70%" value="{{pcLinkUrl}}">
                    <button type="button" class="_pcLinkUrl btn btn-default btn-sm pull-right" onclick="getPCWindowOpen('pcLinkUrl')">미리보기</button>
                </td>
            </tr>
            <tr>
                <th>이벤트 상세(Mobile)</th>
                <td colspan="7">
                    <input type="text" class="form-control _trim pull-left" id="mobileLinkUrl" name="mobileLinkUrl" placeholder="Mobile 링크" style="width:70%" value="{{mobileLinkUrl}}">
                    <button type="button" class="_mobileLinkUrl btn btn-default btn-sm pull-right" onclick="getMobileWindowOpen('mobileLinkUrl')">미리보기</button>
                </td>
            </tr>
            <tr>
                <th>리스트 이미지</th>
                <td colspan="7">
                    <input type="text" class="form-control _trim pull-left" id="listImgUrl" name="listImgUrl" placeholder="이벤트 목록에 보일 이미지 링크" style="width:70%" value="{{listImgUrl}}">
                    <button type="button" class="btn btn-default btn-sm pull-right" onclick="getImg('listImgUrl')">미리보기</button>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <!--미리보기-->
                    <img id="listImgUrlViewer" class="thumbnail" style="max-width:360px; max-height:450px;" onclick="eventDetail_fullSize(this.src);"/>
                </td>
            </tr>
            <tr>
                <th>접기 여부</th>
                <td colspan="7">
                    {{{getCommonCodeRadio foldYn 'event_foldYn'}}}
                </td>
            </tr>
            <tr>
                <th>유의사항</th>
                <td colspan="7">
                    <textarea class="form-control" name="eventNotice" id="eventNotice" placeholder="유의사항을 작성해주세요." style="width: 100%;height: 100%">{{{replaceHtml notice}}}</textarea>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="form-inline pull-left">
            {{#state}}<button class="btn btn-danger btn-sm" type="button" id="bt_deleteOneEvent">이벤트 삭제</button>{{/state}}
        </div>
        <div class="form-inline pull-right">
            <!--<button type="button" class="btn btn-warning btn-sm" id="addContentBtn"><i class="fa fa-plus"></i>컨텐츠 추가</button>-->
            {{^state}}<button class="btn btn-default btn-sm" type="button" id="bt_registerEvent">등록하기</button>{{/state}}
            {{#state}}<button class="btn btn-default btn-sm" type="button" id="bt_updateEvent">수정하기</button>{{/state}}
        </div>
    </div>
</script>

<script id="tmp_eventContent" type="text/x-handlebars-template">
    <table class="table table-bordered table-dalbit _eventContent">
        <colgroup>
            <col width="10%">
            <col width="40%">
            <col width="10%">
            <col width="40%">
        </colgroup>
        <tbody>
            <tr>
                <th>컨텐츠 타입</th>
                <td>
                    {{{getCommonCodeRadioMulti item.button_type 'event_contentType' 'Y' null randomData}}}
                </td>
                <th>순서변경</th>
                <td>
                    <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
                    <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>

                    <button type="button" class="btn btn-default btn-sm pull-right _delete"><i class="toggle-icon fa fa-delete"></i><i class="fa fa-trash-o"></i>삭제</button>
                </td>
            </tr>

            <!-- 이미지 영역 start -->
            <tr class="_tr_imageArea" style="display: none;">
                <th>pc 이미지</th>
                <td colspan="2">
                    <input type="text" class="form-control image_pc_url" style="width:80%" value="">
                    <button type="button" class="previewImage">미리보기</button>
                </td>
                <td>
                    <img src="" height="70px" class="thumbnail fullSize_background">
                </td>
            </tr>

            <tr class="_tr_imageArea" style="display: none;">
                <th>모바일 이미지</th>
                <td colspan="2">
                    <input type="text" class="form-control image_mobile_url" style="width:80%" value="">
                    <button type="button" class="previewImage">미리보기</button>
                </td>
                <td id="mobileImgPrevTd">
                    <img src="" height="70px" class="thumbnail fullSize_background">
                </td>
            </tr>
            <!-- 이미지 영역 end -->

            <!-- 버튼 영역 start -->
            <tr style="display: table-row;" class="_tr_buttonArea">
                <th>버튼 타입</th>
                <td>
                    {{{getCommonCodeRadioMulti item.button_type 'event_content_button_type' 'Y' null randomData}}}
                </td>
                <th>버튼색상</th>
                <td>
                    <input type="text" class="form-control button_color" style="width:80%" value="">
                </td>
            </tr>
            <tr style="display: table-row;" class="_tr_buttonArea">
                <th>버튼명</th>
                <td>
                    <input type="text" class="form-control button_name" style="width:80%" value="">
                </td>
                <th>버튼명 색상</th>
                <td>
                    <input type="text" class="form-control button_name_color" style="width:80%" value="">
                </td>
            </tr>
            <tr style="display: table-row;" class="_tr_buttonArea">
                <th>PC 링크</th>
                <td>
                    <input type="text" class="form-control button_pc_link" style="width:80%" value="">
                </td>
                <th>모바일 링크</th>
                <td>
                    <input type="text" class="form-control button_mobile_link" style="width:80%" value="">
                </td>
            </tr>
            <!-- 버튼 영역 end -->
        </tbody>
    </table>
</script>