<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-md-12 no-padding">
    <span>
        * 가입 후 7일 이내의 신입회원에게 방송 알림 Push가 발송됩니다.</br>
        * 운영자 직접 등록 후 저장을 클릭해야 등록이 완료됩니다.
    </span>
</div>
<div class="col-md-1 no-padding">
    <span id="newcomer_status_area" onchange="getList();"></span>
</div>
<div class="col-md-1 no-padding pull-right">
    <button type="button" class="btn btn-primary pull-right" id="memSearch" name="memSearch"><i class="fa fa-search"></i>운영자 직접 등록</button>
</div>
<div class="widget-content col-md-12 no-padding">
    <table class="table table-sorting table-hover table-bordered datatable" id="table_list">
        <thead>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<button type="button" class="btn btn-danger pull-left" id="newcomerDel" onclick="newcomerDel();">선택 삭제</button>
<div class="col-md-12 no-padding">
    <span id="newcomerMemberInfo" ></span>
</div>

<jsp:include page="/WEB-INF/view/common/util/select_specialList.jsp"></jsp:include>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/menu/recommDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        getList();

        $("#newcomer_status_area").html(util.getCommonCodeSelect(0, recomm_status));
    });

    var dtList;
    function getList() {
        var dtList_info_data = function (data) {
            data.slctType = $("#recomm_status").val();
        };
        dtList = new DalbitDataTable($("#table_list"), dtList_info_data, recommDataTableSource.newcomerList);
        dtList.useCheckBox(true);
        dtList.useIndex(true);
        dtList.setPageLength(50);
        dtList.createDataTable();

        var template = $('#tmp_newcomerMemberInfo').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#newcomerMemberInfo").html(html);
        ui.paintColor();

        var scrollPosition = $("#newcomerMemberInfo").offset();
        util.scrollPostion(scrollPosition.top);

    }

    $('#memSearch').on('click', function() {
        showPopMemberList(choiceMember);
    });

    function choiceMember(data) {
        var obj = {
            mem_no : data.mem_no
        };
        util.getAjaxData("newcomer", "/rest/content/newcomer/detail", obj, fn_newcomerMember_success);
    }

    function fn_newcomerMember_success(dst_id, response, param){

        response.data.send_title = response.data.send_title.replace(/\\n/gi, "\r\n");
        response.data.send_cont = response.data.send_cont.replace(/\\n/gi, "\r\n");

        var template = $('#tmp_newcomerMemberInfo').html();
        var templateScript = Handlebars.compile(template);
        var data = response.data;
        var html = templateScript(data);
        $("#newcomerMemberInfo").html(html);
        ui.paintColor();

        var scrollPosition = $("#newcomerMemberInfo").offset();
        util.scrollPostion(scrollPosition.top);

    }
    function newcomerEdit() {
        if(confirm('신입회원 PUSH를 저장 하시겠습니까?')) {
            var data = {
                mem_no: $("#newcomer_mem_no").text()
                , send_title: $("#send_title").val()
                , send_cont: $("#send_cont").val()
                , viewYn: $("#detail_viewOn").prop('checked') ? 1 : 0
            };

            console.log(data);

            util.getAjaxData("newcomer", "/rest/content/newcomer/edit", data, fn_newcomerEdit_success);
        }
    }


    function fn_newcomerEdit_success(dst_id, response, param){
        if(response.result != "success"){
            alert("오류");
            return;
        }
        getList();
    }

    function newcomerDel() {

        var checkDatas = dtList.getCheckedData();

        if(checkDatas.length == 0){
            alert('삭제할 신입회원을 Check 하세요.');
            return;
        }
        if(confirm('선택한 신입회원을 삭제 하시겠습니까?')){
            var memNoList = "";
            for(var i=0;i<checkDatas.length;i++){
                memNoList += checkDatas[i].mem_no + "@@";
            }
            var data = {
                memNoList : memNoList
            };

            util.getAjaxData("newcomer", "/rest/content/newcomer/delete", data, getList );
        }
    }

    function pushDetail(idx){
        var data = dtList.getDataRow(idx);

        util.getAjaxData("newcomer", "/rest/content/newcomer/detail", data, fn_newcomerMember_success);
    }
</script>

<script id="tmp_newcomerMemberInfo" type="text/x-handlebars-template">

    <button type="button" class="btn btn-success pull-right" id="newcomerEdit" onclick="newcomerEdit();">저장</button>

    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <colgroup>
            <col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
            <col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
        </colgroup>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">No</th>
            <td>{{idx}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">회원번호</th>
            <td><a href="javascript://" class="_openMemberPop" data-memno="{{mem_no}}" id="newcomer_mem_no">{{mem_no}}</a></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">닉네임</th>
            <td>{{mem_nick}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">등록일시<br/>최종수정일시</th>
            <td>{{reg_date}}<br/>{{last_upd_date}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">등록자<br/>최종수정자</th>
            <td>{{reg_opName}}<br/>{{last_opName}}</td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">제목</th>
            <td colspan="4" ><input type="text" class="form-control" name="send_title" id="send_title" value="{{send_title}}"></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">최근 방송일시</th>
            <td>{{last_broadcast}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">사용여부</th>
            <td>{{{getOnOffSwitch viewYn 'viewOn'}}}</td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">PUSH 문구</th>
            <td colspan="4"><input type="text" class="form-control" name="send_cont" id="send_cont" value="{{send_cont}}"></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">최근 7일 방송시간</th>
            <td>{{timeStampDay broadcastTime}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">누적 발송건수</th>
            <td>{{addComma pushCnt}} 건</td>
        </tr>
    </table>
</script>