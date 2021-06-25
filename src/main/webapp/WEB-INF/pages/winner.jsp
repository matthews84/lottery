<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Admin</title>
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="shortcut icon" href="resources/admin/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" href="resources/admin/icon.css" >
        <link rel="stylesheet" href="resources/bootstrap-4.4.1/css/bootstrap.min.css"  >
        <link rel="stylesheet" href="resources/admin/plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="resources/admin/plugins/ionicons/dist/css/ionicons.min.css">
        <link rel="stylesheet" href="resources/admin/plugins/icon-kit/dist/css/iconkit.min.css">
        <link rel="stylesheet" href="resources/admin/plugins/perfect-scrollbar/css/perfect-scrollbar.css">
        <link rel="stylesheet" href="resources/admin/plugins/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="resources/admin/dist/css/theme.min.css">
        <link rel="stylesheet" href="resources/bootstrap-table-1.16.0/bootstrap-table.min.css" >
        <script src="resources/admin/src/js/vendor/modernizr-2.8.3.min.js"></script>
        <style>
            /* dataTables列内容居中 */
            .table>tbody>tr>td{
                text-align:center;
            }
            /* dataTables表头居中 */
            .table>thead:first-child>tr:first-child>th{
                text-align:center;
            }
        </style>
    </head>
<body>
<div id="toolbar" class="select" style="width: 90px">
    <select class="form-control">
        <option value="">导出本页</option>
        <option value="all">导出所有</option>
        <option value="selected">导出所选</option>
    </select>
</div>
<div class="wrapper">
    <header class="header-top" header-theme="light">
        <div class="container-fluid">
            <div class="d-flex justify-content-between">
                <div class="top-menu d-flex align-items-center">
                    <button type="button" class="btn-icon mobile-nav-toggle d-lg-none"><span></span></button>
                    <div class="header-search">
                        <div class="input-group">
                            <span class="input-group-addon search-close"><i class="ik ik-x"></i></span>
                            <input type="text" class="form-control">
                            <span class="input-group-addon search-btn"><i class="ik ik-search"></i></span>
                        </div>
                    </div>
                    <button type="button" id="navbar-fullscreen" class="nav-link"><i class="ik ik-maximize"></i></button>
                </div>
                <div class="top-menu d-flex align-items-center">
                    <button type="button" class="nav-link ml-10" id="apps_modal_btn" data-toggle="modal" data-target="#appsModal"><i class="ik ik-grid"></i></button>
                    <div class="dropdown">
                        <a class="dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="avatar" src="resources/admin/img/user.jpg" alt=""></a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="./logout"><i class="ik ik-power dropdown-icon"></i> Logout</a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </header>

    <div class="page-wrap">
        <div class="app-sidebar colored">
            <div class="sidebar-header">
                <a class="header-brand" href="./admin">
                    <div class="logo-img">
                        <img src="resources/admin/src/img/brand-white.svg" class="header-brand-img" alt="lavalite">
                    </div>
                    <%--显示管理员用户名--%>
                    <%if (session.getAttribute("admin")!=null&&!"".equals(session.getAttribute("admin"))){%>
                    <span style="background-color: #ae9890;font-size: medium">欢迎您！<%=session.getAttribute("admin")%></span>
                    <%}%>
                </a>
                <button type="button" class="nav-toggle"><i data-toggle="expanded" class="ik ik-toggle-right toggle-icon"></i></button>
                <button id="sidebarClose" class="nav-close"><i class="ik ik-x"></i></button>
            </div>

            <div class="sidebar-content">
                <div class="nav-container">
                    <nav id="main-menu-navigation" class="navigation-main">
                        <div class="nav-lavel">Navigation</div>
                        <div class="nav-item">
                            <a href="./winner"><i class="ik ik-credit-card"></i><span>中奖管理</span></a>
                        </div>
                        <div class="nav-item">
                            <a href="./admin"><i class="ik ik-inbox"></i><span>员工管理</span></a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <div class="main-content">
            <div class="container-fluid">
                <div class="page-header">
                    <div class="row align-items-end">
                        <div class="col-lg-8">
                            <div class="page-header-title">
                                <i class="ik ik-credit-card bg-blue"></i>
                                <div class="d-inline">
                                    <h5>Bootstrap Tables</h5>
                                    <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <nav class="breadcrumb-container" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="./admin"><i class="ik ik-home"></i></a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="#">Tables</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Bootstrap Tables</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="row">
                        <div class="card">
                            <div class="card-body p-0 table-border-style">
                                <div class="table-responsive">
                                    <table class="table table-inverse"
                                        id="table"
                                        data-toolbar="#toolbar"
                                        data-search="true"
                                        data-show-refresh="true"
                                        data-show-toggle="true"
                                        data-show-fullscreen="true"
                                        data-show-columns="true"
                                        data-show-columns-toggle-all="true"
                                        data-show-export="true"
                                        data-click-to-select="true"
                                        data-detail-formatter="detailFormatter"
                                        data-minimum-count-columns="2"
                                        data-show-pagination-switch="true"
                                        data-pagination="true"
                                        data-id-field="sid"
                                        data-page-list="[5, 10, 20, 50]"
                                        data-show-footer="true"
                                        data-side-pagination="client"
                                        data-url="./winner-list"
                                        data-response-handler="responseHandler">
                                    </table>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <aside class="right-sidebar">
            <div class="sidebar-chat" data-plugin="chat-sidebar">
                <div class="sidebar-chat-info">
                    <h6>Chat List</h6>
                    <form class="mr-t-10">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search for friends ...">
                            <i class="ik ik-search"></i>
                        </div>
                    </form>
                </div>
            </div>
        </aside>
        <footer class="footer">
            <div class="w-100 clearfix">
                <span class="text-center text-sm-left d-md-inline-block">Copyright © 2020 ThemeKit v2.0. All Rights Reserved.</span>
                <span class="float-none float-sm-right mt-1 mt-sm-0 text-center">Crafted with <i class="fa fa-heart text-danger"></i> by <a href="http://lavalite.org/" class="text-dark" target="_blank">杨毅</a></span>
            </div>
        </footer>
    </div>
</div>




<div class="modal fade apps-modal" id="appsModal" tabindex="-1" role="dialog" aria-labelledby="appsModalLabel" aria-hidden="true" data-backdrop="false">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="ik ik-x-circle"></i></button>
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="quick-search">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 ml-auto mr-auto">
                            <div class="input-wrap">
                                <input type="text" id="quick-search" class="form-control" placeholder="Search..." />
                                <i class="ik ik-search"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-body d-flex align-items-center">
                <div class="container">
                    <div class="apps-wrap">
                        <div class="app-item">
                            <a href="#"><i class="ik ik-bar-chart-2"></i><span>Dashboard</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-mail"></i><span>Message</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-users"></i><span>Accounts</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-shopping-cart"></i><span>Sales</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-briefcase"></i><span>Purchase</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-server"></i><span>Menus</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-clipboard"></i><span>Pages</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-message-square"></i><span>Chats</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-map-pin"></i><span>Contacts</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-box"></i><span>Blocks</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-calendar"></i><span>Events</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-bell"></i><span>Notifications</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-pie-chart"></i><span>Reports</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-layers"></i><span>Tasks</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-edit"></i><span>Blogs</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-settings"></i><span>Settings</span></a>
                        </div>
                        <div class="app-item">
                            <a href="#"><i class="ik ik-more-horizontal"></i><span>More</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="resources/js/jquery-3.4.1.min.js" ></script>
<script src="resources/bootstrap-4.4.1/js/popper.min.js" ></script>
<script src="resources/bootstrap-4.4.1/js/bootstrap.min.js" ></script>
<script src="resources/bootstrap-table-1.16.0/FileSaver.min.js"></script>
<script src="resources/bootstrap-table-1.16.0/js-xlsx/xlsx.core.min.js" type="text/javascript" ></script>
<script src="resources/bootstrap-table-1.16.0/jsPDF/jspdf.min.js"></script>
<script src="resources/bootstrap-table-1.16.0/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
<script src="resources/bootstrap-table-1.16.0/es6-promise.auto.min.js" type="text/javascript" ></script>
<script src="resources/bootstrap-table-1.16.0/html2canvas.min.js" type="text/javascript"></script>
<script src="resources/bootstrap-table-1.16.0/tableExport.min.js"></script>
<script src="resources/bootstrap-table-1.16.0/bootstrap-table.min.js"></script>
<script src="resources/bootstrap-table-1.16.0/bootstrap-table-export.min.js"></script>
<script src="resources/admin/plugins/perfect-scrollbar/dist/perfect-scrollbar.min.js"></script>
<script src="resources/admin/plugins/screenfull/dist/screenfull.js"></script>
<script src="resources/admin/dist/js/theme.min.js"></script>
<script>
    var $table = $('#table')
    var $remove = $('#remove')
    var selections = []

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.id
        })
    }

    function responseHandler(res) {
        $.each(res.rows, function (i, row) {
            row.state = $.inArray(row.id, selections) !== -1
        })
        return res
    }
    $(function() {
        // $('#locale').change(initTable)
        $('#toolbar').find('select').change(function () {
            $table.bootstrapTable('destroy').bootstrapTable({
                exportDataType: $(this).val(),
                exportTypes: ['json', 'xml', 'csv', 'txt', 'sql', 'excel'],
                height: 550,
                locale: $('#locale').val(),
                columns: [
                    {
                        field: 'state',
                        checkbox:true,
                        visible: $(this).val() === 'selected'
                    },{
                        field: 'sid',
                        title: '员工编号',
                        sortable: true,
                    }, {
                        field: 'name',
                        title: '姓名'
                    }, {
                        field: 'sex',
                        title: '性别'
                    }, {
                        field: 'age',
                        title: '年龄',
                        sortable: true,
                    }, {
                        field: 'tele',
                        title: '手机号码'
                    },{
                        field: 'dep',
                        title: '所属部门'
                    }, {
                        field: 'prizelevel',
                        title: '奖项等级'
                    }, {
                        field: 'prize',
                        title: '奖项'
                    }
                ]
            })
        }).trigger('change')
    })
</script>
</body>
</html>
