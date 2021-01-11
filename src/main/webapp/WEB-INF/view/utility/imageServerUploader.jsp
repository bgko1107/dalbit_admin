<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <div class="main-header">
        <h2>이미지서버 업로드</h2>
        <em>이미지 서버에 업로드 후 이미지 url을 반환합니다.</em>
    </div>
    <div class="main-content">
        <!-- FILE UPLOAD -->
        <div class="widget">
            <div class="widget-header">
                <h3><i class="fa fa-cloud-upload"></i> File Upload</h3>
            </div>
            <div class="widget-content">
                <form id="id_dropzone" class="dropzone dz-clickable" enctype="multipart/form-data">
                    <%--<div class="dz-default dz-message"><span>Drop files here to upload</span></div>--%>
                </form>
            </div>
        </div>
        <!-- END FILE UPLOAD -->
    </div>
</div>

<script type="text/javascript" src="/template/js/plugins/dropzone/dropzone.min.js"></script>
<script type="text/javascript">
    Dropzone.autoDiscover = false;

    $(document).ready(function () {
        $("#id_dropzone").dropzone({
            maxFiles: 2000,
            url: "/ajax_file_upload_handler/",
            success: function (file, response) {
                console.log(response);
            }
        });
    })
</script>