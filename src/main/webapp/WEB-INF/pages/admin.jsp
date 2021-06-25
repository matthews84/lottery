<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
    <link rel="stylesheet" href="resources/bootstrap-table-1.16.0/bootstrap-table.min.css" >
    <link rel="stylesheet" href="resources/admin/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="resources/admin/plugins/ionicons/dist/css/ionicons.min.css">
    <link rel="stylesheet" href="resources/admin/plugins/icon-kit/dist/css/iconkit.min.css">
    <link rel="stylesheet" href="resources/admin/plugins/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" href="resources/admin/plugins/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="resources/admin/dist/css/theme.min.css">

    <script src="resources/admin/src/js/vendor/modernizr-2.8.3.min.js"></script>
    <style>
        /* dataTables列内容居中 */
        .table>tbody>tr>td{
            text-align:center;
        }
        /* dataTables表头居中 */
        .bootstrap-table .table thead>tr>th {
            text-align: center;
        }
    </style>
</head>
<body>
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
                                <i class="ik ik-inbox bg-blue"></i>
                                <div class="d-inline">
                                    <h5>Data Table</h5>
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
                                    <li class="breadcrumb-item active" aria-current="page">Data Table</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <div id="toolbar">
                        <div class="mb-md">
                            <button id="addToTable" onclick="addStaffPanel()" class="btn btn-primary">添加<i class="fa fa-plus"></i></button>
                        </div>
                </div>
                <%--table--%>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="dt-responsive">
                                    <table id="staff_table" data-toolbar="#toolbar">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="w-100 clearfix">
                <input type="hidden" id="add_status" value="${add_status}"/>
                <input type="hidden" id="del_status" value="${del_status}"/>
                <input type="hidden" id="update_status" value="${update_status}"/>
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
<!-- 修改数据模态框（Modal） -->
<form action="./update-staff" method="post" class="form-horizontal" role="form">
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateModalLabel">
                        修改员工信息
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="height: 100%;">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" readonly="readonly" name="update_sid" id="update_sid"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="update_name" id="update_name"
                                   placeholder="请输入姓名"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">性别</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="update_sex" id="update_sex"
                                   placeholder="请输入性别">
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-3 control-label">年龄</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="update_age" id="update_age"
                                   placeholder="请输入年龄"/>
                            </input>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号码</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="update_tele" id="update_tele"
                                   placeholder="请输入手机号码"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属部门</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="update_dep" id="update_dep"
                                   placeholder="请输入所属部门"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <input type="submit" class="btn btn-primary"value="提交"/>
                </div>
            </div>
        </div>
    </div>
</form>
<%--删除Stff Modal--%>
<form action="./del-staff" method="post" class="form-horizontal" role="form">
    <div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="delModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" >
                        确定删除?
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="del_sid" id="del_sid"/>
                    <p  style="width: 100%;height: 45px;display: block;line-height: 45px;text-align: center;">
                        该操作不可逆转,请谨慎选择</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <input type="submit" onclick="DelbyIdPanel()" class="btn btn-primary" value="确定"/>
                </div>
            </div>
        </div>
    </div>
</form>
<%--添加Staff Modal--%>
<form action="./insert-staff" method="post" class="form-horizontal" role="form">
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" >
                       添加员工
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">员工编号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="add_sid" id="add_sid"
                                   placeholder="请输入员工编号"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="add_name" id="add_name"
                                   placeholder="请输入姓名"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">性别</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="add_sex" id="add_sex"
                                   placeholder="请输入性别">
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-3 control-label">年龄</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="add_age" id="add_age"
                                   placeholder="请输入年龄"/>
                            </input>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号码</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="add_tele" id="add_tele"
                                   placeholder="请输入手机号码"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属部门</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control"  name="add_dep" id="add_dep"
                                   placeholder="请输入所属部门"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary"  >提交</button>
                </div>
            </div>
        </div>
    </div>
</form>
<script src="resources/js/jquery-3.4.1.min.js" ></script>
<script src="resources/bootstrap-4.4.1/js/popper.min.js" ></script>
<script src="resources/bootstrap-4.4.1/js/bootstrap.min.js" ></script>
<script src="resources/bootstrap-table-1.16.0/bootstrap-table.min.js"></script>
<script src="resources/admin/plugins/perfect-scrollbar/dist/perfect-scrollbar.min.js"></script>
<script src="resources/admin/plugins/screenfull/dist/screenfull.js"></script>
<script src="resources/admin/dist/js/theme.min.js"></script>
<script type="text/javascript">
        $('#staff_table').bootstrapTable({
        url:"./staff-list",                    //从后台获取数据时，可以是json数组，也可以是json对象
        method: 'post',                      //请求方式（*）
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）,数据为json数组时写client，json对象时（有total和rows时）这里要为server方式，写client列表无数据#}
        pageNumber: 1,                       //初始化加载第一页，默认第一页
        pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
        search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大#}
        strictSearch: true,
        showColumns: true,                  //是否显示所有的列
        showRefresh: true,                  //是否显示刷新按钮
        minimumCountColumns: 2,             //最少允许的列数
        clickToSelect: true,                //是否启用点击选中行
        height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度#}
        uniqueId: "id",                     //每一行的唯一标识，一般为主键列
        showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
        cardView: false,                    //是否显示详细视图
        detailView: false,                   //是否显示父子表
        idField: 'id', //指定主键
        singleSelect: true, //开启单选,想要获取被选中的行数据必须要有该参数
        columns: [
            {
                checkbox:true  //第一列显示复选框
            },{
                field: 'id',
                title: 'ID',
                sortable: true,
            },{
                field: 'sid',
                title: '员工编号',
                sortable: true,
            },{
                field: 'name',
                title: '姓名'
            },{
                field: 'sex',
                title: '性别'
           },{
               field: 'age',
               title: '年龄',
                sortable: true,
            },{
               field: 'tele',
               title: '手机号码'
           },{
                field: 'dep',
                title: '所属部门'
            },{
               field: 'operate',
               title: '操作',
               formatter: actionFormatter,
            }
        ],
    });
    //操作栏的格式化,value代表当前单元格中的值，row代表当前行数据，index表示当前行的下标
        function actionFormatter(value, row, index) {
            var id = index;
            var data = JSON.stringify(row);
            return [
                '<a class="like" href="javascript:void(0)" onclick="EditViewById('+id+')" title="编辑">','<i class="ik ik-edit-2"></i>','</a>  ',
                '<a class="remove" href="javascript:void(0)" onclick="DelbyIdPanel('+id+')" title="删除">','<i class="ik ik-trash-2"></i>','</a>'
            ].join('')
        }
        function addStaffPanel(){
            $('#addModal').modal('show')
        }
        $(function(){
            var add_status=($("#add_status").val()).toString()
            var del_status=($("#del_status").val()).toString()
            var update_status=($("#update_status").val()).toString()
            console.log("add_status:"+add_status)

            if(add_status==="ok"){
                alert("添加成功")
            }
            else if(add_status==="error"){
                alert("添加失败")
            }
            if(del_status==="ok"){
                alert("删除成功")
            }
            else if(del_status==="error"){
                alert("删除失败")
            }
            if(update_status==="ok"){
                alert("更新成功")
            }
            else if(update_status==="error"){
                alert("更新失败")
            }
        })
        function EditViewById(index){
            var data = $("#staff_table").bootstrapTable('getData')
            $("#update_sid").val(data[index].sid);
            $("#update_name").val(data[index].name);
            $("#update_sex").val(data[index].sex);
            $("#update_age").val(data[index].age);
            $("#update_tele").val(data[index].tele)
            $("#update_dep").val(data[index].dep)
            //弹出修改模态框，非新增模态框
            $('#updateModal').modal('show')
        }
        function DelbyIdPanel(index){
            var data = $("#staff_table").bootstrapTable('getData')
            $("#del_sid").val(data[index].sid);
            console.log(data[index].sid);
            $('#delModal').modal()
        }
</script>
</body>
</html>
