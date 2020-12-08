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
                                        <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    </th>
                                    <th id="th_bottonList">
                                        <div>
                                            <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                            <div id="div_dayButton" style="display:none;"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                        </div>
                                    </th>
                                </tr>
                                <tr>
                                    <td style="text-align: left">
                                        <input id="monthDate" type="text" class="form-control"/>
                                        <input id="onedayDate" type="text" class="form-control" style="display:none;" />

                                        <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                        <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                        <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                        <%--<input name="endDate" id="endDate" style="width: 100px">--%>

                                        <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요."></label>

                                        <button type="button" class="btn btn-success" id="bt_search">검색</button>

                                        <a href="javascript://" class="_prevSearch">[이전]</a>
                                        <a href="javascript://" class="_todaySearch">[오늘]</a>
                                        <a href="javascript://" class="_nextSearch">[다음]</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </form>
                <!-- //serachBox -->

                <!-- tab -->
                <div class="row col-lg-12 form-inline">
                    <div class="no-padding" id="listTab">
                        <jsp:include page="listTab.jsp"/>
                    </div>
                </div>
                <!-- //tab -->
        </div> <!-- //container-fluid -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper-->

<jsp:include page="/WEB-INF/view/common/util/select_specialList.jsp"></jsp:include>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    $(function() {
        slctType = 1;
        setDayButton();
    });

    $('#bt_search').on('click', function () {
        $('#dalList, #sampleDalList, #reqDalList').empty();
        /*var tab = $('#tablist_con li.active');
        var tabIndex = $('#tablist_con li').index(tab);*/

        if (TAB_INDEX == 0) {
            shiningList();
        } else if (TAB_INDEX == 1) {
            expectiedList();
        }
    });

    $('input[id="searchText"]').keydown(function () {
        var tab = $('#tablist_con li.active');
        var tabIndex = $('#tablist_con li').index(tab);
        if (event.keyCode == 13) {
            $('#dalList, #sampleDalList, #reqDalList').empty();
            if (tabIndex == 0) {
                init();
            } else if (tabIndex == 1) {

                slctType = 0;
                dateType();
                //initReq();
            }
        }
    });

    function choiceMember(data) {
        if(confirm($('#select_month').val() + '월의 스페셜 DJ로 등록하시겠습니까?')){
            var obj = {
                mem_no : data.mem_no
                , is_force : 1
                , select_year : common.substr($("#startDate").val(),0,4)
                , select_month :  common.substr($("#startDate").val(),5,2)
            };
            util.getAjaxData("ok", "/rest/menu/special/reqOk", obj, fn_success_ok);
        }
        return false;
    }

</script>
