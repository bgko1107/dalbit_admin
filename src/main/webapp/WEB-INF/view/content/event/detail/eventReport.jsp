
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <!-- DATA TABLE -->
    <div class="row col-lg-12 form-inline">
        <div class="widget widget-table" id="eventReportDataTable">
            <span id="event_summaryArea"></span>
            <div class="widget-content">
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- DATA TABLE END -->
</div>

<form id="noticeForm"></form>

<!-- modal -->
<div class="modal fade" id="eventReportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="_layerTitle">응모일시</h4>
            </div>
            <div class="modal-body" style="display: table;">
                <div class="col-md-12 no-padding" id="div_report" style="margin-bottom: 7px"></div><br/>
            </div>
        </div>
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {

    });

    var fnc_eventReport = {};

//=------------------------------ Init / Event--------------------------------------------
    fnc_eventReport.targetId= "eventReport";

    fnc_eventReport.init= function() {
        fnc_eventReport.target = $("#"+fnc_eventReport.targetId);
        fnc_eventReport.targetDataTableId = "list_info_"+fnc_eventReport.targetId;
        fnc_eventReport.target.find("#list_info").attr("id", fnc_eventReport.targetDataTableId);
        fnc_eventReport.targetDataTable = fnc_eventReport.target.find("#"+fnc_eventReport.targetDataTableId);
        fnc_eventReport.divDataTable = fnc_eventReport.targetDataTable.parent("div");

        /** 선택된 데이터 정보 조회  */
        if(!common.isEmpty(getSelectDataInfo())){
            console.log(getSelectDataInfo());
            fnc_eventReport.dataKey = getSelectDataInfo().dataKey;
            fnc_eventReport.data = getSelectDataInfo().data;
        }else{
            fnc_eventReport.dataKey = null;
            fnc_eventReport.data = null;
        }

        fnc_eventReport.initDataTable();
        fnc_eventReport.initEvent();
        // this.getEventReportSubData();

        var scrollPosition = $("#tab_"+fnc_eventReport.targetId).offset();
        util.scrollPostion(scrollPosition.top);
    };


    fnc_eventReport.dtList_info= "";
    fnc_eventReport.initDataTable= function(){
        console.log(event_idx);
        //=---------- Main DataTable ----------
        var dtList_info_data = function ( data ) {
            console.log("event_idx : " + common.isEmpty(fnc_eventReport.data)?"-1":fnc_eventReport.data.idx);
            data.event_idx = common.isEmpty(fnc_eventReport.data)?"-1":fnc_eventReport.data.idx;
            data.pageCnt = 20;
        };
        fnc_eventReport.dtList_info = new DalbitDataTable(fnc_eventReport.targetDataTable, dtList_info_data, EventDataTableSource.report);
        fnc_eventReport.dtList_info.useCheckBox(true);
        fnc_eventReport.dtList_info.useIndex(true);
        fnc_eventReport.dtList_info.setPageLength(-1);
        fnc_eventReport.dtList_info.createDataTable(this.initSummary);

        fnc_eventReport.initDataTableButton();
        //---------- Main DataTable ----------=
    };


    fnc_eventReport.order= 0;
    fnc_eventReport.reportData= "";
    fnc_eventReport.initSummary= function(json) {
        dalbitLog(json);
        fnc_eventReport.order = 0;
        fnc_eventReport.reportData = json;
        for(var i=0 ; i<json.data.length;i++){
            if(fnc_eventReport.order < json.data[i].order){
                fnc_eventReport.order = json.data[i].order;
            }
        }

        //전체 선택 체크박스 비활성화
        // $("#list_info_" + fnc_eventReport.targetId +"-select-all").hide();

        var template = $("#event_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#event_summaryArea").html(html);
    };


    // DataTable Button
    fnc_eventReport.initDataTableButton= function() {
        var winnerBtn = '<input type="button" value="선택당첨" class="btn btn-success btn-sm" id="btn_winner" style="margin-left: 3px;"/>'
        var insertNoticeBtn = '<input type="button" value="바로 공지하기" class="btn btn-success btn-sm" id="btn_insertNotice" style="margin-left: 3px;"/>'
        // var winnerDelBtn = '<input type="button" value="당첨취소" class="btn btn-danger btn-sm" id="btn_winnerDel" style="margin-left: 3px;"/>'
        var excelBtn = '<button class="btn btn-default print-btn btn-sm" type="button" style="margin-left: 3px;"><i class="fa fa-print"></i>Excel Down</button>'


        fnc_eventReport.divDataTable = fnc_eventReport.targetDataTable.parent("div");

        fnc_eventReport.divDataTable.find(".footer-left").append(winnerBtn);
        fnc_eventReport.divDataTable.find(".footer-left").append(insertNoticeBtn);
        // this.divDataTable.find(".footer-right").append(winnerDelBtn);
        // fnc_eventReport.divDataTable.find(".footer-right").append(excelBtn);
    };

    fnc_eventReport.initEvent= function(){
        fnc_eventReport.target.find("#btn_insertNotice").on("click", function () { //등록
            fnc_eventReport.insertNoticeEvent();
        });

        fnc_eventReport.target.find("#btn_winner").on("click", function () { //선택당첨
            fnc_eventReport.winnerEvent();
        });


        fnc_eventReport.targetDataTable.children('tbody').on('change', 'input[type="checkbox"]', function () {
            var idx = fnc_eventReport.targetDataTable.children('tbody').find('input[type="checkbox"]').index(this);

            if (this.checked) {
                if($(this).parent("td").parent("tr").find("td:eq(2)").text() == "선정"){
                    return;
                }
                fnc_eventReport.order++;
                $(this).parent("td").parent("tr").find("td:eq(2)").text("선정");
                $(this).parent("td").parent("tr").find("td:eq(3)").text(fnc_eventReport.order);
                fnc_eventReport.targetDataTable.DataTable().row(idx).data().choiceNum = fnc_eventReport.order;
            }else{
                if(fnc_eventReport.reportData.data[idx].is_win == 1){
                    $(this).parent("td").parent("tr").find("td:eq(2)").text("선정");
                    $(this).parent("td").parent("tr").find("td:eq(3)").text(fnc_eventReport.reportData.data[idx].order);
                }else{
                    var oriNum = $(this).parent("td").parent("tr").find("td:eq(3)").text();
                    $(this).parent("td").parent("tr").find("td:eq(2)").text("대기중");
                    $(this).parent("td").parent("tr").find("td:eq(3)").text("0");
                    delete fnc_eventReport.targetDataTable.DataTable().row(idx).data().choiceNum;
                    fnc_eventReport.order--;

                    fnc_eventReport.targetDataTable.children('tbody').find('input[type="checkbox"]').each(function(){
                        if(this.checked){
                            var num = $(this).parent("td").parent("tr").find("td:eq(3)").text();
                            if(num > oriNum){
                                $(this).parent("td").parent("tr").find("td:eq(3)").text(num - 1);
                            }
                        }
                    });
                }
            }
        })
    };

//=------------------------------ Option --------------------------------------------
    // 등록
    fnc_eventReport.insertNoticeEvent= function() {
        //공지 바로 등록
        fnc_eventReport.generateForm();
    };

    // 삭제
    fnc_eventReport.deleteEvent= function() {
        var checkDatas = dtList_info.getCheckedData();
        if(checkDatas.length <= 0){
            alert("삭제할 정보를 선택해주세요.");
            return false;
        }
        if(confirm("선택하신 " + checkDatas.length + "건의 정보를 삭제 하시겠습니까?")){
        };

    };

    //당첨자 지정선택
    fnc_eventReport.checkDatas= "";
    fnc_eventReport.winnerEvent=function() {
        fnc_eventReport.checkDatas = fnc_eventReport.dtList_info.getCheckedData();
        if(fnc_eventReport.checkDatas.length <= 0){
            alert("당첨자를 선택해주세요.");
            return false;
        }
        for(var i=0;i<fnc_eventReport.checkDatas.length;i++){
            util.getAjaxData("memberSelWin", "/rest/content/event/memberSelWin",fnc_eventReport.checkDatas[i], fnc_eventReport.event_win_success, fnc_eventReport.event_win_fail);
        }
    };

    fnc_eventReport.event_win_success= function(dst_id, response){
        if(response.result == "fail"){
            return false;
        }
        fnc_eventReport.dtList_info.reload(fnc_eventReport.initSummary);
    };
    fnc_eventReport.event_win_fail= function(dst_id, data){
        console.log("에러!!!");
        fnc_eventReport.dtList_info.reload(fnc_eventReport.initSummary);
    };

    //응모횟수 모달 데이터 셋팅
    fnc_eventReport.setModalData= function(idx){
        var data = fnc_eventReport.dtList_info.getDataRow(idx)
        if(data.applyCnt < 2){
            return false;
        }
        util.getAjaxData("info", "/rest/content/event/overlapApplyList", data, fnc_eventReport.applyList_success, fnc_eventReport.event_win_fail);
    };

    fnc_eventReport.applyList_success= function(dst_id, response) {
        $('#div_report').empty();
        for (var i = 0; i < response.data.length; i++) {
            var tmp = '<div class="col-md-12 no-padding">';
            tmp += '<label id="nickName' + i + '"></label><label id="userId' + i + '" style="color: #6e696e"></label> - <label id="writeDateFormat' + i + '"></label> <br/>';
            tmp += '</div>';
            $('#div_report').append(tmp + "<br/>");
            $('#nickName' + i).text(response.data[i].mem_nick);
            $('#userId' + i).text(response.data[i].mem_userid);
            $('#writeDateFormat' + i).text(response.data[i].enterDateFormat);
        }

        $('#eventReportModal').modal("show");
    };

    fnc_eventReport.editor_text= "";
    fnc_eventReport.generateForm= function() {
        fnc_eventReport.checkDatas = fnc_eventReport.dtList_info.getCheckedData();
        if(fnc_eventReport.checkDatas.length <= 0){
            alert("당첨자를 선택해주세요.");
            return false;
        }

        var sortArray=[];
        for (var i=0;i<fnc_eventReport.checkDatas.length;i++){
            var sortDate = {
                order : "",
                mem_no:"",
                mem_userid : "",
                mem_nick : ""
            };
            console.log(fnc_eventReport.checkDatas[i]);
            if(fnc_eventReport.checkDatas[i].order == 0) {
                sortDate.order = fnc_eventReport.checkDatas[i].choiceNum;
            }else{
                sortDate.order = fnc_eventReport.checkDatas[i].order;
            }
            sortDate.mem_no = fnc_eventReport.checkDatas[i].mem_no;
            sortDate.mem_userid = fnc_eventReport.checkDatas[i].mem_userid;
            sortDate.mem_nick = fnc_eventReport.checkDatas[i].mem_nick;
            sortArray[i] = sortDate;
        }
        sortArray.sort(function (a, b) {
            if (a.order > b.order) {
                return 1;
            }
            if (a.order < b.order) {
                return -1;
            }
            return 0;
        });

        fnc_eventReport.editor_text = "";
        for (var i=0;i<sortArray.length;i++){
            var no = i+1;
            fnc_eventReport.editor_text =  fnc_eventReport.editor_text + no +". "+ sortArray[i].mem_no + " / " + sortArray[i].mem_nick +'<br>';
        }

        var template = $('#tmp_noticeFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#noticeForm").html(templateScript);

        util.editorInit("content-notice");
        console.log(fnc_eventReport.editor_text);
        $("#editor").summernote('code', '<div style="text-align: center;">' + fnc_eventReport.editor_text + '</div>');
    };

    // 공지사항 등록
    fnc_eventReport.generateFormData= function(){
        var data = {};
        var formArray = $("#noticeForm").serializeArray();
        for (var i = 0; i < formArray.length; i++){
            data[formArray[i]['name']] = formArray[i]['value'];
        }
        data["contents"] = $("#editor").summernote('code');
        data["viewOn"] = $("#detail_viewOn").prop('checked') ? 1 : 0;

        dalbitLog(data);

        return data;
    };

    fnc_eventReport.fn_insert_success= function(dst_id, response) {
        for(var i=0;i<fnc_eventReport.checkDatas.length;i++){
            util.getAjaxData("memberSelWin", "/rest/content/event/memberSelWin",fnc_eventReport.checkDatas[i], fnc_eventReport.event_win_success, fnc_eventReport.event_win_fail);
        }

        $("#noticeForm").empty();
    };



    $(document).on('click', '#insertBtn_report', function(){
        if(isValid_report()){
            if(confirm('등록하시겠습니까?')){
                util.getAjaxData("insert", "/rest/content/notice/insert", fnc_eventReport.generateFormData(), fnc_eventReport.fn_insert_success);
            }
        }
    });

    function isValid_report(){
        var slctType = $("#noticeForm #slctType");
        if(common.isEmpty(slctType.val())){
            alert("구분을 선택해주세요.");
            slctType.focus();
            return false;
        }
        var title = $("#noticeForm #title");
        if(common.isEmpty(title.val())){
            alert("제목을 입력해주세요.");
            title.focus();
            return false;
        }
        var editor = $("#editor");
        if(editor.summernote('isEmpty')){
            alert("내용을 입력해주세요.");
            editor.focus();
            return false;
        }
        return true;
    }

    function titleInput(){
        var tmp = "";
        tmp = $("#title").val() + '<br><br>' + "당첨을 축하 드립니다." + '<br><br>' + fnc_eventReport.editor_text;
        $("#editor").summernote('code', '<div style="text-align: center;">' + tmp + '<div>');

    }

    // object를 키 이름으로 정렬하여 반환

        // /*=---------- 엑셀 ----------*/
        // $('#excelDownBtn').on('click', function(){
        //     var formElement = document.querySelector("form");
        //     var formData = new FormData(formElement);
        //
        //     formData.append("search", tmp_search);
        //     formData.append("date", tmp_date);
        //     formData.append("gubun", tmp_gubun);
        //     formData.append("checkDate", tmp_checkDate);
        //     formData.append("stDate", tmp_stDate);
        //     formData.append("edDate", tmp_edDate);
        //     /*formData.append("test003", "test003");*/
        //     excelDownload($(this), "/rest/member/member/listExcel", formData, fn_success_excel, fn_fail_excel)
        // });

        // $("#excelBtn").on("click", function () {
        //     $("#list_info").table2excel({
        //         exclude: ".noExl",
        //         name: "Excel Document Name",
        //         filename: "report" +'.xls', //확장자를 여기서 붙여줘야한다.
        //         fileext: ".xls",
        //         exclude_img: true,
        //         exclude_links: true,
        //         exclude_inputs: true
        //     });
        // });
        //
        // function fn_success_excel(){
        //     console.log("fn_success_excel");
        // }
        //
        // function fn_fail_excel(){
        //     console.log("fn_fail_excel");
        // }
        /*----------- 엑셀 ---------=*/
</script>


<!-- =------------------ Handlebars ---------------------------------- -->
<script id="event_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" id="declarationSummary">
        <thead>
            <tr class="align-middle">
                <th colspan="2">총 응모자</th>
                <th colspan="2" rowspan="2">중복 응모</th>
                <th colspan="2">당첨자</th>
            </tr>
            <tr>
                <th><label style="color: blue">남</label></th>
                <th><label style="color: red">여</label></th>
                <th><label style="color: blue">남</label></th>
                <th><label style="color: red">여</label></th>
            </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{#equal length '0'}}0{{/equal}}{{content.maleCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.femaleCnt}}명</td>
            <td colspan="2">{{#equal length '0'}}0{{/equal}}{{content.overlapCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.maleWinCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.femaleWinCnt}}명</td>
        </tbody>
    </table>
</script>


<script id="tmp_noticeFrm" type="text/x-handlebars-template">
    <input type="hidden" name="noticeIdx" value="{{noticeIdx}}" />
    <div class="row col-lg-12 mt15">
        <div class="col-md-12 no-padding">
            <label id="notice_title">ㆍ선택한 공지사항을 자세히 확인하고 수정할 수 있습니다.<br> ㆍ공지내용 수정 또는 등록 후 게시상태를 ON으로 선택한 후 등록을 완료하여야 공지 내용이 게시됩니다.</label>
            <span>
                {{^noticeIdx}}<button class="btn btn-default pull-right" type="button" id="insertBtn_report">등록하기</button>{{/noticeIdx}}
            </span>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>No</th>
                <td>{{noticeIdx}}</td>

                <th>구분</th>
                <td>{{{getCommonCodeSelect slctType 'notice_slctType' 'Y' ''}}}</td>

                <th>제목</th>
                <td colspan="5"><input type="text" name="title" id="title" class="form-control" value="{{title}}" maxlen onkeypress="titleInput();" onkeyup="titleInput();"></td>

                <th>조회수</th>
                <td>{{addComma viewCnt}}</td>
            </tr>
            <tr>
                <th>플랫폼</th>
                <td>{{{getCommonCodeSelect platform 'platform'}}}</td>

                <th>성별</th>
                <td>{{{getCommonCodeSelect gender 'gender'}}}</td>

                <th>등록일시</th>
                <td>{{writeDate}}</td>

                <th>게시중지일시</th>
                <td>
                    {{offDate}}
                    {{#equal offDate ''}}-{{/equal}}
                </td>

                <th>처리자</th>
                <td>{{opName}}</td>
                <th>게시상태</th>
                <td>
                    {{{getOnOffSwitch viewOn 'viewOn'}}}
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row col-lg-12 form-inline">
        <div class="widget">
            <div class="widget-header">
                <h3><i class="fa fa-user"></i> 내용 </h3>
            </div>
            <div class="widget-content no-padding">
                <div class="_editor" id="editor" name="editor" >{{{replaceHtml contents}}}</div>
            </div>
        </div>
    </div>
</script>
