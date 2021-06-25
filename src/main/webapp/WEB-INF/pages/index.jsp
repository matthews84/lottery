<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta name="description" content="年会抽奖程序" />
    <title>年会抽奖</title>
    <link rel="shortcut icon" href="resources/admin/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="resources/css/reset.css" />
    <link rel="stylesheet" href="resources/js/element-ui@2.4.11/lib/theme-chalk/index.css"/>
    <link rel="stylesheet" href="resources/bootstrap-4.4.1/css/bootstrap.min.css"  >

    <script src="resources/js/jquery-3.4.1.min.js"></script>
    <script src="resources/js/polyfill.min.js"></script>
    <script src="resources/js/tagcanvas.min.js"></script>
    <script src="resources/js/vue.min.js"></script>
    <script src="resources/js/element-ui@2.4.11/lib/index.js"></script>
    <script src="resources/bootstrap-4.4.1/js/popper.min.js" ></script>
    <script src="resources/bootstrap-4.4.1/js/bootstrap.min.js" ></script>

</head>
<body>
<div id="app" class="bg">
    <div class="next title" v-if="awards.length>0">
        <span class="title">{{ awards[currentAward].name }}({{result[currentAward].length}}/{{awards[currentAward].count}})</span>
        <span v-show="awards[currentAward].award">, 奖品：{{ awards[currentAward].award }}</span>
    </div>
    <%--members--%>
    <div class="batch flexbox" v-show="!running && batchPlayers.length>0" >
        <div class="player" v-for="(item, index) in batchPlayers" :key="index" @click="onKick(item)" style="background-color: white">
            {{ item.name }}
        </div>
    </div>
    <div id="myCanvasContainer">
        <canvas width="300" height="300" id="myCanvas" ref="canvas">
            <p>换个现代浏览器吧！</p>
        </canvas>
    </div>
    <div id="tags">
        <ul>
            <li v-for="(tag, index) in members" :key="index">
                <a href="#" target="_blank">{{ tag.name }}</a>
            </li>
        </ul>
    </div>
    <div class="buttons">
        <span style="color: #fff">奖项</span>
        <el-select v-model="currentAward" size="small" @change="onChange">
            <el-option
                    v-for="(item, index) in awards"
                    :key="index"
                    :label="item.name"
                    :value="index"></el-option>
        </el-select>
        <span style="color: #fff">人数</span>
        <el-select v-model="batchNumber" size="small" >
            <el-option
                    v-for="index in 60"
                    :key="index"
                    :label="index"
                    :value="index"
            ></el-option>
        </el-select>
        <el-button size="small" ref="action" :disabled="buttonDisabled" type="danger" @click="toggle">{{buttonText}}</el-button>
        <el-button size="small" @click="onNext" :disabled="goOn || running">下一轮</el-button>
        <span style="color: #fff; margin-left:10px;">{{players.length}}</span>
        <span style="color: #fff; margin-left:10px;"></span>
        <el-button size="small" :disabled="running" type="warning" size="small" class="el-icon-refresh" @click="onReset" circle></el-button>
        <span style="color: #fff; margin-left:10px;"></span>
        <button type="button" onclick="opensetting()" class="btn btn-primary" >奖项设置</button>
        <span style="color: #fff; margin-left:10px;"></span>
        <button type="button"  onclick="window.location.href='./admin'" class="btn btn-danger" >后台管理</button>
    </div>
</div>
<%--安慰奖--%>
<div class="modal fade" id="batchresult" tabindex="-1" role="dialog" aria-labelledby="setting" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content " <%--style="width:650px"--%>>
            <div class="modal-header" >
                <h5 class="modal-title">抽奖结果</h5>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" >
                <div class="batch flexbox" v-show="!running && batchPlayers.length>0" >
                    <div class="player" v-for="(item, index) in batchPlayers" :key="index" @click="onKick(item)" style="background-color: white">
                        {{ item.name }}
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
            </div>
        </div>
    </div>
</div>
<%--设置模态框(modal)--%>
<div class="modal fade" id="setting" tabindex="-1" role="dialog" aria-labelledby="setting" aria-hidden="true">
    <div  class="modal-dialog">
        <div class="modal-content " <%--style="width:650px"--%>>
            <div class="modal-header" >
                <h5 class="modal-title" id="settingModalLabel" >
                    奖项设置(请按抽奖顺序添加)
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
<script type="text/javascript">
    new Vue({
        el: '#app',
        data: {
            batchNumber:1,
            running: false,
            awards: [],
            currentAward: 4,
            result: [],
            players: [],
            batchPlayers: [],
            members: [],
        },
        watch: {
            currentAward: function() {
                this.batchPlayers = [];
            },
        },
        computed: {
            buttonDisabled: function() {
                return (
                    this.result[this.currentAward].length >=
                    this.awards[this.currentAward].count || this.players.length === 0
                );
            },
            goOn: function() {
                return (
                    this.result[this.currentAward].length <
                    this.awards[this.currentAward].count &&
                    this.result[this.currentAward].length > 0
                );
            },
            buttonText: function() {
                if (this.running) {
                    return '停止';
                }
                if (this.goOn) {
                    return '继续';
                }
                return '开始';
            },
        },
        methods: {
            onReset: function() {
                var vm = this;
                this.$confirm(
                    '重置会清空所有抽奖结果，无法撤销！',
                    '确定要重置吗？',
                    {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning',
                    }
                ).then(function() {
                    vm.players=vm.members;
                    localStorage.setItem('players', JSON.stringify(vm.players));
                    // localStorage.removeItem('result');
                });
            },
            onChange: function() {
                // console.log(this.currentAward);
                this.batchNumber=this.awards[this.currentAward].count;
                // localStorage.setItem('batchNumber', this.awards[this.currentAward].count);
            },
            toggle: function() {
                if (this.running) {
                    this.stop();
                } else {
                    this.start();
                }
            },
            getSpeed: function() {
                return [0.1 * Math.random() + 0.01, -(0.1 * Math.random() + 0.01)];
            },
            start: function() {
                this.running = true;
                TagCanvas.SetSpeed('myCanvas', [5, 1]);
            },
            stop: function() {
                this.running = false;
                TagCanvas.SetSpeed('myCanvas', this.getSpeed());
                var total = this.awards[this.currentAward].count;//当前奖项奖品数量
                this.result[this.currentAward] =this.result[this.currentAward] || [];
                var todo = total - this.result[this.currentAward].length;
                var batchPlayers = [];
                for (var i = 0, ln = Math.min(this.batchNumber,todo, this.players.length); i < ln; i++) {
                    var index = this.getRandomInt(0, this.players.length - 1);
                    //splice 0代表添加 其余为删除
                    batchPlayers.push(this.players.splice(index, 1)[0]);
                }
                this.batchPlayers = batchPlayers;
                console.log(JSON.stringify(this.batchPlayers));
                this.result.splice(
                    this.currentAward,
                    1,
                    this.result[this.currentAward].concat(batchPlayers)
                );
                /*if(this.currentAward===0){
                    openbatchresult();
                }*/
                localStorage.setItem('players', JSON.stringify(this.players));
                localStorage.setItem('result', JSON.stringify(this.result));
                console.log("result"+JSON.stringify(this.result[this.currentAward]));
                TagCanvas.Reload('myCanvas');
                $.ajax({
                    async: false,
                    type: "post",
                    url: "lottery-data",
                    data:{
                        lottery_result:JSON.stringify(this.batchPlayers),
                        prizelevel:JSON.stringify(this.awards[this.currentAward].name),
                        prize:JSON.stringify(this.awards[this.currentAward].award)
                    },
                    error:function(XMLHttpRequest, textStatus, errorThrown){
                        console.log("上传失败");
                        // 状态码
                        console.log(XMLHttpRequest.status);
                        // 错误信息
                        console.log(textStatus);
                    },
                    success : function(data) {
                        console.log("上传成功");
                    }
                });

            },
            onNext: function() {
                this.batchPlayers = [];
                if (this.currentAward >= 0) {
                    this.currentAward -= 1;
                    this.batchNumber=this.awards[this.currentAward].count;
                }
                // this.onReplay();
            },
            getRandomInt: function(min, max) {
                min = Math.ceil(min);
                max = Math.floor(max);
                return Math.floor(Math.random() * (max - min + 1)) + min;
            },
            init: function() {
                try {
                    TagCanvas.Start('myCanvas', 'tags', {
                        textColour: "#ffffff",
                        dragControl: 1,
                        decel: 0.95,
                        textHeight: 14,
                        minSpeed: 0.01,
                        initial: [
                            0.1 * Math.random() + 0.01,
                            -(0.1 * Math.random() + 0.01),
                        ],
                    });
                } catch (e) {
                    // something went wrong, hide the canvas container
                    document.getElementById('myCanvasContainer').style.display =
                        'none';
                }
            },
            onReplay: function() {
                var vm = this;
                vm.batchPlayers = [];
                var p = vm.result.splice(vm.currentAward, 1, []);
                vm.players = vm.players.concat(p[0]);
                localStorage.setItem('players', JSON.stringify(vm.players))
                localStorage.setItem('result', JSON.stringify(vm.result));
            },
            onKeyup: function(e) {
                // 空格或回车键
                if (e.keyCode === 13 || e.keyCode === 32) {
                    this.$refs.action.$el.click();
                }
            },
            copy: function(obj) {
                return JSON.parse(JSON.stringify(obj));
            },
            onKick: function(player) {
                var vm = this;
                var index = vm.result[vm.currentAward].indexOf(player);
                this.$confirm('去掉后可继续抽一名', '去掉这名中奖者吗？', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                }).then(function() {
                    if (vm.batchPlayers.indexOf(player) > -1) {
                        vm.batchPlayers.splice(vm.batchPlayers.indexOf(player), 1);
                    }
                    vm.result[vm.currentAward].splice(index, 1);
                    localStorage.setItem('result', JSON.stringify(vm.result));
                });
            },
        },
        created: function() {
            this.members = JSON.parse(localStorage.getItem('members')) || [];
            if (this.members.length === 0) {
                location.href = 'upload';
            }
            this.awards = JSON.parse(localStorage.getItem('awards')) || [];
            if (this.awards.length === 0) {
                opensetting();
            }
            var result = JSON.parse(localStorage.getItem('result')) || [];
            for (var i = 0; i < this.awards.length; i++) {
                result[i] = result[i] || [];
            }
            this.result = result;
            this.choosed = JSON.parse(localStorage.getItem('choosed')) || {};
            var awards = JSON.parse(localStorage.getItem('awards')) || [];
        },
        mounted: function() {
            var members = JSON.parse(localStorage.getItem('members'));
            this.players = JSON.parse(localStorage.getItem('players')) || members;
            this.members = this.copy(members);
            localStorage.setItem('players', JSON.stringify(this.players));
            var canvas = this.$refs.canvas;
            canvas.width = document.body.offsetWidth;
            canvas.height = document.body.offsetHeight;
            this.$nextTick(function() {
                this.init();
            });
            document.body.addEventListener('keyup', this.onKeyup)
        },
    });
    // 设置
    function opensetting(){
        $('#setting').modal('show')
    }
    function openbatchresult(){
        $('#batchresult').modal('show')
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
                // console.log(value);
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
                    count: 60,
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
