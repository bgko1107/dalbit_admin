<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
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
                                <label><input type="text" class="form-control" id="searchText" placeholder="검색할 정보를 입력하세요."></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
        <!-- //serachBox -->
        <div class="row col-lg-12 form-inline">
            <input type="button" value="등록" class="btn btn-success btn-sm mb10 pull-right" id="registerButton"/>
        </div>

        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline mb10">
            <div class="widget widget-table">
                <div class="widget-content">
                    <span id="search_eventState" onchange="btSearchClick();"></span>
                    <span id="search_eventWinner" onchange="btSearchClick();"></span>
                    <table id="list_eventInfo" class="table table-sorting table-hover table-bordered">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="widget-footer">
                    <span>
                        <button type="button" class="btn btn-danger btn-sm" id="bt_deleteEvent">선택삭제</button>
                    </span>
                </div>
            </div>
        </div>
        <!-- DATA TABLE END -->
        <div class="main-content mt10" id="div_eventTabList" style="display: none;">
            <!-- TAB -->
            <jsp:include page="eventTab.jsp"/>
            <!-- TAB -->
        </div>
    </div>
</div>

<input type="hidden" id="eventidx" value="0"/>
<input type="hidden" id="prizeslct"/>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("#search_eventState").html(util.getCommonCodeSelect(-1, event_stateSlct));
        $("#search_eventWinner").html(util.getCommonCodeSelect(-1, event_announceYn));

        getEventList();
    });

    $('input[id="searchText"]').keydown(function() {
        if (event.keyCode === 13) {
            getEventList();
        };
    });

    $('#bt_search').click( function() {       //검색
        getEventList();
    });

    function getEventList() {
        var dtList_info_data = function(data) {
            data.stateSlct = $('#stateSlct').val();
            data.announceSlct = $('#announceYn').val();
            data.searchText = $('#searchText').val();
        };
        var dtList_info = new DalbitDataTable($('#list_eventInfo'), dtList_info_data, EventDataTableSource.eventList, $('#searchForm'));
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();
    }


    $('#registerButton').on('click', function() {
        $("#eventidx").val(0);

        $('#tab_eventDetail').click();
        showTab();
    });

    $(document).on('click', '._getEventDetail', function() {
        var eventidx = $(this).data('eventidx');
        $("#eventidx").val(eventidx);

        $('#tab_eventDetail').click();
        showTab();
    });

    $('#bt_deleteEvent').on('click', function() {
        var checked = $('#list_eventInfo > tbody > tr > td > input[type=checkbox]:checked');
        if(checked.length == 0) {
            alert('삭제할 이벤트를 선택해주세요.');
            return false;
        }

        if(confirm(checked.length + '건의 이벤트를 삭제하시겠습니까?')) {
            var eventIdxs = '';
            checked.each(function() {
               eventIdxs += $(this).parent().parent().find('._getEventDetail').data('eventidx') +",";
            });
            var data = {
              eventIdx : eventIdxs
            };
            util.getAjaxData("eventDelete", "/rest/content/event/management/delete", data, function fn_eventDelete_success(dst_id, response) {
                alert(response.message) +'\n- 성공 : ' + response.data.sucCnt + '건\n- 실패 : ' + response.data.failCnt +'건';
                location.reload();
            });
        }
    });
    function btSearchClick(){
        $("#bt_search").click();
    }


</script>