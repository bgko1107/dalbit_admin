<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>
</c:set>

<!-- 보름달 상태창 & 알럿 문구 -->
<div class="col-lg-12 form-inline mt15">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3>보름달 상태창 & 알럿 문구</h3>
        </div>
        <div class="widget-content mt10">
            <table id="alert" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="20%"/>
                    <col width="30%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>보름달 상태</th>
                    <th>구분</th>
                    <th>노출 대상</th>
                    <th>제목</th>
                    <th>문구</th>
                    <th>적용</th>
                </tr>
                </thead>
                <tbody id="alertWord">
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- //보름달 상태창 & 알럿 문구 -->

<!-- 보름달 가이드 팝업 -->
<div class="col-lg-6 form-inline mt15">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3>보름달 가이드 팝업</h3>
        </div>
        <div class="widget-content mt10">
            <table id="guide" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="50%"/>
                    <col width="20%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>영역</th>
                    <th>문구</th>
                    <th>노출</th>
                    <th>적용</th>
                </tr>
                </thead>
                <tbody id="guideWord">
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- //보름달 가이드 팝업 -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    $(document).ready(function() {
        word();
    });

    function word() {

        var data = {
            slctType : 0
        }
        util.getAjaxData('list', "/rest/content/fullmoon/info/text", data, function(dst_id, response) {
            //alert(response.message);

            var alertArray;
            var guideArray;

            if(!common.isEmpty(response.data)){
                alertArray = response.data.slice(0,2);
                guideArray = response.data.slice(2,5)
            }

            alertWord(alertArray);
            guideWord(guideArray);
        });
    }
    function alertWord(data) {

        if(common.isEmpty(data)){
           return false;
        }
        var template = $("#tmp_alertWord").html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);
        $("#alertWord").html(html);
    }

    function guideWord(data) {
        if(common.isEmpty(data)){
            return false;
        }
        var template = $("#tmp_guideWord").html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);
        $("#guideWord").html(html);
    }

    $(document).on('click', '._updateAlertWordBtn', function(){
        var me = $(this);
        if(confirm('수정하시겠습니까?')){

            var slctType = me.data('slcttype');
            var title = '';

            if(slctType == 5){
                title = me.parent().parent().find('._title');
                if(common.isEmpty(title.val())){
                    alert('제목을 입력해주세요.');
                    title.focus();
                    return false;
                }
                title = title.val();
            }

            var textData = me.parent().parent().find('._textData');
            if(common.isEmpty(textData.val())){
                alert('문구를 입력해주세요.');
                textData.focus();
                return false;
            }

            var data = {
                slctType : slctType
                , title : title
                , textData : textData.val()
            }

            textEdit('alertWordUpdate', data);
        }

    });

    $(document).on('click', '._updateGuideWordBtn', function(){
        var me = $(this);
        if(confirm('수정하시겠습니까?')){

            var slctType = me.data('slcttype');
            var textData = me.parent().parent().find('._textData');
            if(common.isEmpty(textData.val())){
                alert('문구를 입력해주세요.');
                textData.focus();
                return false;
            }

            var viewYn = me.parent().parent().find('.onoffswitch-checkbox');
            console.log(viewYn.prop('checked'));


            var data = {
                slctType : slctType
                , textData : textData.val()
                , viewYn : viewYn.prop('checked') ? 1 : 0
            }

            textEdit('guideWordUpdate', data);
        }
    });

    function textEdit(dist_id, data){
        util.getAjaxData('update', '/rest/content/fullmoon/info/textEdit', data, function(dst_id, response, param) {
            alert(response.message);
        });
    }

</script>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script id="tmp_alertWord" type="text/x-handlebars-template">
    {{#each this as |data|}}
        <tr>
            <td>{{slctType}}</td>
            <td>{{{getCommonCodeLabel slctType 'full_moon_text_alert_status'}}}</td>
            <td>{{{getCommonCodeLabel slctType 'full_moon_text_alert_type'}}}</td>
            <td>{{{getCommonCodeLabel slctType 'full_moon_text_alert_target'}}}</td>
            <td>
                {{#equal data.slctType '5'}}
                    <input type="text" class="form-control _title" style="width:100%;" rows="5" value="{{data.title}}" />
                {{else}}
                    -
                {{/equal}}
            </td>
            <td>
                <textarea type="textarea" class="form-control _textData" style="width:100%;" rows="5">{{{replaceTextarea textData}}}</textarea>
            </td>
            <td><button type="button" class="form-control btn-default sm _updateAlertWordBtn" data-slcttype="{{data.slctType}}">수정</button></td>
        </tr>
    {{/each}}
</script>

<script id="tmp_guideWord" type="text/x-handlebars-template">
    {{#each this as |data|}}
        <tr>
            <td>{{slctType}}</td>
            <td>{{{getCommonCodeLabel slctType 'full_moon_text_guide_area'}}}</td>
            <td><textarea type="textarea" class="form-control _textData" style="width:100%;white-space: pre-wrap;" rows="5">{{{replaceTextarea textData}}}</textarea></td>
            <td>{{{getOnOffSwitch data.viewYn data.slctType}}}</td>
            <td><button type="button" class="form-control btn-default sm _updateGuideWordBtn" data-slcttype="{{data.slctType}}">수정</button></td>
        </tr>
    {{/each}}
</script>
