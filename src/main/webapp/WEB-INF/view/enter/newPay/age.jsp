<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divAge">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="0.1%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
                <col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/><col width="2.5%"/>
            </colgroup>
            <thead>
            <tr>
                <th colspan="13" class="_stateTopTh">성별</th>
                <th style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th colspan="25" class="_stateTopTh">연령대별</th>
            </tr>
            <tr>
                <th rowspan="2" class="_stateTopTh"></th>
                <th colspan="3" class="_stateSubTh">총계</th>
                <th colspan="3" class="_stateSubTh _sex_male"></th>
                <th colspan="3" class="_stateSubTh _sex_female"></th>
                <th colspan="3" class="_stateSubTh _sex_none"></th>
                <th rowspan="2" style="background-color: white; border-bottom: hidden;"></th>
                <th rowspan="2" class="_stateTopTh"></th>
                <th colspan="3" class="_stateSubTh">총계</th>
                <th colspan="3" class="_stateSubTh">미선택</th>
                <th colspan="3" class="_stateSubTh">10대</th>
                <th colspan="3" class="_stateSubTh">20대</th>
                <th colspan="3" class="_stateSubTh">30대</th>
                <th colspan="3" class="_stateSubTh">40대</th>
                <th colspan="3" class="_stateSubTh">50대</th>
                <th colspan="3" class="_stateSubTh">60대이상</th>
            </tr>
            <tr>
                <th class="_stateSubTh">건<br/>(비율)</th>
                <th class="_stateSubTh">수량<br/>(비율)</th>
                <th class="_stateSubTh">금액<br/>(비율)</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건<br/>(비율)</th>
                <th class="_stateSubTh">수량<br/>(비율)</th>
                <th class="_stateSubTh">금액<br/>(비율)</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
            </tr>
            </thead>
            <tbody id="ageTableBody"></tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>
<a id='ageExcel' type='button' class="btn btn-default print-btn pull-right" download="" href="#" onclick="return ExcellentExport.excel(this, 'divAge', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">
    $(function(){
        // getPayAgeList();
    });

    function getPayAgeList (){
        $("#ageExcel").attr('download' , "결제현황_결제회원별_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + "_" +  moment($("#endDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };

        util.getAjaxData("age", "/rest/enter/pay/age", data, fn_agePay_success);
    }

    function fn_agePay_success(data, response){
        if(response.result == "fail"){
            searchDate();
            getPayAgeList();
            return;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i]["sum_totalCnt"] = response.data.totalInfo.sum_totalCnt;
            response.data.detailList[i]["sum_totalAmt"] = response.data.totalInfo.sum_totalAmt;
        }

        var isDataEmpty = response.data.detailList == null;
        $("#ageTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_age').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#ageTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        var template = $('#tmp_ageDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#ageTableBody").append(html);

        if(isDataEmpty){
            $("#ageTableBody td:last").remove();
        }else{
            $("#ageTableBody").append(totalHtml);
        }
        ui.tableHeightSet();
        ui.paintColor();
    }
    function genderAgeClick(tmp){
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();
        if($('input[name="slctType"]:checked').val() == 0){
            var popupUrl = "/enter/newPay/popup/history?sDate=" + sDate + "&eDate=" + eDate + "&gender=" + tmp.gender +  "&time=" + tmp.hour + "&age=" + tmp.age;
        }else if($('input[name="slctType"]:checked').val() == 1){
            tmp.daily = tmp.daily.replace(/-/gi,".");
            var popupUrl = "/enter/newPay/popup/history?sDate=" + tmp.daily + "&eDate=" + tmp.daily + "&gender=" + tmp.gender +  "&time=null" + "&age=" + tmp.age;
        }else if($('input[name="slctType"]:checked').val() == 2){
            var tmp_monthly = sDate.substr(0,5);
            sDate = tmp_monthly + common.lpad(tmp.monthly,2,"0") + ".01";
            eDate = moment(sDate).add('months', 1).add('days', -1).format('YYYY.MM.DD');
            var popupUrl = "/enter/newPay/popup/history?sDate=" + sDate + "&eDate=" + eDate + "&gender=" + tmp.gender +  "&time=null" + "&age=" + tmp.age;
        }
        util.windowOpen(popupUrl,"1550","885","결제목록");
    }
</script>
<script type="text/x-handlebars-template" id="tmp_age">
    <tr class="font-bold _stateSumTd">
        <td>소계</td>
        <td style="color:#ff5600;"><b>{{addComma sum_totalCnt}}<br/>({{average sum_totalCnt sum_totalCnt}}%)</b></td>
        <td style="color:#ff5600;"><b>{{addComma sum_totalCmt}}<br/>({{average sum_totalCmt sum_totalCmt}}%)</b></td>
        <td style="color:#ff5600;"><b>{{vatMinus sum_totalAmt}}<br/>({{average sum_totalAmt sum_totalAmt}}%)</b></td>
        <td style="color: blue;">{{addComma sum_maleCnt}}</td>
        <td style="color: blue;">{{vatMinus sum_maleCmt}}</td>
        <td style="color: blue;">{{vatMinus sum_maleAmt}}</td>
        <td style="color: red;">{{addComma sum_femaleCnt}}</td>
        <td style="color: red;">{{vatMinus sum_femaleCmt}}</td>
        <td style="color: red;">{{vatMinus sum_femaleAmt}}</td>
        <td>{{addComma sum_noneCnt}}</td>
        <td>{{vatMinus sum_noneCmt}}</td>
        <td>{{vatMinus sum_noneAmt}}</td>
        <td style="background-color: white;border-bottom: hidden;"></td>
        <td>소계</td>
        <td style="color:#ff5600;"><b>{{addComma sum_totalCnt}}<br/>({{average sum_totalCnt sum_totalCnt}}%)</b></td>
        <td style="color:#ff5600;"><b>{{addComma sum_totalCmt}}<br/>({{average sum_totalCmt sum_totalCmt}}%)</b></td>
        <td style="color:#ff5600;"><b>{{vatMinus sum_totalAmt}}<br/>({{average sum_totalAmt sum_totalAmt}}%)</b></td>
        <td>{{addComma sum_age00Cnt}}</td>
        <td>{{addComma sum_age00Cmt}}</td>
        <td>{{vatMinus sum_age00Amt}}</td>
        <td>{{addComma sum_age10Cnt}}</td>
        <td>{{addComma sum_age10Cmt}}</td>
        <td>{{vatMinus sum_age10Amt}}</td>
        <td>{{addComma sum_age20Cnt}}</td>
        <td>{{addComma sum_age20Cmt}}</td>
        <td>{{vatMinus sum_age20Amt}}</td>
        <td>{{addComma sum_age30Cnt}}</td>
        <td>{{addComma sum_age30Cmt}}</td>
        <td>{{vatMinus sum_age30Amt}}</td>
        <td>{{addComma sum_age40Cnt}}</td>
        <td>{{addComma sum_age40Cmt}}</td>
        <td>{{vatMinus sum_age40Amt}}</td>
        <td>{{addComma sum_age50Cnt}}</td>
        <td>{{addComma sum_age50Cmt}}</td>
        <td>{{vatMinus sum_age50Amt}}</td>
        <td>{{addComma sum_age60Cnt}}</td>
        <td>{{addComma sum_age60Cmt}}</td>
        <td>{{vatMinus sum_age60Amt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_ageDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold _stateSubTh">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{substr data.daily 8}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}">
            <a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma totalCnt}}<br/>({{average totalCnt sum_totalCnt}}%)</span></a>
        </td>
        <td><b>{{addComma totalCmt}}<br/>({{average totalCmt sum_totalCmt}}%)</b></td>
        <td><b>{{vatMinus totalAmt}}<br/>({{average totalAmt sum_totalAmt}}%)</b></td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-gender="m" style="color: blue;">
            <a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma maleCnt}}</span></a>
        </td>
        <td style="color: blue;">{{addComma maleCmt}}</td>
        <td style="color: blue;">{{vatMinus maleAmt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-gender="f" style="color: red;">
            <a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma femaleCnt}}</span></a>
        </td>
        <td style="color: red;">{{addComma femaleCmt}}</td>
        <td style="color: red;">{{vatMinus femaleAmt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-gender="n" >
            <a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma noneCnt}}</span></a>
        </td>
        <td>{{addComma noneCmt}}</td>
        <td>{{vatMinus noneAmt}}</td>
        <td style="border-bottom: hidden;"></td>
        <td class="font-bold _stateSubTh">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{substr data.daily 8}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma totalCnt}}<br/>({{average totalCnt sum_totalCnt}}%)</span></a></td>
        <td><b>{{addComma totalCmt}}<br/>({{average totalCmt sum_totalCmt}}%)</b></td>
        <td><b>{{vatMinus totalAmt}}<br/>({{average totalAmt sum_totalAmt}}%)</b></td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="00"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age00Cnt}}</span></a></td>
        <td>{{addComma age00Cmt}}</td>
        <td>{{vatMinus age00Amt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="10"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age10Cnt}}</span></a></td>
        <td>{{addComma age10Cmt}}</td>
        <td>{{vatMinus age10Amt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="20"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age20Cnt}}</span></a></td>
        <td>{{addComma age20Cmt}}</td>
        <td>{{vatMinus age20Amt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="30"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age30Cnt}}</span></a></td>
        <td >{{addComma age30Cmt}}</td>
        <td >{{vatMinus age30Amt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="40"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age40Cnt}}</span></a></td>
        <td>{{addComma age40Cmt}}</td>
        <td>{{vatMinus age40Amt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="50"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age50Cnt}}</span></a></td>
        <td>{{addComma age50Cmt}}</td>
        <td>{{vatMinus age50Amt}}</td>
        <td onclick="genderAgeClick($(this).data());" data-hour="{{data.hour}}" data-daily="{{data.daily}}" data-monthly="{{data.monthly}}" data-age="60"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age60Cnt}}</span></a></td>
        <td>{{addComma age60Cmt}}</td>
        <td>{{vatMinus age60Amt}}</td>
    </tr>
    {{else}}
    <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>