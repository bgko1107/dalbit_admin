<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var toDay = week[moment(new Date()).day()];

    var year;
    var month = moment(dateTime).format("MM");
    var day = moment(dateTime).format("DD");
    var slctType;

    $(function() {
        $(".search_exchange_years").append(util.getCommonCodeSelect(moment(new Date()).format('YYYY'), search_exchange_years));
        year = $("#search_year").val();
        $(document).on('change', '#search_year', function() {
            if(slctType == 0) {
                monthClick("", $("#div_dayButton").find("#search_year").val(), month, day);
            }else if(slctType == 1){
                monthClick("", $("#div_monthButton").find("#search_year").val(), month, day);
            }else if(slctType == 2){
                monthClick("", $("#div_yearButton").find("#search_year").val(), month, day);
            }
        });
    });

    function setTimeDate(dateTime){
        $("#onedayDate").val(dateTime);
        $("#startDate").val(dateTime);
        $("#endDate").val(dateTime);
        $("#displayDate").val(dateTime + " - " + dateTime);

        toDay = week[moment($("#startDate").val()).add('days', 0).day()];
        $("._searchDate").html(dateTime + " (" + toDay + ")");
    }

    function setDayButton(today){
        $(".monthButton").empty();

        if(common.isEmpty(today)){
            $(".search_exchange_years").empty();
            $(".search_exchange_years").append(util.getCommonCodeSelect(moment(new Date()).format('YYYY'), search_exchange_years));
            month = common.lpad(moment(dateTime).format("MM"),2,"0");
            day = common.lpad(moment(dateTime).format("DD"),2,"0");
        }
        var monthButton = '<div class="btn-group" data-toggle="buttons" id="labelMonthButton">';
        for(var i=1; i<13;i++){
            monthButton = monthButton + '<label class="btn btn-xs mr5 btn-default btn-search labelMonthButton' + common.lpad(i,2,"0") +'" style="border-radius: 4px;" data-month="' + i +'" name="buttonMonth" onclick="monthBottonClick($(this).data())"> <input type="radio">' + i + '</label>';
        }
        monthButton = monthButton + '</div>';

        $(".monthButton").append(monthButton);

        $(".labelMonthButton" + month).addClass('active');

        $(".search_exchange_years").find("#search_year").css("width","100%");
        $(".search_exchange_years").find("#search_year").css("height","100%");

        monthClick("",$("#search_year").val(), month, day);
    }

    function monthClick(id, paramYear, paramMonth, paramDay){
         $(".dayButton").empty();

        if(slctType == 0) {
            year = $("#div_dayButton").find("#search_year").val();
        }else if(slctType == 1){
            year = $("#div_monthButton").find("#search_year").val();
        }else if(slctType == 2){
            year = $("#div_yearButton").find("#search_year").val();
        }
        month = paramMonth;
        if(paramMonth < 1 || paramMonth > 12){
            return false;
        }
        for(var i=1; i<13;i++){
            $(".labelMonthButton" + common.lpad(i,2,"0")).removeClass('active');
        }

        $(".labelMonthButton" + month).addClass('active');

        var lastDay = new Date(year,paramMonth,-1).getDate() + 1;
        var dayButton = '<div class="btn-group" data-toggle="buttons" id="labelDayButton">';
        for(var i=1; i<lastDay+1;i++){
            dayButton = dayButton + '<label class="btn btn-xs mr5 btn-default btn-search labelDayButton' + common.lpad(i,2,"0") +'" style="border-radius: 4px;" data-day="' + i +'" onclick="dayBottonClick($(this).data())"> <input type="radio">' + i + '</label>';
        }
        dayButton = dayButton + '</div>';
        $(".dayButton").append(dayButton);
        if(Number(paramDay) > lastDay) {
            dayClick("", year, paramMonth, lastDay);
        }else{
            dayClick("", year, paramMonth, paramDay);
        }
    }

    function dayClick(id, paramYear, paramMonth, paramDay){
        var lastDay = new Date(paramYear,paramMonth,-1).getDate() + 1;

        for(var i=1; i<lastDay + 1;i++){
            $(".labelDayButton" + common.lpad(i,2,"0")).removeClass('active');
        }

        if(Number(day) > lastDay){
            day = lastDay;
            $(".labelDayButton" + lastDay).addClass('active');
        }else{
            day = paramDay;
            $(".labelDayButton" + paramDay).addClass('active');
        }
        var selectDate = paramYear + "." + common.lpad(paramMonth,2,"0") + "." + common.lpad(day,2,"0");

        if(slctType == 0){
            setTimeDate(selectDate);
        }else if(slctType == 1){
            $("#monthDate").val(selectDate.substr(0,7));
            $("#startDate").val(selectDate.substr(0,8) + "01");
            $("#endDate").val(selectDate.substr(0,8) + lastDay);
            $("._searchDate").html(moment($("#startDate").val()).format('YYYY년 MM월'));
        }else if(slctType == 2){
            $("#yearDate").val(selectDate.substr(0,4));
            $("#startDate").val(selectDate.substr(0,5) + "01.01");
            $("#endDate").val(selectDate.substr(0,5) + "12.31");
            $("._searchDate").html(moment($("#startDate").val()).format('YYYY년'));
        }else if(slctType == 4){
            $("#onedayDate").val(selectDate);
            var monday = getMonday(selectDate);       // 선택한 날의 월요일
            var startDate = monday;
            var endDate = new Date(Date.parse(monday) + 6 * 1000 * 60 * 60 * 24);
            $("#startDate").val(startDate.getFullYear() + "." + common.lpad(startDate.getMonth() + 1,2,"0") + "." + common.lpad(startDate.getDate(),2,"0"));
            $("#endDate").val(endDate.getFullYear() + "." + common.lpad(endDate.getMonth() + 1,2,"0") + "." + common.lpad(endDate.getDate(),2,"0"));
        }

        $("#bt_search").click();
    }

    function dateType(paramSlctType){
        $("#onedayDate").hide();
        $("#monthDate").hide();
        $("#yearDate").hide();
        $("#div_dayButton").hide();
        $("#div_monthButton").hide();
        $("#div_yearButton").hide();
        $("#th_bottonList").hide();
        $("#rangeDatepicker").hide();

        // 날짜 유지 없이 버튼 새로 불러올때 초기화 하기
        // if(paramSlctType == 0){                 // 일검색
        //     setDayButton("day");
        //     $("#onedayDate").show();
        //     $("#div_dayButton").show();
        //     $("#th_bottonList").show();
        // }else if(paramSlctType == 1){           // 월 검색
        //     setDayButton("month");
        //     $("#monthDate").show();
        //     $("#div_monthButton").show();
        //     $("#th_bottonList").show();
        // }else if(paramSlctType == 2){           // 년도 검색
        //     setDayButton("year");
        //     $("#yearDate").show();
        //     $("#div_yearButton").show();
        //     $("#th_bottonList").show();
        // }else if(paramSlctType == 3){           // 기간 검색
        //     setTimeDate(dateTime);
        //     $("#rangeDatepicker").show();
        //     $("#bt_search").click();
        // }else if(paramSlctType == 99){          // 99 : 검색창만
        //     $("#bt_search").click();
        // }else if(common.isEmpty(paramSlctType)){
            if(slctType == 0 || slctType == 4){
                setDayButton();
                $("#onedayDate").show();
                $("#div_dayButton").show();
                $("#th_bottonList").show();
            } else if(slctType == 1 ){
                setDayButton();
                $("#monthDate").show();
                $("#div_monthButton").show();
                $("#th_bottonList").show();
            }else if(slctType == 2){
                setTimeDate(dateTime);
                setDayButton();
                $("#yearDate").show();
                $("#div_yearButton").show();
                $("#th_bottonList").show();
            }else if(slctType == 3){
                setTimeDate(dateTime);
                $("#rangeDatepicker").show();
                $("#bt_search").click();
            }else if(slctType == 99){
                setTimeDate(dateTime);
                $("#bt_search").click();
            }
        // }

        $(".labelMonthButton" + common.lpad(month,2,"0")).addClass('active');
        $(".labelDayButton" + common.lpad(day,2,"0")).addClass('active');
    }

    function monthBottonClick(data){
        if(!common.isEmpty(data)){
            monthClick("",$("#search_year").val(), common.lpad(data.month,2,"0"), common.lpad(day,2,"0"));
        }
    }

    function dayBottonClick(data){
        if(!common.isEmpty(data)) {
            dayClick("", year, common.lpad(month,2,"0"), common.lpad(data.day,2,"0"));
        }
    }

    $(document).on('click', '._prevSearch', function(){
        prevNext(true);
    });

    $(document).on('click', '._nextSearch', function(){
        prevNext(false);
    });

    $(document).on('click', '._todaySearch', function(){
        dateType();
    });

    function prevNext(isPrev){
        var addDate = isPrev ? -1 : 1;
        if(slctType == 0) {                 // 일간
            dayButtonPrev(addDate);
        }else if(slctType == 1) {           // 월간
            monthButtonPrev(addDate);
        }else if(slctType == 2) {           // 연간
            yearButtonPrev(addDate);
        }else if(slctType == 3) {           // 기간 선택
            dateRangePrev(addDate);
        }else if(slctType == 4) {           // 주간
            dayButtonPrev(addDate);
            weekRangePrev(addDate);
        }
    }

    function dayButtonPrev(isPrev){
        var tmpDay = day;
        day = Number(day) + isPrev;

        var lastDay = new Date(year,common.lpad(month,2,"0"),-1).getDate() + 1;
        if(day < 1){
            day = 1;
        }
        if(day > lastDay){
            day = lastDay;
        }

        var yearIdx = $("#div_dayButton").find("#search_year option").index( $("#div_dayButton").find("#search_year option:selected") );
        isPrev == 1 ? yearIdx -= 1 : yearIdx += 1;
        if(common.lpad(month,2,"0") + common.lpad(tmpDay,2,"0") == "0101" && isPrev == -1){
            $("#div_dayButton").find("#search_year option:eq(" + yearIdx + ")").prop("selected", true);
            year = year - 1;
            month = "12";
            day = "31";
            monthClick("",year, month, day);
        }else if(common.lpad(month,2,"0") + common.lpad(tmpDay,2,"0") == "1231" && isPrev == 1){
            $("#div_dayButton").find("#search_year option:eq(" + yearIdx + ")").prop("selected", true);
            year = year + 1;
            month = "01";
            day = "01";
            monthClick("",year, month, day);
        }else{
            dayClick("", year, common.lpad(month,2,"0"), common.lpad(day,2,"0"));
        }
    }
    function monthButtonPrev(isPrev){
        var tmpMonth = month;
        month = Number(month) + isPrev;

        if(month < 1){
            month = 1;
        }
        if(month > 12){
            month = 12;
        }

        var yearIdx = $("#div_monthButton").find("#search_year option").index( $("#div_monthButton").find("#search_year option:selected") );
        isPrev == 1 ? yearIdx -= 1 : yearIdx += 1;
        if(common.lpad(tmpMonth,2,"0") == "01" && isPrev == -1){
            $("#div_monthButton").find("#search_year option:eq(" + yearIdx + ")").prop("selected", true);
            year = year - 1;
            month = "12";
            day = "31";
            monthClick("",year, month, day);
        }else if(common.lpad(tmpMonth,2,"0") == "12" && isPrev == 1){
            $("#div_monthButton").find("#search_year option:eq(" + yearIdx + ")").prop("selected", true);
            year = year + 1;
            month = "01";
            day = "01";
            monthClick("",year, month, day);
        }else{
            monthClick("",$("#search_year").val(), common.lpad(month,2,"0"), common.lpad(day,2,"0"));
        }

    }
    function yearButtonPrev(isPrev){
        year = Number($("#search_year").val()) + isPrev;
        $(".search_exchange_years").empty();
        $(".search_exchange_years").append(util.getCommonCodeSelect(year, search_exchange_years));
        $(".search_exchange_years").find("#search_year").css("width","100%");
        $(".search_exchange_years").find("#search_year").css("height","100%");

        monthClick("", $("#div_yearButton").find("#search_year").val(), month, day);
    }

    function dateRangePrev(isPrev){
        $("#startDate").val(moment($("#startDate").val()).add("days", isPrev).format('YYYY.MM.DD'));
        $("#endDate").val(moment($("#endDate").val()).add("days", isPrev).format('YYYY.MM.DD'));
        $("#displayDate").val($("#startDate").val() + " - " + $("#endDate").val());
        $("#bt_search").click();
    }


    function getMonday(str) {
        var y = str.substr(0, 4);
        var m = str.substr(5, 2);
        var d = str.substr(8, 2);
        d = new Date(y,m-1,d);
        var day = d.getDay(),
            diff = d.getDate() - day + (day == 0 ? -6:1);
        return new Date(d.setDate(diff));
    }
    function setMonday(){
        var monday = getMonday($("#onedayDate").val());       // 선택한 날의 월요일
        var startDate = monday;
        var endDate = new Date(Date.parse(monday) + 6 * 1000 * 60 * 60 * 24);
        $("#startDate").val(startDate.getFullYear() + "." + common.lpad(startDate.getMonth() + 1,2,"0") + "." + common.lpad(startDate.getDate(),2,"0"));
        $("#endDate").val(endDate.getFullYear() + "." + common.lpad(endDate.getMonth() + 1,2,"0") + "." + common.lpad(endDate.getDate(),2,"0"));
    }

    function weekRangePrev(week){
        var monday = getMonday($("#onedayDate").val());       // 선택한 날의 월요일
        var startDate = monday;
        var endDate = new Date(Date.parse(monday) + 6 * 1000 * 60 * 60 * 24);
        $("#startDate").val(startDate.getFullYear() + "." + common.lpad(startDate.getMonth() + 1,2,"0") + "." + common.lpad(startDate.getDate(),2,"0"));
        $("#endDate").val(endDate.getFullYear() + "." + common.lpad(endDate.getMonth() + 1,2,"0") + "." + common.lpad(endDate.getDate(),2,"0"));
    }

</script>
