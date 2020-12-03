<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>
</c:set>

<!-- 보름달 완성 조건(DJ) -->
<div class="col-lg-6 form-inline mt15">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3>보름달 완성 조건(DJ)</h3>
        </div>
        <div class="widget-content mt10">
            <table id="fullmoonDj" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="10%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>구분</th>
                    <th>목표 값</th>
                    <th>수정일</th>
                    <th>등록자명</th>
                </tr>
                </thead>
                <tbody id="djCondition">
                </tbody>
            </table>
        </div>
        <div class="widget-footer">
            <span>
                <button class="btn btn-default" type="button" id="bt_djConditionEdit">수정하기</button>
            </span>
        </div>
    </div>
</div>
<!-- //보름달 완성 조건(DJ) -->

<!-- 보름달 공헌 조건(청취자) -->
<div class="col-lg-6 form-inline mt15 mb15">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3>보름달 공헌 조건(청취자)</h3>
        </div>
        <div class="widget-content mt10">
            <table id="fullmoonListener" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="10%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>구분</th>
                    <th>최소 값</th>
                    <th>수정일</th>
                    <th>등록자명</th>
                </tr>
                </thead>
                <tbody id="listenerCondition">
                </tbody>
            </table>
        </div>
        <div class="widget-footer">
            <span>
                <button class="btn btn-default full-right" type="button" id="bt_listenerConditionEdit">수정하기</button>
            </span>
        </div>
    </div>
</div>
<!-- //보름달 공헌 조건(청취자) -->


<!-- 혜택 -->
<div class="col-lg-9 form-inline mt15">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3>혜택</h3>
        </div>
        <div class="widget-content mt10">
            <table id="fullmoonPrize" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>구분</th>
                    <th>보상</th>
                    <th>지급 개수</th>
                    <th>수정일</th>
                    <th>등록자명</th>
                </tr>
                </thead>
                <tbody id="prize">
                </tbody>
            </table>
        </div>
        <div class="widget-footer">
            <span>
                <button class="btn btn-default" type="button" id="bt_prizeEdit">수정하기</button>
            </span>
        </div>
    </div>
</div>
<!-- //혜택 -->


<script type="text/javascript">
    $(document).ready(function() {
        condition();
    });

    function condition() {
        djCondition();
        listenerCondition();
        prize();
    }
    function djCondition() {
        var data = {
            slctType : 1
        };
        util.getAjaxData("djConditionList", "/rest/content/fullmoon/info/condition", data, function fn_djCondition_success(dst_id, response) {
            var template = $("#tmp_djCondition").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#djCondition").html(html);
        });
    }
    function listenerCondition() {
        var template = $("#tmp_listenerCondition").html();
        var templateScript = Handlebars.compile(template);
        // var data =
        var html = templateScript(templateScript);
        $("#listenerCondition").html(templateScript);
    }
    function prize() {
        var template = $("#tmp_prize").html();
        var templateScript = Handlebars.compile(template);
        // var data =
        var html = templateScript(templateScript);
        $("#prize").html(templateScript);
    }

</script>

<script id="tmp_djCondition" type="text/x-handlebars-template">
    <tr>
        <td>방송시간</td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 분</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
    <tr>
        <td>누적청취자</td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 명</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
    <tr>
        <td>받은 별</td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 별</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
    <tr>
        <td>좋아요 <br />(구매 부스터 포함)</td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 개</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
</script>

<script id="tmp_listenerCondition" type="text/x-handlebars-template">
    <tr>
        <td>보낸 달</td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 달</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
    <tr>
        <td>좋아요</td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 개</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
    <tr>
        <td>보름달 완성 시 청취 중</td>
        <td></td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
</script>

<script id="tmp_prize" type="text/x-handlebars-template">
    <tr>
        <td>청취자</td>
        <td>
            <select class="form-control">
                <option>룰렛 응모권</option>
                <option>부스터 아이템</option>
            </select>
        </td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 개</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
    <tr>
        <td>dj</td>
        <td>
            <select class="form-control">
                <option>룰렛 응모권</option>
                <option>부스터 아이템</option>
            </select>
        </td>
        <td><input type="text" class="form-control" style="width: 50%;"/> 개</td>
        <td>2020.11.09</td>
        <td>opName</td>
    </tr>
</script>