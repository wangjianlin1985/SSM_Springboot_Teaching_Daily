var teach_manage_tool = null; 
$(function () { 
	initTeachManageTool(); //建立Teach管理对象
	teach_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#teach_manage").datagrid({
		url : 'Teach/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "teachId",
		sortOrder : "desc",
		toolbar : "#teach_manage_tool",
		columns : [[
			{
				field : "teachId",
				title : "记录id",
				width : 70,
			},
			{
				field : "courseObj",
				title : "课程名称",
				width : 140,
			},
			{
				field : "teacherObj",
				title : "上课老师",
				width : 140,
			},
			{
				field : "weekDay",
				title : "上课时间",
				width : 140,
			},
			{
				field : "sectionNum",
				title : "上课节次",
				width : 140,
			},
			{
				field : "classRoom",
				title : "上课教室",
				width : 140,
			},
		]],
	});

	$("#teachEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#teachEditForm").form("validate")) {
					//验证表单 
					if(!$("#teachEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#teachEditForm").form({
						    url:"Teach/" + $("#teach_teachId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#teachEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#teachEditDiv").dialog("close");
			                        teach_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#teachEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#teachEditDiv").dialog("close");
				$("#teachEditForm").form("reset"); 
			},
		}],
	});
});

function initTeachManageTool() {
	teach_manage_tool = {
		init: function() {
			$.ajax({
				url : "Course/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#courseObj_courseNo_query").combobox({ 
					    valueField:"courseNo",
					    textField:"courseName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{courseNo:"",courseName:"不限制"});
					$("#courseObj_courseNo_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Teacher/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#teacherObj_teacherNo_query").combobox({ 
					    valueField:"teacherNo",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{teacherNo:"",name:"不限制"});
					$("#teacherObj_teacherNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#teach_manage").datagrid("reload");
		},
		redo : function () {
			$("#teach_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#teach_manage").datagrid("options").queryParams;
			queryParams["courseObj.courseNo"] = $("#courseObj_courseNo_query").combobox("getValue");
			queryParams["teacherObj.teacherNo"] = $("#teacherObj_teacherNo_query").combobox("getValue");
			queryParams["weekDay"] = $("#weekDay").val();
			queryParams["classRoom"] = $("#classRoom").val();
			$("#teach_manage").datagrid("options").queryParams=queryParams; 
			$("#teach_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#teachQueryForm").form({
			    url:"Teach/OutToExcel",
			});
			//提交表单
			$("#teachQueryForm").submit();
		},
		remove : function () {
			var rows = $("#teach_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var teachIds = [];
						for (var i = 0; i < rows.length; i ++) {
							teachIds.push(rows[i].teachId);
						}
						$.ajax({
							type : "POST",
							url : "Teach/deletes",
							data : {
								teachIds : teachIds.join(","),
							},
							beforeSend : function () {
								$("#teach_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#teach_manage").datagrid("loaded");
									$("#teach_manage").datagrid("load");
									$("#teach_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#teach_manage").datagrid("loaded");
									$("#teach_manage").datagrid("load");
									$("#teach_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#teach_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Teach/" + rows[0].teachId +  "/update",
					type : "get",
					data : {
						//teachId : rows[0].teachId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (teach, response, status) {
						$.messager.progress("close");
						if (teach) { 
							$("#teachEditDiv").dialog("open");
							$("#teach_teachId_edit").val(teach.teachId);
							$("#teach_teachId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#teach_courseObj_courseNo_edit").combobox({
								url:"Course/listAll",
							    valueField:"courseNo",
							    textField:"courseName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#teach_courseObj_courseNo_edit").combobox("select", teach.courseObjPri);
									//var data = $("#teach_courseObj_courseNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#teach_courseObj_courseNo_edit").combobox("select", data[0].courseNo);
						            //}
								}
							});
							$("#teach_teacherObj_teacherNo_edit").combobox({
								url:"Teacher/listAll",
							    valueField:"teacherNo",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#teach_teacherObj_teacherNo_edit").combobox("select", teach.teacherObjPri);
									//var data = $("#teach_teacherObj_teacherNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#teach_teacherObj_teacherNo_edit").combobox("select", data[0].teacherNo);
						            //}
								}
							});
							$("#teach_weekDay_edit").val(teach.weekDay);
							$("#teach_weekDay_edit").validatebox({
								required : true,
								missingMessage : "请输入上课时间",
							});
							$("#teach_sectionNum_edit").val(teach.sectionNum);
							$("#teach_sectionNum_edit").validatebox({
								required : true,
								missingMessage : "请输入上课节次",
							});
							$("#teach_classRoom_edit").val(teach.classRoom);
							$("#teach_classRoom_edit").validatebox({
								required : true,
								missingMessage : "请输入上课教室",
							});
							$("#teach_teachMemo_edit").val(teach.teachMemo);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
