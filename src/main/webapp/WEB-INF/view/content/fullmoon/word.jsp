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
                    <col width="3%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="3%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>보름달 상태</th>
                    <th>구분</th>
                    <th>노출 대상</th>
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
                    <col width="3%"/>
                    <col width="5%"/>
                    <col width="10%"/>
                    <col width="5%"/>
                    <col width="3%"/>
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


<script type="text/javascript">
    $(document).ready(function() {
        word();
    });

    function word() {
        alertWord();
        guideWord();
    }
    function alertWord() {
        var template = $("#tmp_alertWord").html();
        var templateScript = Handlebars.compile(template);
        // var data =
        var html = templateScript(templateScript);
        $("#alertWord").html(templateScript);
    }
    function guideWord() {
        var template = $("#tmp_guideWord").html();
        var templateScript = Handlebars.compile(template);
        // var data =
        var html = templateScript(templateScript);
        $("#guideWord").html(templateScript);
    }

</script>

<script id="tmp_alertWord" type="text/x-handlebars-template">
    <tr>
        <td>1</td>
        <td></td>
        <td></td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
    <tr>
        <td>2</td>
        <td></td>
        <td></td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
    <tr>
        <td>3</td>
        <td></td>
        <td></td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
    <tr>
        <td>4</td>
        <td></td>
        <td></td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
    <tr>
        <td>5</td>
        <td></td>
        <td></td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
</script>

<script id="tmp_guideWord" type="text/x-handlebars-template">
    <tr>
        <td>6</td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
    <tr>
        <td>7</td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
    <tr>
        <td>8</td>
        <td></td>
        <td><textarea type="textarea" class="form-control" style="width:100%; height: 30px;"></textarea></td>
        <td></td>
        <td><button type="button" class="form-control btn-default sm">수정</button></td>
    </tr>
</script>
