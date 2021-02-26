<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData" value="<%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>" />

<!-- 보름달 On/Off -->
<form id="condition5">
    <div class="col-lg-12 form-inline mt15 mb15">
        <div class="widget widget-table">
            <div class="widget-header">
                <h3>챔피언십 이벤트</h3>
            </div>
            <div class="widget-content mt10">

                <div id="tabContainer" class="mb15">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="champion_tablist">
                        <li class="active"><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_1" data-event_no="1" aria-expanded="false" class="_tab">1회차</a></li>
                        <li><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_2" data-event_no="2" aria-expanded="false" class="_tab">2회차</a></li>
                        <li><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_3" data-event_no="3" aria-expanded="false" class="_tab">3회차</a></li>
                        <li><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_4" data-event_no="4" aria-expanded="false" class="_tab">4회차</a></li>
                        <li><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_5" data-event_no="5" aria-expanded="false" class="_tab">5회차</a></li>
                        <li><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_total" data-event_no="0" aria-expanded="false" class="_tab">종합</a></li>
                    </ul>
                </div>

                <div id="twoDepth_tabContainer" class="mb15">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="twoDepth_tablist" id="twoDepth_champion_tablist">
                        <li class="active"><a href="#detail_event" role="tab" data-toggle="tab" id="twoDepth_tab_dj" data-slct_type="1" aria-expanded="false" class="_tab">DJ 랭킹</a></li>
                        <li><a href="#detail_event" role="tab" data-toggle="tab" id="twoDepth_tab_fan" data-slct_type="2" aria-expanded="false" class="_tab">팬 랭킹</a></li>
                    </ul>
                </div>

                <div id="tableArea"></div>

                <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
            </div>
        </div>

        <div class="mt15" id="fullmoonEventDetailArea"></div>

    </div>
</form>
<!-- //보름달 On/Off -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    $(function(){
        getFullmoonEventList();
    })

    function getFullmoonEventList(){
        var oneDepth = $('#champion_tablist li.active a');
        var twoDepth = $('#twoDepth_champion_tablist li.active a');
        var event_no = oneDepth.data('event_no');
        var slct_type = twoDepth.data('slct_type');

        var data = {
            event_no : event_no
            , slct_type : slct_type
        }

        if(slct_type == 1){
            util.getAjaxData("getChampionEventList", "/rest/content/event/champion/list", data, function(dst_id, response) {
                var template = $("#tmp_djList").html();
                var templateScript = Handlebars.compile(template);
                var context = response.data;
                var html = templateScript(context);
                $("#tableArea").html(html);
            });
        }else{
            util.getAjaxData("getChampionEventList", "/rest/content/event/champion/list", data, function(dst_id, response) {
                var template = $("#tmp_fanList").html();
                var templateScript = Handlebars.compile(template);
                var context = response.data;
                var html = templateScript(context);
                $("#tableArea").html(html);
            });
        }

    }

    $(document).on('click', '._tab', function(){
        getFullmoonEventList();
    });

</script>


<script type="text/x-handlebars-template" id="tmp_djList">
    <table id="fullmoonYn" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="5%"/>
            <col width="5%;"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="20%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="10%"/>
            <col width="20%"/>
        </colgroup>
        <thead>
        <tr>
            <th>순위</th>
            <th>프로필</th>
            <th>회원번호</th>
            <th>연락처</th>
            <th>닉네임</th>
            <th>받은 별</th>
            <th>승점</th>
            <th>왕큐피트<br />프로필</th>
            <th>왕큐피트<br />회원번호</th>
            <th>왕큐피트<br />닉네임</th>
        </tr>
        </thead>
        <tbody id="fullmoonEventList">
            {{#each this as |data|}}
                <tr>
                    <td>{{data.rank}}</td>
                    <td><img class="thumbnail fullSize_background" src="{{renderImage data.profileImage}}" style='width:65px; height:65px; margin-bottom: 0px' /></td>
                    <td>{{{memNoLink data.mem_no data.mem_no}}}</td>
                    <td>{{phoneNumHyphen memPhone}}</td>
                    <td>{{memNick}}</td>
                    <td>{{addComma totalPoint}} 별</td>
                    <td>{{addComma winPoint}} 점</td>
                    <td><img class="thumbnail fullSize_background" src="{{renderImage data.qupid_profileImage}}" style='width:65px; height:65px; margin-bottom: 0px' /></td>
                    <td>{{{memNoLink data.qupid_mem_no data.qupid_mem_no}}}</td>
                    <td>{{qupid_memNick}}</td>
                </tr>

            {{else}}
                <tr>
                    <td colspan="10">{{isEmptyData}}</td>
                </tr>
            {{/each}}
        </tbody>
    </table>
</script>

<script type="text/x-handlebars-template" id="tmp_fanList">
    <table id="fullmoonYn" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="5%"/>
            <col width="5%;"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="20%"/>
            <col width="5%"/>
        </colgroup>
        <thead>
        <tr>
            <th>순위</th>
            <th>프로필</th>
            <th>회원번호</th>
            <th>연락처</th>
            <th>닉네임</th>
            <th>보낸 달</th>
        </tr>
        </thead>
        <tbody id="fullmoonEventList">
        {{#each this as |data|}}
            <tr>
                <td>{{data.rank}}</td>
                <td><img class="thumbnail fullSize_background" src="{{renderImage data.profileImage}}" style='width:65px; height:65px; margin-bottom: 0px' /></td>
                <td>{{{memNoLink data.mem_no data.mem_no}}}</td>
                <td>{{phoneNumHyphen memPhone}}</td>
                <td>{{memNick}}</td>
                <td>{{totalPoint}} 달</td>
            </tr>

        {{else}}
            <tr>
                <td colspan="6">{{isEmptyData}}</td>
            </tr>
        {{/each}}
        </tbody>
    </table>
</script>