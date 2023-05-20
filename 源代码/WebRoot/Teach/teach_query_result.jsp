<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teach.css" /> 

<div id="teach_manage"></div>
<div id="teach_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="teach_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="teach_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="teach_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="teach_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="teach_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="teachQueryForm" method="post">
			课程名称：<input class="textbox" type="text" id="courseObj_courseNo_query" name="courseObj.courseNo" style="width: auto"/>
			上课老师：<input class="textbox" type="text" id="teacherObj_teacherNo_query" name="teacherObj.teacherNo" style="width: auto"/>
			上课时间：<input type="text" class="textbox" id="weekDay" name="weekDay" style="width:110px" />
			上课教室：<input type="text" class="textbox" id="classRoom" name="classRoom" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="teach_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="teachEditDiv">
	<form id="teachEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teach_teachId_edit" name="teach.teachId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">课程名称:</span>
			<span class="inputControl">
				<input class="textbox"  id="teach_courseObj_courseNo_edit" name="teach.courseObj.courseNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">上课老师:</span>
			<span class="inputControl">
				<input class="textbox"  id="teach_teacherObj_teacherNo_edit" name="teach.teacherObj.teacherNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">上课时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teach_weekDay_edit" name="teach.weekDay" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上课节次:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teach_sectionNum_edit" name="teach.sectionNum" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上课教室:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teach_classRoom_edit" name="teach.classRoom" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">日历备注:</span>
			<span class="inputControl">
				<textarea id="teach_teachMemo_edit" name="teach.teachMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Teach/js/teach_manage.js"></script> 
