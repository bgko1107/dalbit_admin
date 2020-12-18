<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<link rel="stylesheet" href="/css/modal-video.min.css">

<%
    String in_recdate = request.getParameter("recdate");
    String in_weekNo = request.getParameter("weekNo");
    String in_groupNo = request.getParameter("groupNo");
%>

<input class="hide" name="startDate" id="startDate" style="width: 100px">
<input class="hide" name="endDate" id="endDate" style="width: 100px">

<%--<input name="startDate" id="startDate" style="width: 100px">--%>
<%--<input name="endDate" id="endDate" style="width: 100px">--%>

<div id="wrapper">
    <div id="page-wrapper">

        <div class="container-fluid">
            <ul class="nav nav-tabs nav-tabs-custom-colored mb10" role="tablist">
                <li class="active"><a href="" role="tab" data-toggle="tab">대표 클립</a></li>
                <button type="button" class="btn btn-default btn-sm pull-right" onclick="recommendList();">목록보기</button>
                <button type="button" class="btn btn-default btn-sm pull-right mr5" onclick="recommendSelect();">대표 클립 검색</button>
            </ul>
            <%--<button class="pull-right" type="button" class="btn btn-success btn-ms pull-left" onclick="save();">저장하기</button>--%>
            <span id="recommendClipForm"></span>
        </div>

        <div class="col-md-12 mt10" id="recommendClip">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="" role="tab" data-toggle="tab">추천 클립</a></li>
            </ul>
            <table id="table_recommendClip" class="table table-sorting table-hover table-bordered datatable">
                <thead>
                <tr>
                    <th>선택</th>
                    <th>순서변경</th>
                    <th>주제<br/>제목</th>
                    <th>이미지</th>
                    <th>[듣기]<br/>녹음시간</th>
                    <th>등록회원</th>
                    <th>성별(나이)</th>
                    <th>공개</th>
                    <th>상태</th>
                    <th>대표</th>
                </tr>
                </thead>
                <tbody id="tableBody">

                </tbody>
            </table>

            <button type="button" class="btn btn-sm btn-danger" id="deleteBtn">선택삭제</button>
            <button type="button" class="btn btn-sm btn-success pull-right" id="updateBtn">저장하기</button>
        </div>
    </div>
</div>

<%--<div id="imageFullSize"></div>--%>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<%--<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>--%>
<script src="/js/lib/jquery-modal-video.min.js"></script>

<script>
    var recdate = '<%=in_recdate%>';
    var weekNo = <%=in_weekNo%>;
    var groupNo = <%=in_groupNo%>;

    $(document).ready(function() {
        if(!common.isEmpty(recdate) && recdate != null && recdate != "null"){
            getRecommendClip();
        }else{
            getRecommendClipNoData();
        }

        $(document).on('click', '._down', function () {
            var targetTr = $(this).closest('tr');
            var nextTr = targetTr.next();
            targetTr.insertAfter(nextTr);
            resetNo();
            btnSet();
        });

        $(document).on('click', '._up', function () {
            var targetTr = $(this).closest('tr');
            var prevTr = targetTr.prev();
            targetTr.insertBefore(prevTr);
            resetNo();
            btnSet();
        });

        $("#recommendClip").find('#deleteBtn').off('click').on('click', function () {
            var checked = $("#recommendClip").find('#tableBody').find('._check:checked');
            if (0 == checked.length) {
                alert("삭제할 클립을 선택해주세요.");
                return;
            }
            checked.closest('tr').remove();
            resetNo();
            btnSet();
        });

        $("#recommendClip").find("#updateBtn").off('click').on('click', function () {
            var leaderSw = false;
            for(var i=0;i<getArrCodeData().length;i++){
                if(getArrCodeData()[i].leader == "1"){
                    leaderSw = true;
                }
            }
            if(!leaderSw){
                alert("대표클립이 없습니다.");
                return false;
            }

            var castNo = "";
            var order = "";
            var leader = "";
            for(var i=0;i<getArrCodeData().length;i++){
                castNo = castNo == "" ? getArrCodeData()[i].castNo : castNo + "|" + getArrCodeData()[i].castNo;
                order = order == "" ? getArrCodeData()[i].order : order + "|" + getArrCodeData()[i].order;
                leader = leader == "" ? getArrCodeData()[i].leader : leader + "|" + getArrCodeData()[i].leader;
            }

            var data = {
                yearMonth : $("#txt_yearMonth").val()
                ,weekNo : Number($("#txt_weekly").val())
                ,titleMsg : $("#txt_weeklyTitle").val()
                ,descMsg : $("#memo").val()
                ,videoUrl : $("#txt_videoUrl").val()
                ,thumbUrl : $("#txt_thumbnailUrl").val()
                ,viewYn : Number($("#detail_viewOn").is(":checked")? "1" : "0")
                ,castNoList : castNo
                ,orderNoList : order
                ,leaderYnList : leader
                ,groupNo : groupNo == null ? 0 : groupNo
                ,recDate : $("#startDate").val()
            };

            console.log(data);


            util.getAjaxData("list", "/rest/clip/category/recommend/edit", data, fn_submit_success);
        });
    });

    function getRecommendClipNoData(){
        var template = $('#tmp_recommendClipFrm').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#recommendClipForm").html(html);

        var template = $("#tmp_list").html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#recommendClip").find('#tableBody').html(html);

        datePickerSet();
    }

    function getRecommendClip(){
        var data = {
            recDate : recdate
            , groupNo : groupNo
        };

        console.log(data);

        util.getAjaxData("selectReply", "/rest/clip/category/recommend/detail", data, fn_recommendDetai_success);
    }

    function fn_recommendDetai_success(dst_id, response){
        var template = $('#tmp_recommendClipFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.summary;
        var html = templateScript(context);
        $("#recommendClipForm").html(html);

        var template = $("#tmp_list").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#recommendClip").find("#tableBody").append(html);

        resetNo();
        btnSet();

        $("#onedayDate").val(recdate.replace(/-/gi,"."));
        datePickerSet(recdate);
    }

    function representClipAdd(data){

        console.log(data);
        var template = $('#tmp_recommendClipFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = data[0];
        var html = templateScript(context);
        $("#recommendClipForm").html(html);

        var template = $("#tmp_list").html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript(data);
        $("#recommendClip").find('#tableBody tr:first').before(html);
        $("#recommendClip").find('#tableBody tr:eq(1)').remove();

        btnSet();

        datePickerSet();
    }

    function recommendClipAdd(data){
        var beforList = getArrCodeData();
        for(var i=0;i<beforList.length;i++){
            for(var j=0;j<data.length;j++){
                if(beforList[i].castNo == data[j].castNo){
                    data.splice(j, 1);
                }
            }
        }

        if(!common.isEmpty(data)){
            var template = $("#tmp_list").html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript(data);
            $("#recommendClip").find("#tableBody").append(html);

            btnSet();
        }

        datePickerSet();
    }

    function recommendList(){
        location.href = "/clip/category/list?tabMove=3";
    }

    function recommendSelect(){
        var popupUrl = "/clip/category/popup/clipList";
        util.windowOpen(popupUrl,"1458","1050","대표클립 검색");
    }


    function resetNo() {
        $("#recommendClip").find('._noTd').each(function (index) {
            var html = '<input type="hidden" name="sortNo" value="'+(index+1)+'">';
            html += (index+1);
            $(this).html(html);
        });

        $("#recommendClip").find('._noTr').each(function (index) {
            $(this).attr("id", "row_" + (index + 1));
        });
    }

    function btnSet() {
        $("#recommendClip").find('.btn._up').prop('disabled', false);
        $("#recommendClip").find('.btn._down').prop('disabled', false);

        $("#recommendClip").find('.btn._down:last').prop('disabled', true);

        $("#recommendClip").find('.btn._up:first').prop('disabled', true);
        $("#recommendClip").find('.btn._down:first').prop('disabled', true);

        $("#recommendClip").find('.btn._up:eq(1)').prop('disabled', true);

    }


    // 대표 클립이랑 순서가 변경되어서 일단 주석 ------------------
    // function allowDrop(event) {
    //     event.preventDefault();
    // }
    //
    // function drag(event) {
    //     event.dataTransfer.setData("text", event.target.id);
    // }
    //
    // function drop(event) {
    //     event.preventDefault();
    //
    //     var data = event.dataTransfer.getData("text");
    //     var idx = data.split("_")[1];
    //     var targetIdx = $('#table_recommendClip').find(event.target).parent("tr").attr("id").split("_")[1];
    //
    //     if(parseInt(targetIdx) < parseInt(idx)){
    //         $('#table_recommendClip').find(event.target).parent("tr").before($('#table_recommendClip').find("#"+data));
    //     }else{
    //         $('#table_recommendClip').find(event.target).parent("tr").after($('#table_recommendClip').find("#"+data));
    //     }
    //
    //     resetNo();
    //     btnSet();
    // }
    // ----------------------------------------------------------------

    // 데이터
    function getArrCodeData(){
        var arrCode = [];

        var i=0;
        $("#recommendClip").find("#tableBody").find("tr").each(function(){
            var data = {
                castNo : $(this).find('[id="castNo"]').text(),
                order : ++i,
                leader : $(this).find('[id="represent"]').text(),
            };
            arrCode.push(data);
        });

        return arrCode;
    }

    function fn_submit_success(dst_id, response){
        console.log(response.result);
        if(response.result =="success"){
            alert("달대리 추천 클립 등록이 완료되었습니다.");
            recommendList();
        }else{
            alert("달대리 추천 클립 등록 실패하였습니다.");
        }
    }

    function preview(){
        $("#imageFullSize").html(util.imageFullSize("fullSize_background", $("#txt_thumbnailUrl").val()));
        $("#fullSize_background").modal('show');
    }

    function videoSet(){
        $("#test").html('<button class="btn-default btn-xs js-video-button" id="videoPreview" data-video-id=' + $("#txt_videoUrl").val() + ' data-url="">유튜브 팝업</button>').hide();
        $(".js-video-button").modalVideo();
        $('#videoPreview').click();

    }

    function datePickerSet(date){
        $('#onedayDate').datepicker("onedayDate", new Date()).on('changeDate', function(dateText, inst){
            setMonday();
        });
        if(!common.isEmpty(date)){
            setMonday(date);
        }
    }

    function getMonday(str) {
        var y = str.substr(0, 4);
        var m = str.substr(5, 2);
        var d = str.substr(8, 2);
        d = new Date(y,m-1,d);
        var day = d.getDay(),
            diff = d.getDate() - day + (day == 0 ? -6:1);
        return new Date(d.setDate(diff));
    }
    function setMonday(){
        var monday = getMonday($("#onedayDate").val().replace(/-/gi,"."));       // 선택한 날의 월요일
        var startDate = monday;
        var endDate = new Date(Date.parse(monday) + 6 * 1000 * 60 * 60 * 24);
        $("#startDate").val(startDate.getFullYear() + "." + common.lpad(startDate.getMonth() + 1,2,"0") + "." + common.lpad(startDate.getDate(),2,"0"));
        $("#endDate").val(endDate.getFullYear() + "." + common.lpad(endDate.getMonth() + 1,2,"0") + "." + common.lpad(endDate.getDate(),2,"0"));

    }

</script>

<script id="tmp_recommendClipFrm" type="text/x-handlebars-template">
    <div class="col-md-12  no-padding">
        <span>ㆍ대표 추천 클립으로 추천 목록 1번에 고정되어 순서 변경이 불가능 합니다.</span>

    </div>
    <table class="table table-bordered table-dalbit border-black mb0" style="border-color: black">
        <colgroup>
            <col width="5%"><col width="6%"><col width="5%"><col width="10%"><col width="5%">
            <col width="19%"><col width="10%"><col width="15%"><col width="10%"><col width="10%">
        </colgroup>
        <tbody>
        <tr class="align-middle">
            <th>No</th>
            <td>{{idx}}</td>
            <th rowspan="2">이미지</th>
            <td rowspan="2" style="width: 50px">
                <img class="thumbnail fullSize_background no-padding" src="{{renderProfileImage imageBackground}}" style='height:68px; width:68px;margin-bottom: 0px' />
            </td>
            <th>주차</th>
            <td>
                <div class="input-group date" id="oneDayDatePicker">
                    <label for="onedayDate" class="input-group-addon">
                        <span><i class="fa fa-calendar" id="onedayDateBtn"></i></span>
                    </label>
                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">
                </div>
                <%--<input id="onedayDate" type="text" class="form-control" style="width: 196px;"/>--%>
                <%--<div class="col-md-5 no-padding"><input type="text" class="form-control" id="txt_yearMonth"  placeholder="년월 ex) 202012" value="{{yearMonth}}"></div>--%>
                <%--<div class="col-md-5 no-padding"><input type="text" class="form-control" id="txt_weekly" placeholder="주차 ex) 2" value="{{weekNo}}"></div>--%>
            </td>
            <th>추천주제</th>
            <td><input type="text" class="form-control" id="txt_weeklyTitle" value="{{titleMsg}}"></td>
            <th>조회수</th>
            <td>{{addComma viewCnt}}</td>
        </tr>
        <tr>
            <th>플랫폼</th>
            <td>{{{getCommonCodeLabel osType 'clip_platformType'}}}</td>
            <th>클립주제</th>
            <td>{{subjectName}}</td>
            <th>클립 제목</th>
            <td>{{title}}</td>
            <th>게시상태</th>
            <td>{{{getOnOffSwitch viewYn 'viewOn'}}}</td>
        </tr>
        <tr>
            <th>성별<br/>(나이)</th>
            <td>
                {{{sexIcon memSex memBirthYear}}}
            </td>
            <th>등록회원</th>
            <td colspan="3">{{memNick}}<br/>{{memNo}}</td>
            <th>클립 등록일</th>
            <td>{{startDate}}</td>
            <th>등록일시</th>
            <td>{{regDate}}</td>
        </tr>
        <tr>
            <th>소개정보</th>
            <td colspan="7"><textarea type="textarea" class="form-control" id="memo" cols="50" style="height: 100px;width: 100%">{{{replaceTextarea descMsg}}}</textarea></td>
            <th>등록자<br/>최종수정자</th>
            <td></td>
        </tr>
        <tr>
            <th>첨부영상</th>
            <td colspan="5">
                <div class="col-md-10 no-padding">
                    <input type="text" class="form-control" id="txt_videoUrl" value="{{videoUrl}}" placeholder="Youtube video ID 입력 ex) GVGUkA9Uv_w">
                </div>
                <button class="btn-default btn-xs pull-right" onclick="videoSet();">미리보기</button>
                <span id="test"></span>
            </td>
            <th>썸네일</th>
            <td colspan="3">
                <div class="col-md-10 no-padding">
                <input type="text" class="form-control" id="txt_thumbnailUrl" value="{{thumbUrl}}">
                </div>
                <input type="button" class="pull-right btn-default btn-xs" value="미리보기" onclick="preview();">
                <%--<button class="btn-default btn-xs" onclick="preview('thumbnail')">미리보기</button>--%>
            </td>
        </tr>
        </tbody>
    </table>
</script>


<script id="tmp_list" type="text/x-handlebars-template">
    {{#each this}}
    <%--<tr class="_noTr" id="row_{{sortNo}}" ondrop="drop(event)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event)">--%>
    <tr class="_noTr" id="row_{{sortNo}}" >
        <td>
            <input type="checkbox" class="_check" />
        </td>
        <td class="hide" name="castNo" id="castNo">{{castNo}}</td>
        <td>
            <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
        <td>
            {{subjectName}}<br/>
            <a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}">{{title}}</a>
        </td>
        <td style="width: 50px"><img class="thumbnail fullSize_background no-padding" src="{{renderProfileImage imageBackground}}" style='height:50px; width:50px;margin-bottom: 0px' /></td>
        <td>
            {{filePlay}}<br />
            <a class="_openClipPlayerPop" id="play_{{castNo}}" data-clipNo="{{castNo}}" data-clipPath="{{filePath}}" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a>
        </td>
        <td>
            {{memNick}}<br/>
            <a href="javascript://" class="_openMemberPop" data-memno="{{memNo}}">{{memNo}}</a>

        </td>
        <td>{{{sexIcon memSex memBirthYear}}}</td>
        <td>{{{getCommonCodeLabel typeOpen 'clip_typeOpen'}}}</td>
        <td>정상</td>
        <td id="represent" data-represent="{{represent}}">{{represent}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="9" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

