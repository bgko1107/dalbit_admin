<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>
</c:set>


<!-- 보름달 On/Off -->
<form id="condition5">
    <div class="col-lg-12 form-inline mt15 mb15">
        <div class="widget widget-table">
            <div class="widget-header">
                <h3>보름달 노출여부</h3>
            </div>
            <div class="widget-content mt10">
                <table id="fullmoonYn" class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="10%"/>
                        <col width="5%"/>
                        <col width="5%"/>
                        <col width="5%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>구분</th>
                        <th>값</th>
                        <th>수정일</th>
                        <th>등록자명</th>
                    </tr>
                    </thead>
                    <tbody id="fullmoonYnCondition">
                    </tbody>
                </table>
            </div>
            <div class="widget-footer">
                <span>
                    <button class="btn btn-default full-right" type="button" id="bt_fullmoonYnEdit">수정하기</button>
                </span>
            </div>
        </div>
    </div>
</form>
<!-- //보름달 On/Off -->

<!-- 보름달 완성 조건(DJ) -->
<form id="condition1">
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
</form>
<!-- //보름달 완성 조건(DJ) -->

<!-- 보름달 공헌 조건(청취자) -->
<form id="condition3">
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
</form>
<!-- //보름달 공헌 조건(청취자) -->


<!-- 혜택 -->
<form id="condition2">
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
</form>
<!-- //혜택 -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    $(document).ready(function() {
        fullmoonYnCondition();
        djCondition();
        listenerCondition();
        prize();
    });

    function fullmoonYnCondition(){
        var data = {
            slctType : 5
        };
        util.getAjaxData("fullmoonYnConditionList", "/rest/content/fullmoon/info/condition", data, function(dst_id, response) {
            var template = $("#tmp_fullmoonYnCondition").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#fullmoonYnCondition").html(html);
        });
    }

    function djCondition() {
        var data = {
            slctType : 1
        };
        util.getAjaxData("djConditionList", "/rest/content/fullmoon/info/condition", data, function(dst_id, response) {
            var template = $("#tmp_djCondition").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#djCondition").html(html);
        });
    }
    function listenerCondition() {
        var data = {
            slctType : 3
        };
        util.getAjaxData("listenerConditionList", "/rest/content/fullmoon/info/condition", data, function(dst_id, response) {
            var template = $("#tmp_listenerCondition").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#listenerCondition").html(html);
        });
    }
    function prize() {
        var data = {
            slctType : 2
        };
        util.getAjaxData("prizeConditionList", "/rest/content/fullmoon/info/condition", data, function(dst_id, response) {
            var template = $("#tmp_prize").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#prize").html(html);
        });
    }

    $(document).on('click', '#bt_djConditionEdit', function(){
       if(confirm("보름달 완성 조건을 수정하시겠습니까?")){
           var broadTime = $("#condition1 #broadTime");
           if(common.isEmpty(broadTime.val())){
               alert('방송시간을 입력해주세요.');
               broadTime.focus();
               return false;
           }

           var listenerCnt = $("#condition1 #listenerCnt");
           if(common.isEmpty(listenerCnt.val())){
               alert('누적청취자 수를 입력해주세요.');
               listenerCnt.focus();
               return false;
           }

           var byeolCnt = $("#condition1 #byeolCnt");
           if(common.isEmpty(byeolCnt.val())){
               alert('받은 별을 입력해주세요.');
               byeolCnt.focus();
               return false;
           }

           var goodPoint = $("#condition1 #goodPoint");
           if(common.isEmpty(goodPoint.val())){
               alert('좋아요 수를 입력해주세요.');
               goodPoint.focus();
               return false;
           }

           var data = {
               slctType : 1
               , broadTime : broadTime.val()
               , listenerCnt : listenerCnt.val()
               , byeolCnt : byeolCnt.val()
               , goodPoint : goodPoint.val()
           }

           conditionEdit('condition1', data);
       }
    });

    $(document).on('click', '#bt_prizeEdit', function(){
        if(confirm("보름달 혜택을 수정하시겠습니까?")){
            var djItemCnt = $("#condition2 #djItemCnt");
            if(common.isEmpty(djItemCnt.val())){
                alert('DJ 지급 개수를 입력해주세요.');
                djItemCnt.focus();
                return false;
            }

            var listenerItemCnt = $("#condition2 #listenerItemCnt");
            if(common.isEmpty(listenerItemCnt.val())){
                alert('청취자 지급 개수를 입력해주세요.');
                listenerItemCnt.focus();
                return false;
            }

            var data = {
                slctType : 2
                , djItemCnt : djItemCnt.val()
                , djItemType : $('select[name="reward"]:eq(0)').val()
                , listenerItemCnt : listenerItemCnt.val()
                , listenerItemType : $('select[name="reward"]:eq(1)').val()
            }

            conditionEdit('condition2', data);
        }
    });


    $(document).on('click', '#bt_listenerConditionEdit', function(){
        if(confirm("보름달 공헌 조건을 수정하시겠습니까?")){
            var minGiftDal = $("#condition3 #minGiftDal");
            if(common.isEmpty(minGiftDal.val())){
                alert('보낸 달 수를 입력해주세요.');
                minGiftDal.focus();
                return false;
            }

            var minGoodPoint = $("#condition3 #minGoodPoint");
            if(common.isEmpty(minGoodPoint.val())){
                alert('좋아요 수를 입력해주세요.');
                minGoodPoint.focus();
                return false;
            }

            var data = {
                slctType : 3
                , minGiftDal : minGiftDal.val()
                , minGoodPoint : minGoodPoint.val()
                , listenYn : $("#condition3 #detail_listenYn").prop('checked') ? 1 : 0
            }

            conditionEdit('condition3', data);
        }
    });

    $(document).on('click', '#bt_fullmoonYnEdit', function(){
        if(confirm("보름달 노출 여부를 수정하시겠습니까?")){
            var data = {
                slctType : 5
                , fullmoonYn : $("#condition5 #detail_fullmoonYn").prop('checked') ? 1 : 0
            }
            conditionEdit('condition5', data);
        }
    });

    function conditionEdit(dist_id, data){
        util.getAjaxData(dist_id, "/rest/content/fullmoon/info/conditionEdit", data, function(dst_id, response) {
            alert(response.message);
            if(dist_id == 'condition1'){
                djCondition();

            }else if(dist_id == 'condition2'){
                prize();

            }else if(dist_id == 'condition3'){
                listenerCondition();
            }
        });
    }

</script>

<script id="tmp_djCondition" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td>{{{getCommonCodeLabel slctType 'full_moon_condition1_slctType'}}}</td>
            <td><input type="text" class="form-control" style="width: 50%;" id="{{getCommonCodeText slctType 'full_moon_condition1_values'}}" value="{{targetValue}}" /> {{{getCommonCodeLabel slctType 'full_moon_condition1_slctType_unit'}}}</td>
            <td>{{moment editDate 'YYYY-MM-DD HH:mm:ss'}}</td>
            <td>{{opName}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_prize" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td>{{{getCommonCodeLabel slctType 'full_moon_condition2_slctType'}}}</td>
            <td>{{{getCommonCodeSelect itemType 'full_moon_condition2_reward'}}}</td>
            <td><input type="text" class="form-control" id="{{getCommonCodeText slctType 'full_moon_condition2_slctType_values'}}" style="width: 50%;" value={{itemCnt}} /> 개</td>
            <td>{{moment editDate 'YYYY-MM-DD HH:mm:ss'}}</td>
            <td>{{opName}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_listenerCondition" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td>{{{getCommonCodeLabel slctType 'full_moon_condition3_slctType'}}}</td>
            <td>
                {{^equal slctType '3'}}
                    <input type="text" class="form-control" style="width: 50%;" id="{{getCommonCodeText ../slctType 'full_moon_condition3_slctType_values'}}" value="{{../minValue}}" />
                    {{{getCommonCodeLabel slctType 'full_moon_condition3_slctType_unit'}}}
                {{else}}
                    {{{getOnOffSwitch ../minValue 'listenYn'}}}
                {{/equal}}
            </td>
            <td>{{moment editDate 'YYYY-MM-DD HH:mm:ss'}}</td>
            <td>{{opName}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_fullmoonYnCondition" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td>{{{getCommonCodeLabel slctType 'full_moon_condition5_slctType'}}}</td>
            <td>
                {{{getOnOffSwitch minValue 'fullmoonYn'}}}
            </td>
            <td>{{moment editDate 'YYYY-MM-DD HH:mm:ss'}}</td>
            <td>{{opName}}</td>
        </tr>
    {{/each}}
</script>