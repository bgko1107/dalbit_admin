<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <span id="search_slctType_aria" style="display: none"></span>

                                    <span id="macroTypeArea">
                                        <label class="control-inline fancy-radio custom-color-green">
                                            <input type="radio" value="0" name="macroType" class="form-control" checked="checked">
                                            <span><i></i>자동 답변</span>
                                        </label>
                                        <label class="control-inline fancy-radio custom-color-green">
                                            <input type="radio" value="1" name="macroType" class="form-control">
                                            <span><i></i>1:1문의 답변</span>
                                        </label>
                                    </span>

                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->

            <div class="row col-lg-12 form-inline" style="padding-top: 2px; padding-bottom: 15px;">
                <div class="widget-content">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                        <li><a href="/status/question/info?tabType=1" id="tab_totalDetail">총계</a></li>
                        <li><a href="/status/question/info?tabType=2" id="tab_typeDetail">유형별</a></li>
                        <li><a href="/status/question/info?tabType=3" id="tab_platformDetail">플랫폼별</a></li>
                        <li><a href="/status/question/info?tabType=4" id="tab_untreatedDetail">미처리</a></li>
                        <li><a href="/customer/question/list?tabType=0" >전체 문의</a></li>
                        <%--<li><a href="" role="tab" data-toggle="tab" onclick="tab_questionClick(1)" >회원 문의</a></li>--%>
                        <%--<li><a href="" role="tab" data-toggle="tab" onclick="tab_questionClick(2)">비회원 문의</a></li>--%>
                        <li class="active"><a  href="" role="tab" data-toggle="tab">매크로 관리</a></li>
                    </ul>
                </div>
            </div>

            <div id="macro">
                <!-- DATA TABLE -->
                <div class="row col-lg-12 form-inline">
                    <div class="col-md-12 no-padding pull-right">
                        <button type="button" class="btn btn-default pull-right" id="bt_macroInsert">등록</button>
                    </div>
                    <div class="widget widget-table">
                        <div class="widget-content">
                            <table id="macroList" class="table table-sorting table-hover table-bordered">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div class="widget-footer">
                            <span>
                                <button class="btn btn-default" type="button" id="bt_macroDelete">선택삭제</button>
                            </span>
                        </div>
                    </div>
                </div>

                <form id="macroForm"></form>
            </div>

            <div id="nonMacro" style="display: none">
                <div class="row col-lg-12 form-inline" id="insertBtnDiv">
                    <label id="faq_title">ㆍ검색결과 내 질문을 클릭하면 해당 상세정보를 확인할 수 있습니다.</label>
                    <button type="button" class="btn btn-default pull-right" id="bt_insert">등록</button>
                </div>
                <!-- DATA TABLE -->
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table">
                        <div class="widget-header">
                            <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                        </div>
                        <div class="widget-content">
                            <table id="list_info" class="table table-sorting table-hover table-bordered">
                                <thead>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                        <div class="widget-footer">
                            <span>
                                <button class="btn btn-default" type="button" id="bt_delete">선택삭제</button>
                            </span>
                            <span>
                                <button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                            </span>
                        </div>
                    </div>
                </div>
                <!-- #DataTable -->

                <form id="faqForm"></form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>
<script>

    var macroType=0;
    getMacroList();
    $(document).ready(function() {

        $('input[id="searchText"]').keydown(function(e) {
            if (e.keyCode === 13) {
                if(macroType == 0) {
                    getMacroList();
                }else{
                    getFaqInfo();
                }
            };
        });

        $('#bt_search').click( function() {       //검색
            console.log(macroType);
            if(macroType == 0){
                getMacroList();
            }else{
                getFaqInfo();
            }
        });

    });

    // 자동답변 시작 ------------------------------------------------------------------------------
    $("input[name='macroType']").change(function (){
       $("#macro").hide();
       $("#nonMacro").hide();
        macroType = $(this).val();
       if(macroType == 0){
           getMacroList();
           $("#macro").show();
       } else {
           getFaqInfo();
           $("#nonMacro").show();
       }
    });

    // 목록
    var dtList_macro;
    function getMacroList(){
        var dtList_info_data = function ( data ) {
            data.search = $('#searchText').val();                       // 검색명
        };

        dtList_macro = new DalbitDataTable($("#macroList"), dtList_info_data, questionDataTableSource.macroList);
        dtList_macro.useCheckBox(true);
        dtList_macro.useIndex(true);
        dtList_macro.createDataTable();
    }

    function getMacroDetail(idx, rowNum){
        console.log(idx);
        console.log(rowNum);

        var data = {};
        data.idx = idx;
        data.rowNum = rowNum;
        util.getAjaxData("macroDetail", "/rest/customer/question/macro/detail", data, fn_macroDetail_success);

    }

    function fn_macroDetail_success(dst_id, response, param){
        response.data.rowNum = param.rowNum;
        var template = $("#tmp_macroFrm").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#macroForm").html(html);

        util.editorInit("question");

        var scrollPosition = $("#macroForm").offset();
        util.scrollPostion(scrollPosition.top);

    }

    $("#bt_macroInsert").on('click',function (){
        var template = $("#tmp_macroFrm").html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#macroForm").html(html);

        util.editorInit("question");

    });

    $("#bt_macroDelete").on('click',function (){
        console.log("선택삭제");

        var checkDatas = dtList_macro.getCheckedData();
        if(checkDatas.length == 0){
            alert('삭제할 자동답변을 선택해주세요.');
            return;
        }

        if(confirm(checkDatas.length + "개의 자동답변을 삭제하시겠습니까?")){
            var idxs = '';

            for(var i=0;i<checkDatas.length;i++){
                idxs = checkDatas[i].idx + "@" + idxs;
            }
            var data = {
                idxs : idxs
            };

            util.getAjaxData("delete", "/rest/customer/question/macro/del", data, fn_macroEdit_success);
        }

    });

    $(document).on('click', '#macroDeleteBtn', function(){
        $('.note-editable').empty();
    });

    function isMacroValid(){
        if(common.isEmpty($("#macroForm").find("#timeValue").val())){
            alert("시간설정을 입력해 주십시어");
            return false;
        }

        if(common.isEmpty($("#macroForm").find("#title").val())){
            alert("제목을 입력해 주십시오");
            return false;
        }
        var editor = $("#macroForm").find("#editor");
        if(editor.summernote('isEmpty')){
            alert("답변을 입력해주세요.");
            return false;
        }
        return true;
    }
    function macroData(){
        var data = {};
        data["msg"] = $("#macroForm").find("#editor").summernote('code');
        data["viewYn"] = $("#macroForm").find("#detail_viewOn").prop('checked') ? 1 : 0;
        data["title"] = $("#macroForm").find("#title").val();
        data["timeValue"] = $("#macroForm").find("#timeValue").val();
        data["idx"] = common.isEmpty($("#macroForm").find("#idx").val()) ? 0 : $("#macroForm").find("#idx").val();

        console.log(data);

        return data;
    }
    $(document).on('click', '#macroInsertBtn', function(){
        if(isMacroValid()){
            if(confirm("등록하시겠습니까?")){
                console.log(macroData());
                util.getAjaxData("insert", "/rest/customer/question/macro/edit", macroData(), fn_macroEdit_success);
            }
        }
    });

    $(document).on('click', '#macroUpdateBtn', function(){
        if(isMacroValid()){
            if(confirm("수정하시겠습니까?")) {
                console.log(macroData());
                util.getAjaxData("update", "/rest/customer/question/macro/edit", macroData(), fn_macroEdit_success);
            }
        }
    });

    function fn_macroEdit_success(dst_id, response){
        $("#macroForm").empty();
        getMacroList();
    }
    // 자동답변 끝   ------------------------------------------------------------------------------


    // 1:1 문의 답변 시작--------------------------------------------------------------------------
    var dtList_info;
    var dtList_info_data = function ( data ) {
        data.search = $('#searchText').val();                       // 검색명
        data.gubun = $("select[name='selectGubun']").val()
    };

    dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, FaqDataTableSource.macroFaqInfo, $("#searchForm"));
    dtList_info.useCheckBox(true);
    dtList_info.useIndex(true);
    dtList_info.createDataTable();

    //검색조건 불러오기
    $("#search_slctType_aria").html(util.getCommonCodeSelect(99, faq_slctType));

    $("#bt_insert").on("click", function(){
        generateForm();
        ui.unCheck('list_info');
        // scroll 처리
        var scrollPosition = $("#faqForm").offset();
        util.scrollPostion(scrollPosition.top);
        // code
        var data = {};
        data.type="faq_slctType";
        util.getAjaxData("codeList", "/common/codeList", data, fn_getCode_success);
    });

    function generateForm() {
        var template = $('#tmp_faqFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#faqForm").html(templateScript);
        //getFaqInfo();

        // uploadType 추가
        util.editorInit("administrate-faq");
    }
    var faqIdx;
    function getFaqDetail(index){
        var data = dtList_info.getDataRow(index);
        faqIdx = data.faqIdx;
        var obj = {};
        obj.faqIdx = data.faqIdx;
        obj.rowNum = data.rowNum;
        util.getAjaxData("detail", "/rest/administrate/faq/detail", obj, fn_detail_success);
    }

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().find('._getFaqDetail').click();
        }
    });

    var slctType ="";
    function fn_detail_success(dst_id, response, params) {
        // form 띄우기
        response.data["rowNum"] = params.rowNum;
        var template = $('#tmp_faqFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#faqForm").html(html);

        // uploadType 추가
        util.editorInit("administrate-faq");

        // scroll 처리
        var scrollPosition = $("#faqForm").offset();
        util.scrollPostion(scrollPosition.top);

        slctType = response.data.slctType;
        // code
        var data = {};
        data.type="faq_slctType";
        util.getAjaxData("codeList", "/common/codeList", data, fn_getCode_success);

    }
    function fn_getCode_success(dst_id, response) {
        var template = $("#tmp_faqSlctType").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#_faqSlctType").html(html);

        if(slctType != "" ){
            $("#_faqSlctType").find("#slctType").val(slctType).prop("selected", true);
        }else{
            $("#_faqSlctType").find("#slctType").val(1).prop("selected", true);
        }
    }

    function isValid(){
        var slctType = $("#faqForm #slctType");
        if(common.isEmpty(slctType.val())){
            alert("구분을 선택해주세요.");
            slctType.focus();
            return false;
        }

        var question = $("#faqForm #question");
        if(common.isEmpty(question.val())){
            alert("질문을 입력해주세요.");
            question.focus();
            return false;
        }

        var editor = $("#editor");
        if(editor.summernote('isEmpty')){
            alert("답변을 입력해주세요.");
            editor.focus();
            return false;
        }
        return true;
    }

    function generateData(){
        var data = {};
        var formArray = $("#faqForm").serializeArray();
        for (var i = 0; i < formArray.length; i++){
            data[formArray[i]['name']] = formArray[i]['value'];
        }
        data["answer"] = $("#faqForm").find("#editor").summernote('code');
        data["viewOn"] = $("#faqForm").find("#detail_viewOn").prop('checked') ? 1 : 0;

        dalbitLog(data);

        return data;
    }

    $(document).on('click', '#insertBtn', function(){
        if(isValid()){
            if(confirm("등록하시겠습니까?")){
                util.getAjaxData("insert", "/rest/administrate/faq/insert", generateData(), fn_insert_success);
            }
        }
    });

    $(document).on('click', '#updateBtn', function(){
        if(isValid()){
            if(confirm("수정하시겠습니까?")) {
                util.getAjaxData("update", "/rest/administrate/faq/update", generateData(), fn_insert_success);
            }
        }
    });
    $(document).on('click', '#deleteBtn', function(){
        $('.note-editable').empty();
    });

    function mobileBtnClick(tmp){

        if(macroType == 0){
            if($("#macroForm").find("#mobileBtn").text() == "모바일형태"){
                $("#macroForm").find("#mobileBtn").text("PC형태");
                $("#macroForm").find('#div_macroEditor').css({ width: 360});
            }else{
                $("#macroForm").find("#mobileBtn").text("모바일형태");
                $("#macroForm").find('#div_macroEditor').css({ width: ''});
            }
        }else{
            if($("#faqForm").find("#mobileBtn").text() == "모바일형태"){
                $("#faqForm").find("#mobileBtn").text("PC형태");
                $("#faqForm").find('#div_editor').css({ width: 360});
            }else{
                $("#faqForm").find("#mobileBtn").text("모바일형태");
                $("#faqForm").find('#div_editor').css({ width: ''});
            }
        }
    }

    function fn_insert_success(dst_id, response) {
        alert(response.message);
        dtList_info.reload();

        $("#faqForm").empty();
    }

    $(document).on('click', '#bt_delete', function() {
        var checked = $('#list_info > tbody > tr > td.dt-body-center input[type=checkbox]:checked');
        if(checked.length == 0){
            alert('삭제할 FAQ를 선택해주세요.');
            return;
        }

        if(confirm(checked.length + "개의 FAQ를 삭제하시겠습니까?")){
            var faqIdxs = '';
            checked.each(function(){
                faqIdxs += $(this).parent().parent().find('._getFaqDetail').data('idx') + ",";
            });
            var data = {
                faqIdxs : faqIdxs
            };

            util.getAjaxData("delete", "/rest/administrate/faq/delete", data, fn_delete_success);
        }

    });

    function fn_delete_success(dst_id, response) {
        alert(response.message +'\n- 성공 : ' + response.data.sucCnt + '건\n- 실패 : ' + response.data.failCnt +'건');
        dtList_info.reload();

        $("#faqForm").empty();
    }


    // 검색
    function getFaqInfo(){
        dtList_info.reload();
        ui.toggleSearchList();
    }

    // /*=---------- 엑셀 ----------*/
    $('#excelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        util.excelDownload($(this), "/rest/administrate/faq/listExcel", formData, fn_success_excel, fn_fail_excel)
    });

    $("#excelBtn").on("click", function () {
        $("#list_info").table2excel({
            exclude: ".noExl",
            name: "Excel Document Name",
            filename: "report" +'.xls', //확장자를 여기서 붙여줘야한다.
            fileext: ".xls",
            exclude_img: true,
            exclude_links: true,
            exclude_inputs: true
        });
    });

    // 1:1 문의 답변 끝 ---------------------------------------------------------------------------------------

    function fn_success_excel(){
        console.log("fn_success_excel");
    }

    function fn_fail_excel(){
        console.log("fn_fail_excel");
    }
    /*----------- 엑셀 ---------=*/

</script>

<script id="tmp_faqFrm" type="text/x-handlebars-template">
    <input type="hidden" name="faqIdx" value="{{faqIdx}}" />
    <div class="row col-lg-12 form-inline mt15">
        <div class="col-md-12 no-padding">
            <span class="pull-right">
                <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일형태</button>
                <button class="btn btn-danger" type="button" id="deleteBtn">내용삭제</button>
                {{^faqIdx}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/faqIdx}}
                {{#faqIdx}}<button class="btn btn-default" type="button" id="updateBtn">수정하기</button>{{/faqIdx}}
            </span>
        </div>
    </div>
    <div class="row col-lg-12">
        <table class="table table-bordered table-dalbit" style="margin-bottom: 0px;">
            <colgroup>
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="10%" />
                <col width="5%" />
                <col width="10%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th rowspan="2">No</th>
                <td rowspan="2" id="no">{{rowNum}}</td>

                <th>구분</th>
                <td id="_faqSlctType"></td>
                <%--<td>{{{getCommonCodeSelect slctType 'faq_slctType' 'Y' 'slctType'}}}</td>--%>

                <th>질문</th>
                <td colspan="5"><input type="text" name="question" id="question" class="form-control" value="{{question}}"></td>
            </tr>
            <tr>
                <th>사이트 적용</th>
                <!--<td id="viewOn"></td>-->
                <td>{{{getOnOffSwitch viewOn 'viewOn'}}}</td>

                <th>등록일시</th>
                <td id="regDate">{{writeDate}}</td>

                <th>수정일시</th>
                <td id="cnt">{{last_upd_date}}</td>

                <th>처리자</th>
                <td id="processor">{{opName}}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row col-lg-12 form-inline">
        <div class="widget" id="div_editor">
            <div class="widget-header">
                <h3><i class="fa fa-user"></i> 답변 </h3>
            </div>
            <div class="_editor" id="editor" name="editor" onkeypress="contentsCheck();">{{{replaceHtml answer}}}</div>
        </div>
    </div>
</script>
<script id="tmp_faqSlctType" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>


<script id="tmp_macroFrm" type="text/x-handlebars-template">
    <input type="hidden" name="idx" id="idx" value="{{idx}}" />
    <div class="row col-lg-12 form-inline mt15">
        <div class="col-md-12 no-padding">
            <span class="pull-right">
                <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일형태</button>
                <button class="btn btn-danger" type="button" id="macroDeleteBtn">내용삭제</button>
                {{^idx}}<button class="btn btn-default" type="button" id="macroInsertBtn">등록하기</button>{{/idx}}
                {{#idx}}<button class="btn btn-default" type="button" id="macroUpdateBtn">수정하기</button>{{/idx}}
            </span>
        </div>
    </div>
    <div class="row col-lg-12">
        <table class="table table-bordered table-dalbit" style="margin-bottom: 0px;">
            <colgroup>
                <col width="11.1%" /><col width="11.1%" /><col width="11.1%" /><col width="11.1%" /><col width="11.1%" />
                <col width="11.1%" /><col width="11.1%" /><col width="11.1%" /><col width="11.1%" /><col width="11.1%" />
                <col width="11.1%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th rowspan="2">No</th>
                <td rowspan="2">{{rowNum}}</td>
                <th>시간설정</th>
                <td>
                    <div class="col-md-7 no-padding">
                        <input type="text" class="form-control" name="timeValue" id="timeValue" value="{{timeValue}}">
                    </div>
                    <div class="col-md-5 no-padding" style="margin-top:7px">
                        <span>분 후</span>
                    </div>
                </td>
                <th>등록일시</th>
                <td>{{regDate}}</td>
                <th>수정일시</th>
                <td>{{updDate}}</td>
                <th>등록자명</th>
            </tr>
            <tr>
                <td>자동답변</td>
                <td>{{{getOnOffSwitch viewYn 'viewOn'}}}</td>
                <th>제목</th>
                <td colspan="3"><input type="text" class="form-control" name="title" id="title" value="{{title}}"></td>
                <td>{{opName}}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row col-lg-12 form-inline">
        <div class="widget" id="div_macroEditor">
            <div class="widget-header">
                <h3><i class="fa fa-user"></i> 답변 </h3>
            </div>
            <div class="_editor" id="editor" name="editor" onkeypress="contentsCheck();">{{{replaceHtml msg}}}</div>
        </div>
    </div>
</script>
