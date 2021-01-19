<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<%--<script src="https://www.google-analytics.com/analytics.js"></script>--%>
<script src="/template/js/jquery/jquery-2.1.0.min.js"></script>
<script src="/template/js/bootstrap/bootstrap.js"></script>
<script src="/template/js/plugins/modernizr/modernizr.js"></script>
<script src="/template/js/plugins/bootstrap-tour/bootstrap-tour.custom.js"></script>
<script src="/template/js/plugins/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="/template/js/king-common.js"></script>
<script src="/template/js/deliswitch.js"></script>
<script src="/template/js/plugins/stat/jquery.easypiechart.min.js"></script>
<script src="/template/js/plugins/raphael/raphael-2.1.0.min.js"></script>
<script src="/template/js/plugins/stat/flot/jquery.flot.min.js"></script>
<script src="/template/js/plugins/stat/flot/jquery.flot.resize.min.js"></script>
<script src="/template/js/plugins/stat/flot/jquery.flot.time.min.js"></script>
<script src="/template/js/plugins/stat/flot/jquery.flot.pie.min.js"></script>
<script src="/template/js/plugins/stat/flot/jquery.flot.tooltip.min.js"></script>
<script src="/template/js/plugins/jquery-sparkline/jquery.sparkline.min.js"></script>
<script src="/template/js/plugins/datatable/jquery.dataTables.js"></script>
<script src="/template/js/plugins/datatable/dataTables.bootstrap.js"></script>
<script src="/template/js/plugins/datatable/exts/dataTables.colVis.bootstrap.js"></script>
<script src="/template/js/plugins/datatable/exts/dataTables.colReorder.min.js"></script>
<script src="/template/js/plugins/datatable/exts/dataTables.tableTools.min.js"></script>
<script src="/template/js/plugins/jqgrid/jquery.jqGrid.min.js"></script>
<script src="/template/js/plugins/jqgrid/jquery.jqGrid.fluid.js"></script>
<script src="/template/js/plugins/jqgrid/i18n/grid.locale-en.js"></script>
<script src="/template/js/plugins/jquery-mapael/jquery.mapael.js"></script>
<script src="/template/js/plugins/raphael/maps/usa_states.js"></script>
<script src="/template/js/king-chart-stat.js"></script>
<script src="/template/js/king-table.js"></script>
<script src="/template/js/king-components.js"></script>
<script src="/template/js/plugins/moment/moment.js"></script>
<script src="/template/js/plugins/moment/moment-locale-ko.js"></script>
<script src="/template/js/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="/template/js/plugins/daterangepicker/daterangepicker.js"></script>
<script src="/template/js/jquery-ui/jquery-ui-1.10.4.custom.js"></script>
<script src="/template/js/plugins/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<%--<script src="/template/js/king-form-layouts.js"></script>--%>

<!-- Editor -->
<script src="/template/js/plugins/summernote/summernote.js?${dummyData}"></script>
<script src="/template/js/plugins/summernote/lang/summernote-ko-KR.js"></script>

<script src="/template/js/plugins/markdown/markdown.js"></script>
<script src="/template/js/plugins/markdown/to-markdown.js"></script>
<script src="/template/js/plugins/markdown/bootstrap-markdown.js"></script>
<%--<script src="/template/js/king-elements.js"></script>--%>

<!-- plugin -->
<script src="/js/lib/bootstrap-datepicker.kr.js"></script>
<script src="/js/lib/bootstrap-datetimepicker.js"></script>
<script src="/js/lib/jquery-confirm.min.js?${dummyData}"></script>

<!-- dataTable -->
<script src="/js/lib/dataTable/buttons.html5-1.5.2.min.js"></script>
<script src="/js/lib/dataTable/dataTables.buttons-v1.5.2.min.js"></script>

<!-- dalbit -->
<script src="/js/lib/jquery.fileDownload-v1.4.5.js"></script>
<script src="/js/lib/handlebars-v4.7.2.min.js"></script>
<%--<script src="/js/lib/moment-v2.24.0.js"></script>--%>
<script src="/js/message/commonMessage.js?${dummyData}"></script>
<script src="/js/common.js?${dummyData}"></script>
<script src="/js/commonUtil.js?${dummyData}"></script>
<script src="/js/helper.js?${dummyData}"></script>

<script src="/js/globalEvent.js?${dummyData}"></script>
<script src="/js/uiControl.js?${dummyData}"></script>

<!-- DataTable Util -->
<script src="/js/dataTablesSource/member/memberDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/broadcast/broadcastDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/sampleDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/customer/customerDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/customer/questionDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/dataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/menuDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/pushDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/splashDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/bannerDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/eventDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/itemDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/noticeDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/content/appDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/connect/connectDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/utilDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/administrate/faqDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/administrate/termsDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/administrate/messageDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/sample/sampleDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/payment/payDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/money/resourceDataTableSource.js?${dummyData}"></script>
<script src="/js/dataTablesSource/administrate/testDalByeolDataTableSource.js?${dummyData}"></script>
<script src="/js/dalbitDataTableUtil.js?${dummyData}"></script>
<script src="/js/code/commonCode.js?${dummyData}"></script>

<script type="text/javascript">
    /*로그 찍기*/
    function dalbitLog(data){
        if(${fn:contains("/local/dev/", cfn:getActiveProfile())}){
            console.log(data);
        }
    }
    var ADMIN_SERVER_URL = '${cfn:getProperty("server.adm.url")}';
    var PHOTO_SERVER_URL = '${cfn:getProperty("server.photo.url")}';
    var EDITOR_PHOTO_SERVER_URL = '${cfn:getProperty("server.editor.photo.url")}';
    var IMAGE_SERVER_URL = '${cfn:getProperty("server.img.url")}';
    var ANT_SERVER_URL = '${cfn:getProperty("server.ant.url")}';
    var ANT_APP_NAME = '${cfn:getProperty("ant.app.name")}';

    var WOWZA_SERVER_URL = '${cfn:getProperty("wowza.wss.url")}';
    var WOWZA_PREFIX = '${cfn:getProperty("wowza.prefix")}';
    var WOWZA_SUFFIX = '${cfn:getProperty("wowza.suffix")}';

    var ADMIN_NICKNAME = '달빛지기';

    var LOGIN_USER_NAME = '${principal.getUserInfo().getName()}';
    var LOGIN_USER_ID = '${principal.getUserInfo().getUserid()}';

</script>