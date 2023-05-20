var teacher_manage_tool = null; 
$(function () { 
	initTeacherManageTool(); //建立Teacher管理对象
	teacher_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#teacher_manage").datagrid({
		url : 'Teacher/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "teacherNo",
		sortOrder : "desc",
		toolbar : "#teacher_manage_tool",
		columns : [[
			{
				field : "teacherNo",
				title : "教师工号",
				width : 140,
			},
			{
				field : "classObj",
				title : "所在班级",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "gender",
				title : "性别",
				width : 140,
			},
			{
				field : "birthDate",
				title : "出生日期",
				width : 140,
			},
			{
				field : "teacherPhoto",
				title : "教师照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#teacherEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#teacherEditForm").form("validate")) {
					//验证表单 
					if(!$("#teacherEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#teacherEditForm").form({
						    url:"Teacher/" + $("#teacher_teacherNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#teacherEditForm").form("validate"))  {
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
			                        $("#teacherEditDiv").dialog("close");
			                        teacher_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#teacherEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#teacherEditDiv").dialog("close");
				$("#teacherEditForm").form("reset"); 
			},
		}],
	});
});

function initTeacherManageTool() {
	teacher_manage_tool = {
		init: function() {
			$.ajax({
				url : "ClassInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#classObj_classNo_query").combobox({ 
					    valueField:"classNo",
					    textField:"className",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{classNo:"",className:"不限制"});
					$("#classObj_classNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#teacher_manage").datagrid("reload");
		},
		redo : function () {
			$("#teacher_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#teacher_manage").datagrid("options").queryParams;
			queryParams["teacherNo"] = $("#teacherNo").val();
			queryParams["classObj.classNo"] = $("#classObj_classNo_query").combobox("getValue");
			queryParams["name"] = $("#name").val();
			queryParams["birthDate"] = $("#birthDate").datebox("getValue"); 
			queryParams["telephone"] = $("#telephone").val();
			$("#teacher_manage").datagrid("options").queryParams=queryParams; 
			$("#teacher_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#teacherQueryForm").form({
			    url:"Teacher/OutToExcel",
			});
			//提交表单
			$("#teacherQueryForm").submit();
		},
		remove : function () {
			var rows = $("#teacher_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var teacherNos = [];
						for (var i = 0; i < rows.length; i ++) {
							teacherNos.push(rows[i].teacherNo);
						}
						$.ajax({
							type : "POST",
							url : "Teacher/deletes",
							data : {
								teacherNos : teacherNos.join(","),
							},
							beforeSend : function () {
								$("#teacher_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#teacher_manage").datagrid("loaded");
									$("#teacher_manage").datagrid("load");
									$("#teacher_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#teacher_manage").datagrid("loaded");
									$("#teacher_manage").datagrid("load");
									$("#teacher_manage").datagrid("unselectAll");
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
			var rows = $("#teacher_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Teacher/" + rows[0].teacherNo +  "/update",
					type : "get",
					data : {
						//teacherNo : rows[0].teacherNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (teacher, response, status) {
						$.messager.progress("close");
						if (teacher) { 
							$("#teacherEditDiv").dialog("open");
							$("#teacher_teacherNo_edit").val(teacher.teacherNo);
							$("#teacher_teacherNo_edit").validatebox({
								required : true,
								missingMessage : "请输入教师工号",
								editable: false
							});
							$("#teacher_password_edit").val(teacher.password);
							$("#teacher_password_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#teacher_classObj_classNo_edit").combobox({
								url:"ClassInfo/listAll",
							    valueField:"classNo",
							    textField:"className",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#teacher_classObj_classNo_edit").combobox("select", teacher.classObjPri);
									//var data = $("#teacher_classObj_classNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#teacher_classObj_classNo_edit").combobox("select", data[0].classNo);
						            //}
								}
							});
							$("#teacher_name_edit").val(teacher.name);
							$("#teacher_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#teacher_gender_edit").val(teacher.gender);
							$("#teacher_gender_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#teacher_birthDate_edit").datebox({
								value: teacher.birthDate,
							    required: true,
							    showSeconds: true,
							});
							$("#teacher_teacherPhoto").val(teacher.teacherPhoto);
							$("#teacher_teacherPhotoImg").attr("src", teacher.teacherPhoto);
							$("#teacher_telephone_edit").val(teacher.telephone);
							$("#teacher_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							teacher_teacherDesc_editor.setContent(teacher.teacherDesc, false);
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
