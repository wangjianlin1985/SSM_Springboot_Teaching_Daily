<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/course.css" /> 

<div id="course_manage"></div>
<div id="course_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="course_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="course_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="course_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="course_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="course_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="courseQueryForm" method="post">
			课程编号：<input type="text" class="textbox" id="courseNo" name="courseNo" style="width:110px" />
			课程名称：<input type="text" class="textbox" id="courseName" name="courseName" style="width:110px" />
			上课老师：<input class="textbox" type="text" id="teacherObj_teacherNo_query" name="teacherObj.teacherNo" style="width: auto"/>
			上课班级：<input class="textbox" type="text" id="classObj_classNo_query" name="classObj.classNo" style="width: auto"/>
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="course_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="courseEditDiv">
	<form id="courseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseNo_edit" name="course.courseNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">课程名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseName_edit" name="course.courseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程照片:</span>
			<span class="inputControl">
				<img id="course_coursePhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="course_coursePhoto" name="course.coursePhoto"/>
				<input id="coursePhotoFile" name="coursePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">课程大纲:</span>
			<span class="inputControl">
				<script name="course.dagang" id="course_dagang_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">总课时:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseHours_edit" name="course.courseHours" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">课程学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseScore_edit" name="course.courseScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">上课老师:</span>
			<span class="inputControl">
				<input class="textbox"  id="course_teacherObj_teacherNo_edit" name="course.teacherObj.teacherNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">上课班级:</span>
			<span class="inputControl">
				<input class="textbox"  id="course_classObj_classNo_edit" name="course.classObj.classNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程备注:</span>
			<span class="inputControl">
				<textarea id="course_courseMemo_edit" name="course.courseMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_addTime_edit" name="course.addTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var course_dagang_editor = UE.getEditor('course_dagang_edit'); //课程大纲编辑器
</script>
<script type="text/javascript" src="Course/js/course_manage.js"></script> 
