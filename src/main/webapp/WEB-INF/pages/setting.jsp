<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>抽奖设置</title>
    <link rel="shortcut icon" href="resources/admin/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="resources/css/reset.css" />
    <link rel="stylesheet" href="resources/js/element-ui@2.4.11/lib/theme-chalk/index.css"/>
    <link rel="stylesheet" href="resources/bootstrap-4.4.1/css/bootstrap.min.css"  >

    <script src="resources/js/polyfill.min.js"></script>
    <script src="resources/js/vue.min.js"></script>
    <script src="resources/js/element-ui@2.4.11/lib/index.js"></script>
    <script src="resources/js/jquery-3.4.1.min.js" ></script>
    <script src="resources/bootstrap-4.4.1/js/popper.min.js" ></script>
    <script src="resources/bootstrap-4.4.1/js/bootstrap.min.js" ></script>
    <style>
        .el-input {
            width: 120px;
        }
        .el-table {
            margin-bottom: 10px;
        }
        * {
            cursor: initial;
        }
        .awards
        {
            width: 100%;
            margin: auto;
            margin-top: 50px;
        }
        h1 {
            font-size: 30px;
            text-align: center;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        h1 span {
            font-size: 16px;
        }
        a {
            text-decoration: underline;
            cursor: pointer;
        }
    </style>
</head>
<body>
<button onclick="opensetting()">点击</button>
<%--设置模态框(modal)--%>
<div class="modal fade" id="setting" tabindex="-1" role="dialog" aria-labelledby="setting" aria-hidden="true">
    <div  class="modal-dialog">
        <div class="modal-content " <%--style="width:650px"--%>>
            <div class="modal-header" >
                <h5 class="modal-title" id="settingModalLabel" >
                    抽奖设置(请按抽奖顺序添加)
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" >
                <div id="app-setting" >
                    <div class="awards" >
                        <el-table :data="tableData">
                            <el-table-column
                                    :prop="item.prop"
                                    :label="item.label"
                                    width="100"
                                    v-for="(item, index) in columns"
                                    :key="index">
                                <template slot-scope="scope">
                                    <div>
                                        <div v-if="scope.row.editing[item.prop]">
                                            <el-input
                                                    size="mini"
                                                    v-model="scope.row[item.prop]"
                                                    @blur="onSaveCell(scope.row, item.prop)"
                                            ></el-input>
                                        </div>
                                        <div
                                                v-else
                                                @dblclick="onEditCell(scope.row, item.prop, $event)">
                                            {{ scope.row[item.prop] || '(请填写)' }}
                                        </div>
                                    </div>
                                </template>
                            </el-table-column>

                            <el-table-column prop="address" label="操作">
                                <template slot-scope="scope">
                                    <el-button
                                            size="small"
                                            @click="onAdd(scope.row, scope.$index)"
                                            type="primary">增加</el-button>
                                    <el-button
                                            size="small"
                                            @click="onRemove(scope.row, scope.$index)"
                                            type="danger">删除</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <el-button
                                size="small"
                                type="primary"
                                @click="onAdd(null, -1)"
                                v-show="tableData.length===0"
                        >增加</el-button>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
            </div>
        </div>
    </div>
</div>
<%--end设置模态框(modal)--%>
<script>
    function opensetting(){
        $('#setting').modal('show')
    }
    new Vue({
        el: '#app-setting',
        data: {
            dialogVisible: false,
            columns: [
                {
                    prop: 'name',
                    label: '名称',
                },{
                    prop: 'count',
                    label: '数量',
                },{
                    prop: 'award',
                    label: '奖品',
                }
            ],
            tableData: [
                {
                    name: '特等奖',
                    count: 1,
                    editing: {},
                },{
                    name: '一等奖',
                    count: 1,
                    editing: {},
                }
            ],
            memberSource: [],
        },
        computed: {
            awards: function() {
                return this.tableData
                    .filter(function(item) {
                        return item.name && item.count;
                    })
                    .map(function(item) {
                        return {
                            name: item.name,
                            count: item.count,
                            award: item.award,
                        };
                    });
            },
        },
        methods: {
            onChange: function(value) {
                console.log(value);
                localStorage.setItem('batchNumber', value);
            },
            onSaveCell: function(row, key) {
                this.$set(row.editing, key, false);
                this.saveData();
            },
            onEditCell: function(row, key, e) {
                this.$set(row.editing, key, true);
                const parent = e.target.parentNode;
                this.$nextTick(function() {
                    // console.log(parent.innerHTML, row)
                    parent.querySelector('input').focus();
                });
            },
            onAdd: function(row, index) {
                console.log(row, index);
                this.tableData.splice(index + 1, 0, {
                    editing: {
                        name: true,
                    },
                });
            },
            onRemove: function(row, index) {
                this.tableData.splice(index, 1);
                this.saveData();
            },
            onAddMember: function() {
                this.memberSource.push({
                    editing: {
                        name: true,
                    },
                });
            },
            onRemoveMember: function(row, index) {
                var vm = this;
                this.$confirm('删除不可撤销！可重新添加', '确定删除吗？', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                }).then(function() {
                    vm.memberSource.splice(index, 1);
                    vm.saveData();
                });
            },
            saveData: function() {
                localStorage.setItem('awards', JSON.stringify(this.awards));
            },
        },
        created: function() {
            var awards = JSON.parse(localStorage.getItem('awards')) || [
                {
                    name: '安慰奖',
                    award: '优惠券',
                    count: 50,
                },{
                    name: '四等奖',
                    award: '华为手机',
                    count: 20,
                },{
                    name: '三等奖',
                    award: '苹果手机',
                    count: 15,
                },{
                    name: '二等奖',
                    award: 'iphone 11',
                    count: 5,
                },{
                    name: '一等奖',
                    award: 'MacBook Pro',
                    count: 1,
                }
            ];
            this.tableData = awards.map(function(item) {
                return {
                    name: item.name,
                    count: item.count,
                    award: item.award,
                    editing: {},
                };
            });
            this.saveData();
        },
    });
</script>
</body>
</html>
