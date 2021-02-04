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
                                    <span id="search_slctType_aria"></span>

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
                <button type="button" class="btn btn-default btn-sm pull-right mb5" id="bt_insert">등록</button>
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
                            <button type="button" class="btn btn-danger btn-sm" id="bt_delete">선택삭제</button>
                        </span>
                        <span>
                            <button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
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
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
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
        dtList_info.setPageLength(50);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();

        //검색조건 불러오기
        $("#search_searchType_aria").html(util.getCommonCodeSelect(-1, notice_searchType));
        $("#search_slctType_aria").html(util.getCommonCodeSelect(-1, notice_slctType));
    }

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            // $('#list_info .dt-body-center input[type="checkbox"]').removeAttr('checked'); => 선택삭제 때문에 중복이 필요할 것 같아서 주석처리합니다!
            $(this).prop('checked', 'checked');
            $(this).parent().parent().find('._getNoticeDetail').click();
        } else {
            $('#noticeForm').empty();
        }
    });

    $(document).on('click', '#bt_delete', function() {

        var checked = $('#list_info > tbody > tr > td.dt-body-center > input[type=checkbox]:checked');
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
            };
            dalbitLog(data);

            util.getAjaxData("delete", "/rest/content/notice/delete", data, fn_delete_success);
        }

    });

    function fn_delete_success(dst_id, response) {
        alert(response.message +'\n- 성공 : ' + response.data.sucCnt + '건\n- 실패 : ' + response.data.failCnt +'건');
        dtList_info.reload();

        $("#noticeForm").empty();
    }

    // 검색
    function getNoticeInfo(){
        /* 엑셀저장을 위해 조회조건 임시저장 */
        tmp_search = $('#searchText').val();
        tmp_gubun = $("select[name='selectGubun']").val();

        dtList_info.reload();

        ui.toggleSearchList();
    }

    $("#bt_insert").on("click", function(){
        location.href = "/content/notice/noticeEdit?noticeIdx=0&rowNum=0";
    });

    // /*=---------- 엑셀 ----------*/
    $('#excelDownBtn').on('click', function(){

        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        util.excelDownload($(this), "/rest/content/notice/listExcel", formData, fn_success_excel)
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

    $(document).on('click', '._notice', function() {
       alert("준비중입니다.");
    });


</script>