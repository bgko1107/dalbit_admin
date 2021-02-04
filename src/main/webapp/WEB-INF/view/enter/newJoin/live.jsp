<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>

        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="2.3%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/>
                <col width="0.1%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="4" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontColor="#ffffff">구분</th>
                <th id="live_th_1" colspan="36" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontColor="#ffffff">하루전</th>
                <th class="_noBorder"></th>
                <th id="live_th_0" colspan="36" class="_bgColor _fontColor" data-bgColor="#bf9000" data-fontColor="#ffffff">오늘</th>
            </tr>
            <tr>
                <th colspan="12" class="_sex_male _bgColor" data-bgColor="#b4c7e7"></th>
                <th colspan="12" class="_sex_female _bgColor" data-bgColor="#b4c7e7"></th>
                <th colspan="12" class="_sex_none _bgColor" data-bgColor="#b4c7e7"></th>
                <th class="_noBorder"></th>
                <th colspan="12" class="_sex_male _bgColor" data-bgColor="#ffd966"></th>
                <th colspan="12" class="_sex_female _bgColor" data-bgColor="#ffd966"></th>
                <th colspan="12" class="_sex_none _bgColor" data-bgColor="#ffd966"></th>
            </tr>
            <tr>
                <th colspan="2" class="_bgColor _phone" data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao" data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver" data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook" data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple" data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th colspan="2" class="_bgColor _phone" data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao" data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver" data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook" data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple" data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th colspan="2" class="_bgColor _phone"  data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao"  data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver"  data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook"  data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple"  data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th class="_noBorder"></th>
                <th colspan="2" class="_bgColor _phone"  data-bgColor="#ffe699">전화</th>
                <th colspan="2" class="_bgColor _kakao"  data-bgColor="#ffe699">카카오</th>
                <th colspan="2" class="_bgColor _naver"  data-bgColor="#ffe699">네이버</th>
                <th colspan="2" class="_bgColor _fbook"  data-bgColor="#ffe699">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple"  data-bgColor="#ffe699">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#ffe699">구글</th>
                <th colspan="2" class="_bgColor _phone"  data-bgColor="#ffe699">전화</th>
                <th colspan="2" class="_bgColor _kakao"  data-bgColor="#ffe699">카카오</th>
                <th colspan="2" class="_bgColor _naver"  data-bgColor="#ffe699">네이버</th>
                <th colspan="2" class="_bgColor _fbook"  data-bgColor="#ffe699">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple"  data-bgColor="#ffe699">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#ffe699">구글</th>
                <th colspan="2" class="_bgColor _phone"  data-bgColor="#ffe699">전화</th>
                <th colspan="2" class="_bgColor _kakao"  data-bgColor="#ffe699">카카오</th>
                <th colspan="2" class="_bgColor _naver"  data-bgColor="#ffe699">네이버</th>
                <th colspan="2" class="_bgColor _fbook"  data-bgColor="#ffe699">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple"  data-bgColor="#ffe699">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#ffe699">구글</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#b4c7e7">가입</th>
                <th>탈퇴</th>
                <th class="_noBorder"></th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
                <th class="_bgColor" data-bgColor="#ffd966">가입</th>
                <th>탈퇴</th>
            </tr>
            </thead>
            <tbody id="liveTableBody"></tbody>
        </table>


        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="2.3%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/>
                <col width="0.1%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/><col width="1.0%"/>
                <col width="1.0%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="4" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontColor="#ffffff">구분</th>
                <th id="live_th_3" colspan="36" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontColor="#ffffff">삼일전</th>
                <th class="_noBorder"></th>
                <th id="live_th_2" colspan="36" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontColor="#ffffff">이틀전</th>
            </tr>
            <tr class="_bgColor" data-bgColor="#b4c7e7">
                <th colspan="12" class="_sex_male"></th>
                <th colspan="12" class="_sex_female"></th>
                <th colspan="12" class="_sex_none"></th>
                <th class="_noBorder"></th>
                <th colspan="12" class="_sex_male"></th>
                <th colspan="12" class="_sex_female"></th>
                <th colspan="12" class="_sex_none"></th>
            </tr>
            <tr style="background-color: #e9ebf5">
                <th colspan="2" class="_bgColor _phone" data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao" data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver" data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook" data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple" data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th colspan="2" class="_bgColor _phone" data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao" data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver" data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook" data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple" data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th colspan="2" class="_bgColor _phone"  data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao"  data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver"  data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook"  data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple"  data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th class="_noBorder"></th>
                <th colspan="2" class="_bgColor _phone" data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao" data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver" data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook" data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple" data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th colspan="2" class="_bgColor _phone" data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao" data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver" data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook" data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple" data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
                <th colspan="2" class="_bgColor _phone"  data-bgColor="#e9ebf5">전화</th>
                <th colspan="2" class="_bgColor _kakao"  data-bgColor="#e9ebf5">카카오</th>
                <th colspan="2" class="_bgColor _naver"  data-bgColor="#e9ebf5">네이버</th>
                <th colspan="2" class="_bgColor _fbook"  data-bgColor="#e9ebf5">페이<br/>스북</th>
                <th colspan="2" class="_bgColor _apple"  data-bgColor="#e9ebf5">애플</th>
                <th colspan="2" class="_bgColor _google" data-bgColor="#e9ebf5">구글</th>
            </tr>
            <tr>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th class="_noBorder"></th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
                <th style="background-color: #cfd5ea">가입</th>
                <th>탈퇴</th>
            </tr>
            </thead>
            <tbody id="liveTableBody2"></tbody>
        </table>

    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){

    });

    var tmp = 0;
    var tmp_end = 0;
    var type;
    function getLive(){

        $("#live_th_3").text(moment($("#startDate").val()).add('days', -3).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -3).day()] + ")");
        $("#live_th_2").text(moment($("#startDate").val()).add('days', -2).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -2).day()] + ")");
        $("#live_th_1").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -1).day()] + ")");
        $("#live_th_0").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', 0).day()] + ")");

        var th_3 = moment($("#startDate").val()).add('days', -3).format('YYYY.MM.DD');
        var th_2 = moment($("#startDate").val()).add('days', -2).format('YYYY.MM.DD');
        var th_1 = moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD');
        var th_0 = moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD');
        var dateList = th_0 + "@" + th_1 + "@" + th_2 + "@" + th_3;
        var data = {};
        data.dateList = dateList;
        data.slctType = slctType;
        util.getAjaxData("live", "/rest/enter/newJoin/info/live", data, fn_live_success);
    }

    function fn_live_success(data, response){

        tmp_end = 0;
        tmp = 24;
        type = "시";
        var slctType_date = [];
        for(var i = tmp_end; i < tmp; i++ ){
            slctType_date.push(i + " " + type);
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_dummyLive').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#liveTableBody").html(html);

        var template = $('#tmp_dummyLive2').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#liveTableBody2").html(html);


        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_time = tmp_date.split(" ")[1];

        tmp_index = -1;

        response.data.forEach(function(data, index){
            if(index > 2){
                ++tmp_index;
            }
            data.detailList.forEach(function(detail, detailIndex){
                if(detail.succAmt == 0){
                    detail.accumAmt = 0;
                }

                // 변수 ----
                var phone_join_mCnt = common.addComma(detail.phone_join_mCnt,"Y");
                var phone_out_mCnt = common.addComma(detail.phone_out_mCnt,"Y");
                var kakao_join_mCnt = common.addComma(detail.kakao_join_mCnt,"Y");
                var kakao_out_mCnt = common.addComma(detail.kakao_out_mCnt,"Y");
                var naver_join_mCnt = common.addComma(detail.naver_join_mCnt,"Y");
                var naver_out_mCnt = common.addComma(detail.naver_out_mCnt,"Y");
                var fbook_join_mCnt = common.addComma(detail.fbook_join_mCnt,"Y");
                var fbook_out_mCnt = common.addComma(detail.fbook_out_mCnt,"Y");
                var apple_join_mCnt = common.addComma(detail.apple_join_mCnt,"Y");
                var apple_out_mCnt = common.addComma(detail.apple_out_mCnt,"Y");
                var google_join_mCnt = common.addComma(detail.google_join_mCnt,"Y");
                var google_out_mCnt = common.addComma(detail.google_out_mCnt,"Y");
                var phone_join_fCnt = common.addComma(detail.phone_join_fCnt,"Y");
                var phone_out_fCnt = common.addComma(detail.phone_out_fCnt,"Y");
                var kakao_join_fCnt = common.addComma(detail.kakao_join_fCnt,"Y");
                var kakao_out_fCnt = common.addComma(detail.kakao_out_fCnt,"Y");
                var naver_join_fCnt = common.addComma(detail.naver_join_fCnt,"Y");
                var naver_out_fCnt = common.addComma(detail.naver_out_fCnt,"Y");
                var fbook_join_fCnt = common.addComma(detail.fbook_join_fCnt,"Y");
                var fbook_out_fCnt = common.addComma(detail.fbook_out_fCnt,"Y");
                var apple_join_fCnt = common.addComma(detail.apple_join_fCnt,"Y");
                var apple_out_fCnt = common.addComma(detail.apple_out_fCnt,"Y");
                var google_join_fCnt = common.addComma(detail.google_join_fCnt,"Y");
                var google_out_fCnt = common.addComma(detail.google_out_fCnt,"Y");
                var phone_join_nCnt = common.addComma(detail.phone_join_nCnt,"Y");
                var phone_out_nCnt = common.addComma(detail.phone_out_nCnt,"Y");
                var kakao_join_nCnt = common.addComma(detail.kakao_join_nCnt,"Y");
                var kakao_out_nCnt = common.addComma(detail.kakao_out_nCnt,"Y");
                var naver_join_nCnt = common.addComma(detail.naver_join_nCnt,"Y");
                var naver_out_nCnt = common.addComma(detail.naver_out_nCnt,"Y");
                var fbook_join_nCnt = common.addComma(detail.fbook_join_nCnt,"Y");
                var fbook_out_nCnt = common.addComma(detail.fbook_out_nCnt,"Y");
                var apple_join_nCnt = common.addComma(detail.apple_join_nCnt,"Y");
                var apple_out_nCnt = common.addComma(detail.apple_out_nCnt,"Y");
                var google_join_nCnt = common.addComma(detail.google_join_nCnt,"Y");
                var google_out_nCnt = common.addComma(detail.google_out_nCnt,"Y");

                // 상단
                var tmp = 0;

                if (index == 1) {
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_out_nCnt);

                    if(Number(tmp_time.split(":")[0]) == detail.the_hr) {
                        for(var i = 1; i < 37 ; i ++){
                            $("#liveTableBody tr._tr_" + (detail.the_hr) + " td:eq(" + (i) + ")").css("background-color", "#fff7e5");
                            $("#liveTableBody tr._tr_" + (detail.the_hr) + " td:eq(" + (i) + ")").css("font-weight", "bold");
                        }
                    }
                }

                if (index == 0) {
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_join_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_out_mCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_join_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_out_fCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_out_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_join_nCnt);
                    $("#liveTableBody tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_out_nCnt);
                    if(Number(tmp_time.split(":")[0]) == detail.the_hr) {
                        for(var i = 0; i < 37 ; i ++){
                            $("#liveTableBody tr._tr_" + (detail.the_hr) + " td:eq(" + (38 + i) + ")").css("background-color", "#fff7e5");
                            $("#liveTableBody tr._tr_" + (detail.the_hr) + " td:eq(" + (38 + i) + ")").css("font-weight", "bold");
                        }
                    }
                }
                // 하단
                if (index == 2) {
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(phone_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(kakao_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(naver_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(fbook_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(apple_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (++tmp) + ")").html(google_out_nCnt);

                    if(Number(tmp_time.split(":")[0]) == detail.the_hr) {
                        for(var i = 1; i < 37 ; i ++){
                            $("#liveTableBody2 tr._tr_" + (detail.the_hr) + " td:eq(" + (i) + ")").css("background-color", "#fff7e5");
                            $("#liveTableBody2 tr._tr_" + (detail.the_hr) + " td:eq(" + (i) + ")").css("font-weight", "bold");
                        }
                    }
                }
                if(index == 3){
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_join_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_out_mCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_join_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_out_fCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(phone_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(naver_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(apple_out_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_join_nCnt);
                    $("#liveTableBody2 tr._tr_" + detail.the_hr + " td:eq(" + (37 + (++tmp)) + ")").html(google_out_nCnt);

                    if(Number(tmp_time.split(":")[0]) == detail.the_hr) {
                        for(var i = 0; i < 37 ; i ++){
                            $("#liveTableBody2 tr._tr_" + (detail.the_hr) + " td:eq(" + (37 + i) + ")").css("background-color", "#fff7e5");
                            $("#liveTableBody2 tr._tr_" + (detail.the_hr) + " td:eq(" + (37 + i) + ")").css("font-weight", "bold");
                        }
                    }
                }
            });
        });

        tmp_index = -1;
        for(var i=0 ; i<response.data.length;i++){
            if(i > 2){
                ++tmp_index;
            }
            var totalInfo = response.data[i].totalInfo;

            //변수 ----------
            var phone_join_mCnt = common.addComma(totalInfo.phone_join_mCnt);
            var phone_out_mCnt = common.addComma(totalInfo.phone_out_mCnt);
            var kakao_join_mCnt = common.addComma(totalInfo.kakao_join_mCnt);
            var kakao_out_mCnt = common.addComma(totalInfo.kakao_out_mCnt);
            var naver_join_mCnt = common.addComma(totalInfo.naver_join_mCnt);
            var naver_out_mCnt = common.addComma(totalInfo.naver_out_mCnt);
            var fbook_join_mCnt = common.addComma(totalInfo.fbook_join_mCnt);
            var fbook_out_mCnt = common.addComma(totalInfo.fbook_out_mCnt);
            var apple_join_mCnt = common.addComma(totalInfo.apple_join_mCnt);
            var apple_out_mCnt = common.addComma(totalInfo.apple_out_mCnt);
            var google_join_mCnt = common.addComma(totalInfo.google_join_mCnt);
            var google_out_mCnt = common.addComma(totalInfo.google_out_mCnt);
            var phone_join_fCnt = common.addComma(totalInfo.phone_join_fCnt);
            var phone_out_fCnt = common.addComma(totalInfo.phone_out_fCnt);
            var kakao_join_fCnt = common.addComma(totalInfo.kakao_join_fCnt);
            var kakao_out_fCnt = common.addComma(totalInfo.kakao_out_fCnt);
            var naver_join_fCnt = common.addComma(totalInfo.naver_join_fCnt);
            var naver_out_fCnt = common.addComma(totalInfo.naver_out_fCnt);
            var fbook_join_fCnt = common.addComma(totalInfo.fbook_join_fCnt);
            var fbook_out_fCnt = common.addComma(totalInfo.fbook_out_fCnt);
            var apple_join_fCnt = common.addComma(totalInfo.apple_join_fCnt);
            var apple_out_fCnt = common.addComma(totalInfo.apple_out_fCnt);
            var google_join_fCnt = common.addComma(totalInfo.google_join_fCnt);
            var google_out_fCnt = common.addComma(totalInfo.google_out_fCnt);
            var phone_join_nCnt = common.addComma(totalInfo.phone_join_nCnt);
            var phone_out_nCnt = common.addComma(totalInfo.phone_out_nCnt);
            var kakao_join_nCnt = common.addComma(totalInfo.kakao_join_nCnt);
            var kakao_out_nCnt = common.addComma(totalInfo.kakao_out_nCnt);
            var naver_join_nCnt = common.addComma(totalInfo.naver_join_nCnt);
            var naver_out_nCnt = common.addComma(totalInfo.naver_out_nCnt);
            var fbook_join_nCnt = common.addComma(totalInfo.fbook_join_nCnt);
            var fbook_out_nCnt = common.addComma(totalInfo.fbook_out_nCnt);
            var apple_join_nCnt = common.addComma(totalInfo.apple_join_nCnt);
            var apple_out_nCnt = common.addComma(totalInfo.apple_out_nCnt);
            var google_join_nCnt = common.addComma(totalInfo.google_join_nCnt);
            var google_out_nCnt = common.addComma(totalInfo.google_out_nCnt);

            var sum_phone_m = common.addComma(totalInfo.phone_join_mCnt + totalInfo.phone_out_mCnt);
            var sum_kakao_m = common.addComma(totalInfo.kakao_join_mCnt + totalInfo.kakao_out_mCnt);
            var sum_naver_m = common.addComma(totalInfo.naver_join_mCnt + totalInfo.naver_out_mCnt);
            var sum_fbook_m = common.addComma(totalInfo.fbook_join_mCnt + totalInfo.fbook_out_mCnt);
            var sum_apple_m = common.addComma(totalInfo.apple_join_mCnt + totalInfo.apple_out_mCnt);
            var sum_google_m = common.addComma(totalInfo.google_join_mCnt + totalInfo.google_out_mCnt);

            var sum_phone_f = common.addComma(totalInfo.phone_join_fCnt + totalInfo.phone_out_fCnt);
            var sum_kakao_f = common.addComma(totalInfo.kakao_join_fCnt + totalInfo.kakao_out_fCnt);
            var sum_naver_f = common.addComma(totalInfo.naver_join_fCnt + totalInfo.naver_out_fCnt);
            var sum_fbook_f = common.addComma(totalInfo.fbook_join_fCnt + totalInfo.fbook_out_fCnt);
            var sum_apple_f = common.addComma(totalInfo.apple_join_fCnt + totalInfo.apple_out_fCnt);
            var sum_google_f = common.addComma(totalInfo.google_join_fCnt + totalInfo.google_out_fCnt);

            var sum_phone_n = common.addComma(totalInfo.phone_join_nCnt + totalInfo.phone_out_nCnt);
            var sum_kakao_n = common.addComma(totalInfo.kakao_join_nCnt + totalInfo.kakao_out_nCnt);
            var sum_naver_n = common.addComma(totalInfo.naver_join_nCnt + totalInfo.naver_out_nCnt);
            var sum_fbook_n = common.addComma(totalInfo.fbook_join_nCnt + totalInfo.fbook_out_nCnt);
            var sum_apple_n = common.addComma(totalInfo.apple_join_nCnt + totalInfo.apple_out_nCnt);
            var sum_google_n = common.addComma(totalInfo.google_join_nCnt + totalInfo.google_out_nCnt);


            var sum_join_male_total = totalInfo.phone_join_mCnt + totalInfo.kakao_join_mCnt + totalInfo.naver_join_mCnt + totalInfo.fbook_join_mCnt + totalInfo.apple_join_mCnt + totalInfo.google_join_mCnt;
            var sum_out_male_total = totalInfo.phone_out_mCnt + totalInfo.kakao_out_mCnt + totalInfo.naver_out_mCnt + totalInfo.fbook_out_mCnt + totalInfo.apple_out_mCnt + totalInfo.google_out_mCnt;
            var sum_join_female_total = totalInfo.phone_join_fCnt + totalInfo.kakao_join_fCnt + totalInfo.naver_join_fCnt + totalInfo.fbook_join_fCnt + totalInfo.apple_join_fCnt + totalInfo.google_join_fCnt;
            var sum_out_female_total = totalInfo.phone_out_fCnt + totalInfo.kakao_out_fCnt + totalInfo.naver_out_fCnt + totalInfo.fbook_out_fCnt + totalInfo.apple_out_fCnt + totalInfo.google_out_fCnt;
            var sum_join_none_total = totalInfo.phone_join_nCnt + totalInfo.kakao_join_nCnt + totalInfo.naver_join_nCnt + totalInfo.fbook_join_nCnt + totalInfo.apple_join_nCnt + totalInfo.google_join_nCnt;
            var sum_out_none_total = totalInfo.phone_out_nCnt + totalInfo.kakao_out_nCnt + totalInfo.naver_out_nCnt + totalInfo.fbook_out_nCnt + totalInfo.apple_out_nCnt + totalInfo.google_out_nCnt;

            var sum_join_total = sum_join_male_total + sum_join_female_total + sum_join_none_total;
            var sum_out_total = sum_out_male_total + sum_out_female_total + sum_out_none_total;

            //상단
            var tmp = 0;
            if(i == 1){
                $("#liveTableBody tr:eq(0) td:eq(" + 1 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                    +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                    " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                    + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                );

                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(google_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(google_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(google_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(google_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(google_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (++tmp) + ")").html(google_out_nCnt);

                tmp = 0;
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_phone_m);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_kakao_m);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_naver_m);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_fbook_m);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_apple_m);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_google_m);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_phone_f);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_kakao_f);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_naver_f);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_fbook_f);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_apple_f);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_google_f);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_phone_n);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_kakao_n);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_naver_n);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_fbook_n);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_apple_n);
                $("#liveTableBody tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_google_n);
                tmp = 0;
                $("#liveTableBody tr:eq(27) td:eq(" + 1 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                                                            +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                                                            " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                                                            + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                                                            );
            }else if(i == 0){
                $("#liveTableBody tr:eq(0) td:eq(" + 3 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                    +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                    " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                    + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                );

                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_join_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_out_mCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_join_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_out_fCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_out_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_join_nCnt);
                $("#liveTableBody tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_out_nCnt);

                $("#liveTableBody tr:eq(26) td:eq(20)").html(sum_phone_m);
                $("#liveTableBody tr:eq(26) td:eq(21)").html(sum_kakao_m);
                $("#liveTableBody tr:eq(26) td:eq(22)").html(sum_naver_m);
                $("#liveTableBody tr:eq(26) td:eq(23)").html(sum_fbook_m);
                $("#liveTableBody tr:eq(26) td:eq(24)").html(sum_apple_m);
                $("#liveTableBody tr:eq(26) td:eq(25)").html(sum_google_m);
                $("#liveTableBody tr:eq(26) td:eq(26)").html(sum_phone_f);
                $("#liveTableBody tr:eq(26) td:eq(27)").html(sum_kakao_f);
                $("#liveTableBody tr:eq(26) td:eq(28)").html(sum_naver_f);
                $("#liveTableBody tr:eq(26) td:eq(29)").html(sum_fbook_f);
                $("#liveTableBody tr:eq(26) td:eq(30)").html(sum_apple_f);
                $("#liveTableBody tr:eq(26) td:eq(31)").html(sum_google_f);
                $("#liveTableBody tr:eq(26) td:eq(32)").html(sum_phone_n);
                $("#liveTableBody tr:eq(26) td:eq(33)").html(sum_kakao_n);
                $("#liveTableBody tr:eq(26) td:eq(34)").html(sum_naver_n);
                $("#liveTableBody tr:eq(26) td:eq(35)").html(sum_fbook_n);
                $("#liveTableBody tr:eq(26) td:eq(36)").html(sum_apple_n);
                $("#liveTableBody tr:eq(26) td:eq(37)").html(sum_google_n);

                $("#liveTableBody tr:eq(27) td:eq(" + 3 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                                                            +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                                                            " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                                                            + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                                                            );
            }

            // 하단
            if(i == 2){
                $("#liveTableBody2 tr:eq(0) td:eq(" + 1 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                    +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                    " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                    + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                );

                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(google_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(google_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(google_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(google_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(phone_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(kakao_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(naver_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(fbook_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(apple_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(google_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (++tmp) + ")").html(google_out_nCnt);

                tmp = 0;
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_phone_m);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_kakao_m);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_naver_m);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_fbook_m);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_apple_m);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_google_m);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_phone_f);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_kakao_f);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_naver_f);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_fbook_f);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_apple_f);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_google_f);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_phone_n);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_kakao_n);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_naver_n);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_fbook_n);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_apple_n);
                $("#liveTableBody2 tr:eq(26) td:eq(" + (++tmp) + ")").html(sum_google_n);

                $("#liveTableBody2 tr:eq(27) td:eq(" + 1 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                                            +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                                            " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                                            + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                                            );
            }else if(i == 3){
                $("#liveTableBody2 tr:eq(0) td:eq(" + 3 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                    +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                    " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                    + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                );

                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_join_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_out_mCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_join_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_out_fCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(phone_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(kakao_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(naver_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(fbook_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(apple_out_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_join_nCnt);
                $("#liveTableBody2 tr:eq(1) td:eq(" + (37 + (++tmp)) + ")").html(google_out_nCnt);

                $("#liveTableBody2 tr:eq(26) td:eq(20)").html(sum_phone_m);
                $("#liveTableBody2 tr:eq(26) td:eq(21)").html(sum_kakao_m);
                $("#liveTableBody2 tr:eq(26) td:eq(22)").html(sum_naver_m);
                $("#liveTableBody2 tr:eq(26) td:eq(23)").html(sum_fbook_m);
                $("#liveTableBody2 tr:eq(26) td:eq(24)").html(sum_apple_m);
                $("#liveTableBody2 tr:eq(26) td:eq(25)").html(sum_google_m);
                $("#liveTableBody2 tr:eq(26) td:eq(26)").html(sum_phone_f);
                $("#liveTableBody2 tr:eq(26) td:eq(27)").html(sum_kakao_f);
                $("#liveTableBody2 tr:eq(26) td:eq(28)").html(sum_naver_f);
                $("#liveTableBody2 tr:eq(26) td:eq(29)").html(sum_fbook_f);
                $("#liveTableBody2 tr:eq(26) td:eq(30)").html(sum_apple_f);
                $("#liveTableBody2 tr:eq(26) td:eq(31)").html(sum_google_f);
                $("#liveTableBody2 tr:eq(26) td:eq(32)").html(sum_phone_n);
                $("#liveTableBody2 tr:eq(26) td:eq(33)").html(sum_kakao_n);
                $("#liveTableBody2 tr:eq(26) td:eq(34)").html(sum_naver_n);
                $("#liveTableBody2 tr:eq(26) td:eq(35)").html(sum_fbook_n);
                $("#liveTableBody2 tr:eq(26) td:eq(36)").html(sum_apple_n);
                $("#liveTableBody2 tr:eq(26) td:eq(37)").html(sum_google_n);

                $("#liveTableBody2 tr:eq(27) td:eq(" + 3 + ")").html("가입/탈퇴 (총 " + sum_join_total + " / " + sum_out_total + ") : "
                            +"<span style='color:blue'>" +  sum_join_male_total + " / " + sum_out_male_total + " (" + common.average(sum_out_male_total,sum_out_total, 0) + "%) </span> |" +
                            " <span style='color:red'>" + sum_join_female_total + " / " + sum_out_female_total + " (" + common.average(sum_out_female_total,sum_out_total, 0) + "%) </span> | " +
                            + sum_join_none_total + " / " + sum_out_none_total + " (" + common.average(sum_out_none_total,sum_out_total, 0) + "%)"
                            );
            }
        }
        ui.tableHeightSet();
        ui.paintColor();
    }

</script>


<script type="text/x-handlebars-template" id="tmp_dummyLive">
    <tr class="_tr_{{this}} font-bold" style="background-color: #dae3f3">
        <td>총계</td>
        <td colspan="36">0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td colspan="36">0</td>
    </tr>
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold">{{this}}</td>
        <td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td>
        <td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td>
        <td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td>
        <td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td>
        <td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td>
        <td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td>
        <td class="_noBorder" style="background-color: white"></td>
        <td style="background-color: #fff7e5;color: blue"></td><td></td><td style="background-color: #fff7e5;color: blue"></td><td></td><td style="background-color: #fff7e5;color: blue"></td><td></td>
        <td style="background-color: #fff7e5;color: blue"></td><td></td><td style="background-color: #fff7e5;color: blue"></td><td></td><td style="background-color: #fff7e5;color: blue"></td><td></td>
        <td style="background-color: #fff7e5;color: red"></td><td></td><td style="background-color: #fff7e5;color: red"></td><td></td><td style="background-color: #fff7e5;color: red"></td><td></td>
        <td style="background-color: #fff7e5;color: red"></td><td></td><td style="background-color: #fff7e5;color: red"></td><td></td><td style="background-color: #fff7e5;color: red"></td><td></td>
        <td style="background-color: #fff7e5"></td><td></td><td style="background-color: #fff7e5"></td><td></td><td style="background-color: #fff7e5"></td><td></td>
        <td style="background-color: #fff7e5"></td><td></td><td style="background-color: #fff7e5"></td><td></td><td style="background-color: #fff7e5"></td><td></td>
    </tr>
    {{/each}}
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>소계</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
    </tr>
    <tr class="_tr_{{this}} font-bold" style="background-color: #dae3f3">
        <td>총계</td>
        <td colspan="36">0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td colspan="36">0</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_dummyLive2">
    <tr class="_tr_{{this}} font-bold" style="background-color: #dae3f3">
        <td>총계</td>
        <td colspan="36">0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td colspan="36">0</td>
    </tr>
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold"  style="background-color: #dae3f3">{{this}}</td>
        <td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3""></td><td></td><td style="color: blue;background-color: #dae3f3""></td><td></td>
        <td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td>
        <td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td>
        <td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td>
        <td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td>
        <td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td>
        <td class="_noBorder" style="background-color: white"></td>
        <td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3""></td><td></td><td style="color: blue;background-color: #dae3f3""></td><td></td>
        <td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td><td style="color: blue;background-color: #dae3f3"></td><td></td>
        <td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td>
        <td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td><td style="color: red;background-color: #dae3f3"></td><td></td>
        <td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td>
        <td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td><td style="background-color: #dae3f3"></td><td></td>
    </tr>
    {{/each}}
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>소계</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
        <td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td><td colspan="2">0</td>
    </tr>
    <tr class="_tr_{{this}} font-bold" style="background-color: #dae3f3">
        <td>총계</td>
        <td colspan="36">0</td>
        <td class="_noBorder" style="background-color: white"></td>
        <td colspan="36">0</td>
    </tr>
</script>