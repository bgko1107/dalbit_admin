<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
            <div class="col-lg-7 form-inline no-padding">
                <div class="widget widget-table searchBoxArea">
                    <table>
                        <tr>
                            <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                <i class="fa fa-search"></i><br/>검색
                                <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>
                                <input type="hidden" name="startDate" id="startDate">
                                <input type="hidden" name="endDate" id="endDate" />

                                <%--<input name="startDate" id="startDate">--%>
                                <%--<input name="endDate" id="endDate" />--%>

                                <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                <a href="javascript://" class="_prevSearch">[이전]</a>
                                <a href="javascript://" class="_todaySearch">[오늘]</a>
                                <a href="javascript://" class="_nextSearch">[다음]</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

             <div class="col-md-5 no-padding pull-right">
                <table class="pull-right _tableHeight" style="text-align: left;width: 670px;border: 1px solid black" data-height="23px">
                    <colgroup>
                        <col width="8%"><col width="48%"><col width="8%"><col width="36%">
                    </colgroup>
                    <tr>
                        <td rowspan="3" style="text-align: left" class="font-bold"><span style="font-size: 9px">결제상태</span></td>
                        <td style="text-align: left"><span style="font-size: 11px"><span style="color: blue" class="font-bold">Y (성공)</span> : 결제 성공</span></td>
                        <td rowspan="3"  style="text-align: left" class="font-bold"><span style="font-size: 11px">취소상태</td>
                        <td style="text-align: left"><span style="font-size: 11px"><span style="color: blue" class="font-bold">O (성공)</span> : 취소 성공</span></td>
                    </tr>
                    <tr>
                        <td style="text-align: left"><span style="font-size: 11px"><span style="color: black" class="font-bold">N (시도)</span> : 결제 시도를 했으나 창을 닫거나 멈춘경우</span></td>
                        <td style="text-align: left"><span style="font-size: 11px"><span style="color: red" class="font-bold">X (불가)</span> : 취소 불가</span></td>
                    </tr>
                    <tr>
                        <td style="text-align: left"><span style="font-size: 11px"><span style="color: red" class="font-bold">F (실패)</span> : 결제창까지 이르렀으나 완료 실패</span></td>
                        <td style="text-align: left"><span style="font-size: 11px"><span style="color: black" class="font-bold">F (실패)</span> : 취소 시도후 사유로 인한 실패</span></td>
                    </tr>
                </table>
            </div>

            <!-- //serachBox -->
        </form>
        <div id="payList"><jsp:include page="./payList.jsp"/></div>

    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script type="text/javascript">

    $(document).ready(function() {

        slctType = 3;

        setTimeDate(dateTime);
        $("#rangeDatepicker").show();

        txt_search = $('#txt_search').val();
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();
        memberDataType = 99;
        getPayList("payment");

    });

    $('input[id="txt_search"]').keydown(function() {
        if (event.keyCode === 13) {
            getPaySearch();
        };
    });

    $('#bt_search').click( function() {       //검색
        getPaySearch();
    });

    function getPaySearch(){
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();

        txt_search = $('#txt_search').val();
        tmp_sDate = sDate;
        tmp_eDate = eDate;
        memberDataType = 99;
        slctType = 0;
        dtList_info_pay.reload(pay_listSummary);
    }

</script>