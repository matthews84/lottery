<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>导入数据</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" href="resources/admin/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="resources/bootstrap-4.4.1/css/bootstrap.min.css" >
    <link href="resources/bootstrap-fileinput/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="resources/fontawesome/css/all.min.css" >
    <link href="resources/bootstrap-fileinput/themes/explorer-fas/theme.min.css" media="all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="resources/admin/plugins/icon-kit/dist/css/iconkit.min.css">

    <script src="resources/js/jquery-3.4.1.min.js" ></script>
    <script src="resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js" ></script>
    <script src="resources/bootstrap-fileinput/js/plugins/piexif.min.js" type="text/javascript"></script>
    <script src="resources/bootstrap-fileinput/js/plugins/sortable.min.js" type="text/javascript"></script>
    <script src="resources/bootstrap-fileinput/js/fileinput.min.js" type="text/javascript"></script>
    <script src="resources/bootstrap-fileinput/js/locales/fr.js" type="text/javascript"></script>
    <script src="resources/bootstrap-fileinput/js/locales/es.js" type="text/javascript"></script>
    <script src="resources/bootstrap-fileinput/themes/fas/theme.min.js" type="text/javascript"></script>
    <script src="resources/bootstrap-fileinput/themes/explorer-fas/theme.min.js" type="text/javascript"></script>
    <script src="resources/js/shim.js" ></script>
    <script src="resources/js/xlsx.core.min.js"></script>
    <!--bootstrap-editable组件以及中文包的引用-->
    <link href="resources/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet" />
    <script src="resources/bootstrap3-editable/js/bootstrap-editable.min.js"></script>

    <!--bootstrap table组件以及中文包的引用-->
    <link href="resources/bootstrap-table-1.16.0/bootstrap-table.min.css" rel="stylesheet" />
    <script src="resources/bootstrap-table-1.16.0/bootstrap-table.min.js"></script>
    <script src="resources/bootstrap-table-1.16.0/bootstrap-table-editable.min.js"></script>
    <script src="resources/bootstrap-table-1.16.0/bootstrap-table-zh-CN.min.js"></script>
    <script src="resources/js/utils.js"></script>
    <style>
        /* dataTables列内容居中 */
        .table>tbody>tr>td{
            text-align:center;
        }
        /* dataTables表头居中 */
        .table>thead:first-child>tr:first-child>th{
            text-align:center;
        }
        /* bootstrapTables表头居中 */
        .bootstrap-table .table thead>tr>th {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="container my-4" >
        <h5>导入数据</h5>
        <input id="file-0" name="file-0" type="file" onchange="importfile(this)">
    </div>
    <div id="toolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-primary">
            <span class="fa fa-plus" aria-hidden="true"></span>新增
        </button>
        <button id="btn_edit" type="button" class="btn btn-info">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改/锁定
        </button>
        <button id="btn_delete" type="button" class="btn btn-danger">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
        </button>
        <button id="btn_get" type="button" class="btn btn-success">
            <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>确认提交
        </button>
    </div>
    <table id="dataGrid" style="height: 100%"></table>
</div>
</body>
<script>
    $("#file-0").fileinput({
        theme: 'fas',
        uploadUrl: '#'
    }).on('filepreupload', function(event, data, previewId, index) {
        alert('The description entered is:\n\n' + ($('#description').val() || ' NULL'));
    });
    var $table =  $('#dataGrid');
    var globaltitle = {};
    var emptydata = {};
    var configjson ;

    function inittitle(gtitle) {
        var firstcolumns = [
            {
                field: "checkbox",
                title: "",
                checkbox: true
            }]

        var lastcolumns =
            {
                field: "operate",
                title: "操作",
                align: "center",
                formatter: function (value, row, index) {
                    var html = '';
                    html += '<a href="javascript:void(0);" onclick="removeData(' + row.id + ')" ><li class="ik ik-trash-2"></li></a>';
                    return html;
            }
        }

        for (var a in gtitle) {
            var obj = {
                editable: {
                    type: 'text',
                    mode: "popup",//popup
                    title: '',
                    disabled: true,
                    emptytext: '无',
                }
            }
            obj.field = gtitle[a];
            obj.title = a;
            obj.editable.title = a;
            firstcolumns.push(obj);
        }
        firstcolumns.push(lastcolumns);
        return firstcolumns;
    }


    var TableInit = function (data,columns) {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $table.bootstrapTable({
                data:data,
                method: 'post',                      //请求方式（*）
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: false,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                queryParams: '',//传递参数（*）
                sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber:1,                       //初始化加载第一页，默认第一页
                pageSize: 10,                       //每页的记录行数（*）
                pageList: [5,10,20,100,300,500],        //可供选择的每页的行数（*）
//              search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                strictSearch: true,
                showColumns: true,                  //是否显示所有的列
//              showRefresh: true,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "id",                     //每一行的唯一标识，一般为主键列
//              showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                   //是否显示父子表
                columns:columns,
                onClickRow: function (row) {
                    console.log(row)
                },
            });
        };
        return oTableInit;
    };
    //初始化页面上面的按钮事件
    var ButtonInit = function () {
        var oInit = new Object();
        var postdata = {};
        oInit.Init = function () {
            $('#btn_add').click(addcolumns)
            $('#btn_delete').click(deletecolumns)
            $('#btn_edit').click(editcolumns)
            $('#identitys').change(changeidentitys)
        };

        return oInit;
    };

    $('#btn_get').click(function () {
        var table = JSON.stringify($table.bootstrapTable('getData'));
        $.ajax({
            async: false,
            type: "post",
            url: "./import",
            // dataType: "json",//接受服务器返回的数据类型
            contentType:"application/json;charset=UTF-8",
            data: table,
            success: function (data) {
                alert(data);
                window.location.href = "./index";
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                // 状态码
                console.log(textStatus+":"+XMLHttpRequest.status);
                alert("导入失败");
            },
        });
    });

    function  addcolumns() {
        var table = $table.bootstrapTable('getData'),
            length = table.length;;
        var empty = cloneObj(configjson[1].data);
        empty.id = length +1;
        $table.bootstrapTable('load',table );
        $table.bootstrapTable('selectPage', 1); //Jump to the first page
        $table.bootstrapTable('prepend', empty);

    }
    function deletecolumns() {
        var obj =$table.bootstrapTable('getSelections');
        var ids = $.map(obj, function (row) {
            return row.id;
        });
        if(ids.length>0){
            $table.bootstrapTable('remove', {field: 'id', values: ids});
        }else {
            alert("请至少选择一行删除")
        }
    }

    function editcolumns() {
        $table.find('.editable').editable('toggleDisabled');
    }

    function  removeData(index) {
        $table.bootstrapTable('remove', {field: 'id', values: [index]});
    }

    //    $table.on("click-row.bs.table",function(e, row, $element) {
    //        var  index= $element.data('index');
    //        alert(index);
    //    });

    function importfile(file) {//导入
        var f = file.files[0];
        $("#excelfile").val(f.name);
        var wb;//读取完成的数据
        var rABS = false; //是否将文件读取为二进制字符串
        var ie = IEVersion();
        if(ie != -1 && ie != 'edge'){
            if(ie<10){
                return;
            }else{
                rABS = true;
            }
        }

        if(checkfilename(file)){
            var reader = new FileReader();
            reader.onload = function(e) {
                var data = e.target.result;
                if(rABS) {
                    wb = XLSX.read(btoa(fixdata(data)), {//手动转化
                        type: 'base64'
                    });
                } else {
                    wb = XLSX.read(data, {
                        type: 'binary'
                    });
                }
                var result = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
                var members=[];
                for(var i=0;i<result.length;i++)
                {
                    var member={"sid":result[i]["员工编号"],"name":result[i]["员工姓名"]};
                    members.push(member);
                }
                // console.log(members);
                localStorage.setItem("members",JSON.stringify(members));
                resoveresult(globaltitle,result);
            };

            if(rABS) {
                reader.readAsArrayBuffer(f);
            } else {
                reader.readAsBinaryString(f);
            }
        }


    }

    function resoveresult(config,list) {
        $table.bootstrapTable('showLoading');
        var rs= [];
        if(list.length>0){
            for(var one in list){
                var obj = {};
                for(var index in config){
                    var key = list[one][index];
                    // console.log(key);
                    if(!key){
                        obj[config[index]]="";
                    }else {
                        obj[config[index]] = key;
                    }
                }
                obj.id = Number(one)+1;
                rs.push(obj);
            }
            console.log(rs);
            $table.bootstrapTable('load',rs );
        }
        $table.bootstrapTable('hideLoading');
    }

    function getjson(url) {
        $.ajaxSetup({async:false});
        var rs;
        $.getJSON(url, function(json){
            rs = json;
        });
        return rs;
    }

    function changeidentitys() {
        $("#FileInput").val('');
        $("#excelfile").val('');
        var type = $('#identitys input:radio:checked').val();
        for (var m in configjson) {
            if (configjson[m].type == type) {
                globaltitle = configjson[m].title;
                $table.bootstrapTable('destroy');
                initTable();
            }
        }
    }

    function initTable() {
        var columns = inittitle(globaltitle);
        //1.初始化Table
        var oTable = new TableInit([],columns);
        oTable.Init();
    }
    $(function () {
        configjson = getjson('resources/config/data.json');
        globaltitle = configjson[1].title;
        // console.log(globaltitle);
        initTable();
        //2.初始化Button的点击事件
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();

    });
</script>
</html>
