<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<!-- TOP BAR -->
<div class="top-bar">
    <div class="container">

        <div class="clearfix">
            <a href="javascript://" class="pull-left toggle-sidebar-collapse" style="margin-top:5px;"><i class="fa fa-bars"></i></a>
            <!-- logo -->
            <div class="pull-left left">
                <a href="/index.html"><img src="https://image.dalbitlive.com/images/api/logo_real.png" alt="달빛라이브 관리자" style="width:120px;"></a>
                <h1 class="sr-only">Dalbit Admin</h1>
            </div>
            <!-- end logo -->
            <div class="pull-right right">
                <div class="top-bar-right">
                    <!-- logged user and the menu -->
                    <div class="logged-user">
                        <div class="btn-group">
                            <a href="javascript://" class="btn btn-link">
                                <img src="/favicon.ico" alt="User Avatar">
                                <span class="name">${principal.getUserInfo().getName()}</span> [ <span class="userid">${principal.getUserInfo().getUserid()}</span> ]
                                님 께서 로그인 하셨습니다.
                            </a>
                            <%--<ul class="dropdown-menu" role="menu">
                                <li>
                                    <a href="#">
                                        <i class="fa fa-user"></i>
                                        <span class="text">Profile</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <i class="fa fa-cog"></i>
                                        <span class="text">Settings</span>
                                    </a>
                                </li>
                                <li>

                                </li>
                            </ul>--%>
                            <a href="/logout">
                                <button type="button" class="btn btn-success">
                                    <i class="fa fa-power-off"></i>
                                    <span class="text">로그아웃</span>
                                </button>
                            </a>
                        </div>
                    </div>
                    <!-- end logged user and the menu -->
                </div>
                <!-- end top-bar-right -->
            </div>
        </div>
    </div>
    <!-- /container -->
</div>
<!-- /top -->

<div class="dalbit_modal"></div>
<div id="imageFullSize"></div>