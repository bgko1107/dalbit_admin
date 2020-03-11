<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 공지검색</h3>
                            <div>
                                <span id="search_platform_aria"></span>
                                <span id="search_searchType_aria"></span>
                                <span id="search_slctType_aria"></span>
                                <span id="search_viewOn_aria"></span>

                                <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="text" id="dummy" style="display:none;">
            </form>
            <!-- //serachBox -->
            <div class="row col-lg-12 form-inline" id="insertBtnDiv">
                <button type="button" class="btn btn-default pull-right" id="bt_insert">등록</button>
            </div>
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                        <div class="btn-group widget-header-toolbar">
                            <a href="#" title="열기/닫기" class="btn-borderless btn-toggle-expand">
                                <i class="fa fa-chevron-up" id="_searchToggleIcon"></i>
                            </a>
                        </div>
                    </div>
                    <div class="widget-content">
                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                            <thead>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                        <span>
                            <button type="button" class="btn btn-default" id="bt_delete">선택삭제</button>
                        </span>
                        <span>
                            <button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Print</button>
                        </span>
                    </div>
                </div>
            </div>
            <!-- #DataTable -->

            <form id="noticeForm"></form>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js"></script>
<script>
    $(document).ready(function() {

        $('input[id="searchText"]').keydown(function(e) {
            if (e.keyCode === 13) {
                getNoticeInfo();
            };
        });

        $('#bt_search').click( function() {       //검색
            getNoticeInfo();
        });

        getNoticeInfo();

    });

    $('#notice_title').html("ㆍ선택한 공지사항을 자세히 확인하고 수정할 수 있습니다.<br> ㆍ공지내용 수정 또는 등록 후 게시상태를 ON으로 선택한 후 등록을 완료하여야 공지 내용이 게시됩니다.");

    init();
    function init(){
        var dtList_info_data = function ( data ) {
            data.search = $('#searchText').val();                       // 검색명
            data.gubun = $("select[name='selectGubun']").val()
        };

        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, NoticeDataTableSource.noticeInfo, $("#searchForm"));
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();

        //검색조건 불러오기
        $("#search_platform_aria").html(getCommonCodeSelect(-1, search_platform));
        $("#search_searchType_aria").html(getCommonCodeSelect(-1, notice_searchType));
        $("#search_slctType_aria").html(getCommonCodeSelect(-1, notice_slctType));
        $("#search_viewOn_aria").html(getCommonCodeSelect(-1, viewOn));
    }

    $("#bt_insert").on("click", function(){
        generateForm();
    });

    function generateForm() {
        var template = $('#tmp_noticeFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#noticeForm").html(templateScript);

        editorInit();
    }

    $(document).on('click', '._getNoticeDetail', function(){
        var data = {
            'noticeIdx' : $(this).data('idx')
        };
        getAjaxData("detail", "/rest/content/notice/detail", data, fn_detail_success);
    });

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().find('._getNoticeDetail').click();
        }
    });

    function fn_detail_success(dst_id, response) {
        var template = $('#tmp_noticeFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#noticeForm").html(html);

        editorInit();

    }

    function fn_detail_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }

    function isValid(){

        var slctType = $("#noticeForm #slctType");
        if(isEmpty(slctType.val())){
            alert("구분을 선택해주세요.");
            slctType.focus();
            return false;
        }

        var title = $("#noticeForm #title");
        if(isEmpty(title.val())){
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

    $(document).on('click', '#insertBtn', function(){
        if(isValid()){
            var data = $("#noticeForm").serialize() +  '&contents=' + $("#editor").summernote('code');
            console.log(data);

            getAjaxData("insert", "/rest/content/notice/insert", data, fn_insert_success);
        }
    });

    function fn_insert_success(dst_id, response) {
        dalbitLog(response);
        alert(response.message);
        generateForm();
        dtList_info.reload();

        $("#noticeForm").empty();
    }
    function fn_insert_fail(data, textStatus, jqXHR) {
        console.log(data, textStatus, jqXHR);
    }

    $(document).on('click', '#updateBtn', function(){

        if(isValid()){
            var data = $("#noticeForm").serialize() +  '&contents=' + $("#editor").summernote('code');

            console.log(data);
            getAjaxData("update", "/rest/content/notice/update", data, fn_update_success);
        }
    });

    function fn_update_success(dst_id, response) {
        dalbitLog(response);
        alert(response.message);
        generateForm();
        dtList_info.reload();

        $("#noticeForm").empty();
    }

    $(document).on('click', '#bt_delete', function() {

        var checked = $('#list_info .dt-body-center input[type="checkbox"]:checked');
        if(checked.length == 0){
            alert('삭제할 공지사항을 선택해주세요.');
            return;
        }

        if(confirm(checked.length + "건의 공지사항을 삭제하시겠습니까?")){
            var noticeIdxs = '';
            checked.each(function(){
                noticeIdxs += $(this).parent().parent().find('._getNoticeDetail').data('idx') + ",";
            });
            var data = {
                noticeIdxs : noticeIdxs
            }
            dalbitLog(data);

            getAjaxData("delete", "/rest/content/notice/delete", data, fn_delete_success);
        }

    });

    function fn_delete_success(dst_id, response) {
        dalbitLog(response);

        alert(response.message +'\n- 성공 : ' + response.data.sucCnt + '건\n- 실패 : ' + response.data.failCnt +'건');
        dtList_info.reload();

        $("#noticeForm").empty();
    }

    // 검색
    function getNoticeInfo(){
        /* 엑셀저장을 위해 조회조건 임시저장 */
        /*tmp_search = $('#searchText').val();
        tmp_gubun = $("select[name='selectGubun']").val();*/

        dtList_info.reload();

        /*검색결과 영역이 접혀 있을 시 열기*/
        var toggleIcon = $('#_searchToggleIcon');
        if(toggleIcon.hasClass('fa-chevron-down')){
            toggleIcon.click();
        }
    }

    // /*=---------- 엑셀 ----------*/
    $('#excelDownBtn').on('click', function(){

        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        excelDownload($(this), "/rest/content/notice/listExcel", formData, fn_success_excel)
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
    /*----------- 엑셀 ---------=*/
</script>

<script id="tmp_noticeFrm" type="text/x-handlebars-template">
    <input type="hidden" name="noticeIdx" value="{{noticeIdx}}" />
    <div class="row col-lg-12">
        <div class="col-md-12 no-padding">
            <label id="notice_title">ㆍ선택한 공지사항을 자세히 확인하고 수정할 수 있습니다.<br> ㆍ공지내용 수정 또는 등록 후 게시상태를 ON으로 선택한 후 등록을 완료하여야 공지 내용이 게시됩니다.</label>
            <span>
                {{^noticeIdx}}<button class="btn btn-default pull-right" type="button" id="insertBtn">등록하기</button>{{/noticeIdx}}
                {{#noticeIdx}}<button class="btn btn-default pull-right" type="button" id="updateBtn">수정하기</button>{{/noticeIdx}}
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
                    <td>{{{getCommonCodeSelect platform 'notice_slctType' 'Y'}}}</td>

                    <th>제목</th>
                    <td colspan="5"><input type="text" name="title" id="title" class="form-control" value="{{title}}" maxlen></td>

                    <th>조회수</th>
                    <td>{{viewCnt}}</td>
                </tr>
                <tr>
                    <th>플랫폼</th>
                    <td>{{{getCommonCodeSelect platform 'platform'}}}</td>

                    <th>성별</th>
                    <td>{{{getCommonCodeSelect gender 'gender'}}}</td>

                    <th>등록일시</th>
                    <td>{{writeDate}}</td>

                    <th>게시중지일시</th>
                    <td>-</td>

                    <th>처리자</th>
                    <td>{{opName}}</td>
                    <th>게시상태</th>
                    <td>-</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="row col-lg-12 form-inline area_style">
        <div class="widget">
            <div class="widget-header">
                <h3><i class="fa fa-user"></i> 내용 </h3>
            </div>
            <div class="summernote" id="editor" name="editor">{{{replaceHtml contents}}}</div>
        </div>
    </div>

</script>