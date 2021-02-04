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
                                    <span id="blockTypeArea"></span>
                                    <sapn id="blockHistArea"></sapn>
                                    <label><input type="text" class="form-control" id="searchText" name="searchText"></label>
                                    <label><input type="text" class="form-control" id="searchHistText" name="searchHistText"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <button type="button" class="btn btn-success" id="bt_histSearch">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->

            <div class="row col-lg-12">
                <button type="button" class="btn btn-primary pull-right mb15 mr15" id="bt_block"><i class="fa fa-search"></i>차단 등록</button>
            </div>

            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li class="_tab active">
                        <a href="#blockAdmList" id="block" name="block" role="tab" data-toggle="tab" onclick="blockList();">로그인 차단 정보</a>
                    </li>
                    <li class="_tab">
                        <a href="#blcokHistList" id="blockHistory" name="blockHistory" role="tab" data-toggle="tab" onclick="blockHistList();">로그인 차단/해지 내역</a>
                    </li>
                </ul>
            </div>
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table no-margin">
                    <div class="tab-content no-padding">
                        <div class="tab-pane fade in active" id="blockAdmList">
                            <div class="widget-content">
                                <table id="tb_blockAdmList" class="table table-sorting table-hover table-bordered">
                                    <thead></thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                            <div class="widget-footer">
                                <button type="button" id="bt_delete" class="btn btn-danger btn-sm">차단 해지</button>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="blcokHistList">
                            <div class="widget-content">
                                <table id="tb_blockHistList" class="table table-sorting table-hover table-bordered">
                                    <thead></thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //DATA TABLE -->

            <div class="row col-lg-12" id="blockDetail"></div>

        </div> <!-- //container-fluid -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper-->

<script src="/js/dataTablesSource/customer/blockAdmDataTableSource.js?${dummyData}"></script>
<script src="/js/code/customer/blockAdmCodeList.js?${dummyData}"></script>
<jsp:include page="/WEB-INF/view/common/util/select_blockList.jsp"/>

<script type="text/javascript">

    $(function() {
        $('#blockTypeArea').html(util.getCommonCodeSelect(-1, block_blockType));
        $('#searchArea').html(util.getCommonCodeSelect(-1, block_searchType));
        $('#blockHistArea').html(util.getCommonCodeSelect(-1, blockHist_histType));
        getBlockList();

        $('#blockHistArea').hide();
        $('#searchHistText').hide();
        $('#bt_histSearch').hide();
    });

    $('#bt_search').on('click', function() {
        getBlockList();
    });

    $('input[id="searchText"]').keydown(function() {
        if (event.keyCode === 13) {
            getBlockList();
        }
    });

    $('#bt_histSearch').on('click', function() {
        getBlockHistoryList();
    });

    $('input[id="searchHistText"]').keydown(function() {
        if (event.keyCode === 13) {
            getBlockHistoryList();
        }
    });

    function blockList() {
        $('#blockDetail').show();

        getBlockList();

        $('#blockTypeArea').show();
        $('#searchArea').show();
        $('#searchText').show();
        $('#bt_search').show();

        $('#blockHistArea').hide();
        $('#searchHistText').hide();
        $('#bt_histSearch').hide();
    }

    function blockHistList() {
        $('#blockDetail').hide();

        getBlockHistoryList();

        $('#blockHistArea').show();
        $('#searchHistText').show();
        $('#bt_histSearch').show();

        $('#blockTypeArea').hide();
        $('#searchArea').hide();
        $('#searchText').hide();
        $('#bt_search').hide();

    }

    var dtList_info;
    function getBlockList() {
        var dtList_info_data = function (data) {
            data.blockType = $('#blockType').val();     // 차단 유형 구분
            data.searchType = $('#searchType').val();   // 검색 유형 구분
            data.searchText = $('#searchText').val();   // 검색어 구분
        };

        dtList_info = new DalbitDataTable($('#tb_blockAdmList'), dtList_info_data, blockAdmDataTableSource.blockAdmList, $('#searchForm'));
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.useInitReload(true);
        dtList_info.setPageLength(50);
        dtList_info.createDataTable();

        $("#blockDetail").empty();

    }

    $(document).on('click', '#tb_blockAdmList .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')){
            $(this).parent().parent().find('._blockDetail').click();
        } else {
            $("#blockDetail").empty();
        }
    });

    $(document).on('click', '._blockDetail', function() {
       var data = {
           report_idx : $(this).data('reportidx')
           , idx : $(this).data('idx')
       };
       util.getAjaxData('detail', '/rest/customer/blockAdm/detail', data, fn_detail_success);
    });

    function fn_detail_success(dst_id, response){
        var template = $('#tmp_blockDetail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $('#blockDetail').html(html);

        var scrollPosition = $("#blockDetail").offset();
        util.scrollPostion(scrollPosition.top);
    }

    function fullSize_background(url) {
        if(common.isEmpty(url)){
            return;
        }

        $("#imageFullSize").html(util.imageFullSize("fullSize_background", url));
        $('#fullSize_background').modal('show');
    }

    function modal_close(){
        $("#fullSize_background").modal('hide');
    }

    $('#bt_block').on('click', function() {
        showBlockPop();
    });

    $(document).on('click', '#ipUuidBlockBtn', function() {
        if(blockValidation()) {
            if (confirm("해당 ip/deviceUuid를 차단하시겠습니까?")) {
                util.getAjaxData("insertBlock", "/rest/customer/blockAdm/insertBlock", $('#blockForm').serialize(), fn_insertBlock_success);
            }
            return false;
        }
    });

    function blockValidation() {
        var text = $("#blockForm #block_text");
        if(common.isEmpty(text.val())) {
            alert("ip/Uuid를 입력해주세요.");
            text.focus();
            return false;
        }

        var memo = $("#blockForm #adminMemo");
        if(common.isEmpty(memo.val())) {
            alert("운영자 메모를 입력해주세요.");
            memo.focus();
            return false;
        }
        return true;
    }

    function fn_insertBlock_success(dst_id, response) {
        alert(response.message);

        getBlockList();
    }

    $('#bt_delete').on('click', function() {
       var checked = $('#tb_blockAdmList > tbody > tr > td.dt-body-center > input[type=checkbox]:checked');
       if(checked.length == 0) {
           alert("차단 해지할 사항을 선택해주세요.");
           return;
       }

       if(confirm(checked.length + '건의 사항을 해지하시겠습니까?')){
           var blockIdxs = "";
           checked.each(function() {
               blockIdxs += $(this).parent().parent().find('._blockDetail').data('idx') + ",";
           });

           var data = {
               blockIdxs : blockIdxs
               , block_type : $(this).parent().parent().find('._blockDetail').data('block_type')
               , block_text : $(this).parent().parent().find('._blockDetail').data('block_text')
               , report_idx : $(this).parent().parent().find('._blockDetail').data('report_idx')
           };
           dalbitLog(data);
           util.getAjaxData("delete", "/rest/customer/blockAdm/deleteBlock", data, fn_deleteBlock_success);
       }
    });

    function fn_deleteBlock_success(dst_id, response) {
        dalbitLog(response.data);
        alert(response.message + '\n- 성공 : ' + response.data.sucCnt + '건\n- 실패 : ' + response.data.failCnt + '건');

        getBlockList();
    }


    function getBlockHistoryList() {
         var dtList_info_data2 = function (data) {
             data.searchType = $('#searchType').val();   // 검색 유형 구분
             data.searchHistText = $('#searchHistText').val();   // 검색어 구분
         };

        dtList_info = new DalbitDataTable($('#tb_blockHistList'), dtList_info_data2, blockAdmDataTableSource.blockHistList, $('#searchForm'));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.createDataTable();

        dtList_info.reload();

    }
</script>

<script type="text/x-handlebars-template" id="tmp_blockDetail">
    <table class="table table-bordered table-dalbit mt15" id="blockDetail_table">
        <colgroup>
            <col width="5%" />
            <col width="15%" />
        </colgroup>
        <tbody>
        {{^equal report_idx ""}}
        <tr>
            <th>기타 신고 메시지</th>
            <td>{{{replaceHtml ../op_msg}}}</td>
        </tr>
        {{/equal}}
        {{#equal report_idx ""}}
        <tr>
            <th>운영자 메모</th>
            <td>{{../adminMemo}}</td>
        </tr>
        {{/equal}}
        </tbody>
    </table>
</script>