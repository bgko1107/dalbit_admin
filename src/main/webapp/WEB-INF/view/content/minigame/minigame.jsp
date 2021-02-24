<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding mt10">
    <!-- DATA TABLE -->
    <span>
        미니게임 노출여부와 게임을 등록 및 관리 할 수 있습니다.<br/>
        변경된 노출여부 및 설명은 스플래시 화면과 네이티브 전송을 통해 갱신이 가능합니다.
    </span>
    <!-- 미니게임 정보 -->
    <div class="col-lg-12 no-padding pt5">
        <div class="widget widget-table">
            <div class="widget-header">
                <h3><i class="fa fa-table"></i>미니게임 버튼 노출여부</h3>
            </div>
            <div class="widget-content mt10">
                <table class="table table-bordered">
                    <colgroup>
                        <col width="25%"/><col width="25%"/><col width="25%"/><col width="25%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>구분</th>
                        <th>상태</th>
                        <th>수정일시</th>
                        <th>수정자</th>
                    </tr>
                    </thead>
                    <tbody id="tb_miniGameInfo"></tbody>
                </table>
            </div>
            <div class="widget-footer">
                 <span>
                     <button class="btn btn-primary pull-right mb5" type="button" id="bt_updateMiniGameInfo">수정하기</button>
                 </span>
            </div>
        </div>
    </div>
    <!-- //테스트 계정 현황 -->
    <div class="col-lg-12 no-padding mt5">
        <button class="btn btn-success pull-right mb5 mr10" type="button" id="bt_nativeSend">네이티브 전송</button>
        <button class="btn btn-default pull-right mb5 mr5" type="button" id="bt_miniGameDetail">게임 등록</button>
        <div class="widget-content ">
            <table id="mailboxTable" class="table table-sorting table-hover table-bordered mt10">
                <colgroup>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="25%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>게임명칭</th>
                    <th>이미지</th>
                    <th>노출 문구</th>
                    <th>등록/수정일시</th>
                    <th>수정자</th>
                    <th>노출상태</th>
                </tr>
                </thead>
                <tbody id="tb_miniGameList">
                </tbody>
            </table>
        </div>
    </div>

    <form id="miniGameDetail"></form>
</div>
<!-- //table -->

<script type="text/javascript">

    $("#bt_updateMiniGameInfo").on('click', function(){
        if(confirm('미니게임 노출 상태를 변경하시겠습니까?')){
            // var data = {
            // };

            // util.getAjaxData("miniGameInfoUpd", "/rest/content/boardAdm/mini/game/info/update", data, fn_success_miniGameInfoUpd);
        }
    });

    $("#bt_nativeSend").on('click', function(){
        if(confirm('네이티브 전송하시겠습니까?')){  // socaket 송신하자
            // var data = {
            // };

            // util.getAjaxData("miniGameInfoUpd", "/rest/content/boardAdm/mini/game/info/update", data, fn_success_miniGameInfoUpd);
        }
    });

    //리스트 조회
    function miniGameList() {
        var data = {};
        util.getAjaxData("miniGameList", "/rest/content/boardAdm/mini/game/list", data, fn_success_miniGameList);
    }

    function fn_success_miniGameList(dst_id, response, param) {

        var template = $('#tmp_miniGameListTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#tb_miniGameList').html(html);
    }

    //상세 조회
    function miniGameDetail(gameNo) {
        var data = {
            game_no : gameNo
        }
        util.getAjaxData("miniGameDetail", "/rest/content/boardAdm/mini/game/detail", data, fn_success_miniGameDetail);
    }

    function fn_success_miniGameDetail(dst_id, response, param) {

        var template = $('#tmp_miniGameDetailTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#miniGameDetail').html(html);
    }

    //게임 등록
    $("#bt_miniGameDetail").on('click', function(){
        var template = $('#tmp_miniGameDetailTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $('#miniGameDetail').html(html);
    });

    //미니게임 수정
    $(document).on('click', '#bt_editMiniGame', function(){
        if(confirm('미니 게임정보를 수정 하시겠습니까?')){
            var data = {
                game_no: $("#miniGameDetail #gameNo").val()
                , game_name: $("#miniGameDetail #gameName").val()
                , image_url: $("#miniGameDetail #imageUrl").val()
                , game_desc: $("#miniGameDetail #contents").val()
                , view_yn: $("#miniGameDetail #detail_view_yn").prop('checked') ? 1 : 0
            };
            util.getAjaxData("miniGameInfoUpd", "/rest/content/boardAdm/mini/game/info/update", data, fn_success_miniGameInfoUpd);
        }
    });

    function fn_success_miniGameInfoUpd(dst_id, response){

        var template = $('#tmp_miniGameInfoTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#tb_miniGameInfo').html(html);
    }

    function getImg(){
        $("#imageViewer").attr('src',$("#imageUrl").val());
    }
</script>

<script id="tmp_miniGameInfoTable" type="text/x-handlebars-template">
    <%--{{#each this.data as |data|}}--%>
        <tr>
            <td>미니게임 버튼 노출여부</td>
            <td>{{{getOnOffSwitch view_on}}}</td>
            <td>2021-02-16 14:33:00</td>
            <td>김자운</td>
        </tr>
    <%--{{else}}
        <tr>
            <td colspan="4">{{isEmptyData}}</td>
        </tr>
    {{/each}}--%>
</script>

<script id="tmp_miniGameListTable" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td><a href="javascript://" onclick="miniGameDetail({{game_no}})">{{game_name}}</a></td>
            <td><img src="{{renderImage image_url}}"/></td>
            <td>{{game_desc}}</td>
            <td>{{substr reg_date 0 19}}</td>
            <td>{{op_name}}</td>
            <td>{{{getCommonCodeLabel view_yn 'content_viewOn'}}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="7">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>


<script id="tmp_miniGameDetailTable" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered mt10">
        <colgroup>
            <col width="5%"/><col width="5%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="10%"/><col width="10%"/><col width="5%"/><col width="5%"/>
            <col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/>
        </colgroup>
        <tr>
            <th>No</th>
            <td></td>
            <th>게임명칭</th>
            <td><input type="text" class="_trim" id="gameName" name="gameName" value="{{game_name}}"></td>
            <th>등록/수정자</th>
            <td>{{op_name}}</td>
            <th>등록/수정일시</th>
            <td>{{last_upd_date}}</td>
            <th>노출여부</th>
            <td>{{{getOnOffSwitch view_yn 'view_yn'}}}</td>
        </tr>
        <tr>
            <th>이미지URL</th>
            <td colspan="4">
                <input hidden type="text" class="_trim" id="gameNo" name="gameNo" value="{{game_no}}" >
                <input type="text" class="_trim" id="imageUrl" name="imageUrl" style="width:88%" value="{{image_url}}" >
                <input type="button" value="미리보기" onclick="getImg();">
                <img id="imageViewer" class="thumbnail fullSize_background no-margin no-padding" style="border:0px; border-radius:0px; width:150px;height: 150px" src="" alt="" /></a>
            </td>
            <th>노출문구</th>
            <td colspan="4"><textarea name="contents" id="contents" style='width:100%;height:100%;' rows="10"  placeholder="게임에 대한 설명을 입력해주세요.">{{game_desc}}</textarea></td>
        </tr>
    </table>
    {{#if game_no}}
        <button class="btn btn-default pull-right mr5" type="button" id="bt_editMiniGame">수정하기</button>
    {{else}}
        <button class="btn btn-default pull-right mr5" type="button" id="bt_insertMiniGame">등록하기</button>
    {{/if}}
</script>
