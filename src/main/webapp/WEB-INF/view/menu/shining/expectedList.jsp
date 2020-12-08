<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <%--<div class="widget-header">--%>
        <%--<h3><i class="fa fa-desktop"></i> 검색결과</h3>--%>
    <%--</div>--%>
        <div class="row col-lg-12 mt15">
            <div class="pull-left ml5">
                ㆍ 일자 기준 가입한지 60일 이상 된 자, 일자 기준 현재 스페셜 DJ가 아닌자,<br/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일자 기준 30일 내 15일 이상 방송한 자, 일자 기준 30일 내 20시간 이상 방송한 자를 모두 충족한 유저의 정보<br/>
                ㆍ 방송은 1시간 이상 방송만이 집계됩니다.
            </div>

            <!-- summary -->
            <%--<div class="pull-right">
                <table class="table table-bordered table-summary pull-right">
                    <thead>
                    <th>승인 달D</th>
                    <th style="color: #ff0000;">총 신청 달D</th>
                    </thead>
                    <tbody id="reqSummaryTableBody">
                    </tbody>
                </table>

                &lt;%&ndash;<button type="button" class="btn btn-primary pull-right mt10 mr15" id="bt_manage"><i class="fa fa-floppy-o"></i>신청관리</button>&ndash;%&gt;
            </div>--%>
            <!-- //summary -->

        </div>

        <div class="widget-content">
            <table id="expectedList" class="table table-sorting table-hover table-bordered">
                <thead>
                </thead>
                <tbody id="tableBody">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <span>
                <button type="button" class="btn btn-default btn-sm print-btn pull-right" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
            </span>
        </div>
</div>
<!-- // DATA TABLE -->

<div class="mt15">
    <form id="reqDalList"></form>
</div>

<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#detailView" id="showModal" style="display:none;">레이어팝업오픈버튼</button>
<div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="detailViewLabel" aria-hidden="true"></div>

<script type="text/javascript" src="/js/dataTablesSource/menu/shiningDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">


    function expectiedList() {

        var dtList_info;
        var dtList_info_data = function(data) {
            data.checkDate = $('#onedayDate').val();
        };
        dtList_info = new DalbitDataTable($("#expectedList"), dtList_info_data, shiningDataTableSource.expectedList, $("#searchForm"));
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();

        ui.checkBoxInit('reqSpecialList');
        //dtList_info.reload();
    }

    /*$(document).on('click', '#reqSpecialList .dt-body-center input[type="checkbox"]', function() {
       if($(this).prop('checked')) {
           $('#reqSpecialList .dt-body-center input[type="checkbox"]').removeAttr('checked');
           $(this).prop('checked', 'checked');
           $(this).parent().parent().find('._reqDalDetail').click();
       } else {
           $('#reqDalList').empty();
       }
    });

    $(document).on('click', '#bt_reqOk', function() {
        if(confirm($('select[name=reqSelectMonth]').val() + "월의 스페셜 DJ로 등록하시겠습니까?")) {

            var checkbox = $('#reqSpecialList > tbody > tr > td.dt-body-center > input[type=checkbox]:checked');

            var data = {
                'idx': checkbox.parent().parent().find('._reqDalDetail').data('idx')
                , 'mem_no': checkbox.parent().parent().find('._openMemberPop').data('memno')
                , is_force : 0
                , select_year : $('select[name=reqSelectYear]').val()
                , select_month : $('select[name=reqSelectMonth]').val()
            };
            util.getAjaxData("ok", "/rest/menu/special/reqOk", data, function(dst_id, response){
                alert(response.message);
                getList();
                initReq();
            });
        }
        return false;
    });*/

    // /!*=---------- 엑셀 ----------*!/
    $('#excelDownBtn').on('click', function() {
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        formData.append("checkDate", $('#onedayDate').val());

        util.excelDownload($(this), "/rest/menu/shining/expectedListExcel", formData);
    });

</script>

