<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm" style="display: none;">
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
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
            <div class="row col-lg-12 form-inline" id="insertBtnDiv">
                <label id="faq_title">ㆍ검색결과 내 질문을 클릭하면 해당 상세정보를 확인할 수 있습니다.</label>
                <button type="button" class="btn btn-default pull-right" id="bt_insert">등록</button>
            </div>
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <span id="search_slctType_aria" onchange="getFaqInfo();"></span>
            </div>

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

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>
<script>
    $(document).ready(function() {

        $('input[id="searchText"]').keydown(function(e) {
            if (e.keyCode === 13) {
                getFaqInfo();
            };
        });

        $('#bt_search').click( function() {       //검색
            getFaqInfo();
        });

        getFaqInfo();
    });

    var dtList_info;
    var dtList_info_data = function ( data ) {
        data.search = $('#searchText').val();                       // 검색명
        data.slctType = $("select[name='slctType']").val();
    };

    dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, FaqDataTableSource.faqInfo, $("#searchForm"));
    dtList_info.useCheckBox(true);
    dtList_info.useIndex(true);
    dtList_info.setPageLength(50);
    dtList_info.createDataTable();

    //검색조건 불러오기
    $("#search_searchType_aria").html(util.getCommonCodeSelect(-1, faq_searchType));
    $("#search_slctType_aria").html(util.getCommonCodeSelect(-1, faq_slctType));

    $("#bt_insert").on("click", function(){
        generateForm();
        ui.unCheck('list_info');
        // scroll 처리
        var scrollPosition = $("#faq_detatil_title").offset();
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
        var scrollPosition = $("#faq_detatil_title").offset();
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
        data["answer"] = $("#editor").summernote('code');
        data["viewOn"] = $("#detail_viewOn").prop('checked') ? 1 : 0;

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
        if($("#mobileBtn").text() == "모바일형태"){
            $("#mobileBtn").text("PC형태");
            $('#div_editor').css({ width: 360});
        }else{
            $("#mobileBtn").text("모바일형태");
            $('#div_editor').css({ width: ''});
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
        dalbitLog(response);

        alert(response.message +'\n- 성공 : ' + response.data.sucCnt + '건\n- 실패 : ' + response.data.failCnt +'건');
        dtList_info.reload();

        $("#faqForm").empty();
    }


    // 검색
    function getFaqInfo(){
        /* 엑셀저장을 위해 조회조건 임시저장 */
        // tmp_search = $('#searchText').val();
        // tmp_gubun = $("select[name='selectGubun']").val();

        dtList_info.reload();

        /*검색결과 영역이 접혀 있을 시 열기*/
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
            <label id="faq_detatil_title">ㆍ선택한 FAQ 정보를 확인/수정/삭제를 할 수 있습니다.</label>
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

                <th>조회수</th>
                <td id="cnt">{{addComma viewCnt}}</td>

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