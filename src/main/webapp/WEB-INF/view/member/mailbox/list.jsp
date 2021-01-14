<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="col-md-5" >
            <table>
                <tr>
                    <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                        <i class="fa fa-search"></i><br/>검색
                    </th>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <label><input type="text" class="form-control" name="searchText" id="mailboxSearchText" placeholder="검색어를 입력해주세요."></label>
                        <button type="button" class="btn btn-success" id="bt_mailboxSearch">검색</button>
                        <label class="control-inline fancy-checkbox custom-color-green">
                            <input type="checkbox" name="search_testId" id="mailboxSearch_testId" value="1">
                            <span>테스트 아이디 제외</span>
                        </label>
                    </td>
                </tr>
            </table>
        </div>
        <span class="col-md-5 pull-right no-padding" id="mailbox_summaryArea"></span>
        <div class="widget-content">
            <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail">
                </thead>
                <tbody id="tableBody_detail">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#bt_mailboxSearch").on('click',function (){
            getMailbox("tab_mailbox");
        });
    });

    function getMailbox(tmp) {     // 상세보기
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.searchText = $("#mailboxSearchText").val();
            data.inner = $('input[name="mailboxSearch_testId"]').is(":checked") ? "0" : "-1";
        };
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(mailbox_summary_table);
    }

    function mailbox_summary_table(json){
        var template = $('#mailbox_tableSummary').html();
        var templateScript = Handlebars.compile(template);
        var data  = json.summary;
        var html = templateScript(data);
        $("#mailbox_summaryArea").html(html);
        ui.paintColor();
    }

    function mailboxPopUp(data){
        var popupUrl = "/member/mailbox/popup/mailboxMsg?chatNo="+ data.data('chatno');
        util.windowOpen(popupUrl,"950", "1000","우체통");
    }
</script>

<script id="mailbox_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" style="width: 100%;">
        <tr>
            <th rowspan="2">구분</th>
            <th colspan="4" class="_bgColor" data-bgcolor="#8faadc">총 합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">참여회원 수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">건 수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">보낸 달</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">받은 별</th>
        </tr>
        <tr>
            <th>선물</th>
            <td>{{addComma memGiftCnt}} 명</td>
            <td>{{addComma giftCnt}} 건</td>
            <td>{{addComma dalCnt}} 달</td>
            <td>{{addComma byeolCnt}} 별</td>
        </tr>
        <tr>
            <th>대화</th>
            <td>{{addComma memMsgCnt}} 명</td>
            <td>{{addComma msgCnt}} 건</td>
            <td rowspan="2" colspan="2"></td>
        </tr>
        <tr>
            <th>이미지</th>
            <td>{{addComma memImgCnt}} 명</td>
            <td>{{addComma imageCnt}} 건</td>
        </tr>
    </table>
</script>