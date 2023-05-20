<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Teach" %>
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Teach> teachList = (List<Teach>)request.getAttribute("teachList");
    //获取所有的courseObj信息
    List<Course> courseList = (List<Course>)request.getAttribute("courseList");
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Course courseObj = (Course)request.getAttribute("courseObj");
    Teacher teacherObj = (Teacher)request.getAttribute("teacherObj");
    String weekDay = (String)request.getAttribute("weekDay"); //上课时间查询关键字
    String classRoom = (String)request.getAttribute("classRoom"); //上课教室查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>教学日历查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#teachListPanel" aria-controls="teachListPanel" role="tab" data-toggle="tab">教学日历列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Teach/teach_frontAdd.jsp" style="display:none;">添加教学日历</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="teachListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录id</td><td>课程名称</td><td>上课老师</td><td>上课时间</td><td>上课节次</td><td>上课教室</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<teachList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Teach teach = teachList.get(i); //获取到教学日历对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=teach.getTeachId() %></td>
 											<td><%=teach.getCourseObj().getCourseName() %></td>
 											<td><%=teach.getTeacherObj().getName() %></td>
 											<td><%=teach.getWeekDay() %></td>
 											<td><%=teach.getSectionNum() %></td>
 											<td><%=teach.getClassRoom() %></td>
 											<td>
 												<a href="<%=basePath  %>Teach/<%=teach.getTeachId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="teachEdit('<%=teach.getTeachId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="teachDelete('<%=teach.getTeachId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>教学日历查询</h1>
		</div>
		<form name="teachQueryForm" id="teachQueryForm" action="<%=basePath %>Teach/stuFrontlist" class="mar_t15" method="post">
            <div class="form-group" style="display:none;">
            	<label for="courseObj_courseNo">课程名称：</label>
                <select id="courseObj_courseNo" name="courseObj.courseNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Course courseTemp:courseList) {
	 					String selected = "";
 					if(courseObj!=null && courseObj.getCourseNo()!=null && courseObj.getCourseNo().equals(courseTemp.getCourseNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=courseTemp.getCourseNo() %>" <%=selected %>><%=courseTemp.getCourseName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="teacherObj_teacherNo">上课老师：</label>
                <select id="teacherObj_teacherNo" name="teacherObj.teacherNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Teacher teacherTemp:teacherList) {
	 					String selected = "";
 					if(teacherObj!=null && teacherObj.getTeacherNo()!=null && teacherObj.getTeacherNo().equals(teacherTemp.getTeacherNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=teacherTemp.getTeacherNo() %>" <%=selected %>><%=teacherTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="weekDay">上课时间:</label>
				<input type="text" id="weekDay" name="weekDay" value="<%=weekDay %>" class="form-control" placeholder="请输入上课时间">
			</div>






			<div class="form-group">
				<label for="classRoom">上课教室:</label>
				<input type="text" id="classRoom" name="classRoom" value="<%=classRoom %>" class="form-control" placeholder="请输入上课教室">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="teachEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;教学日历信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="teachEditForm" id="teachEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="teach_teachId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="teach_teachId_edit" name="teach.teachId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="teach_courseObj_courseNo_edit" class="col-md-3 text-right">课程名称:</label>
		  	 <div class="col-md-9">
			    <select id="teach_courseObj_courseNo_edit" name="teach.courseObj.courseNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teach_teacherObj_teacherNo_edit" class="col-md-3 text-right">上课老师:</label>
		  	 <div class="col-md-9">
			    <select id="teach_teacherObj_teacherNo_edit" name="teach.teacherObj.teacherNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teach_weekDay_edit" class="col-md-3 text-right">上课时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teach_weekDay_edit" name="teach.weekDay" class="form-control" placeholder="请输入上课时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teach_sectionNum_edit" class="col-md-3 text-right">上课节次:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teach_sectionNum_edit" name="teach.sectionNum" class="form-control" placeholder="请输入上课节次">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teach_classRoom_edit" class="col-md-3 text-right">上课教室:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teach_classRoom_edit" name="teach.classRoom" class="form-control" placeholder="请输入上课教室">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teach_teachMemo_edit" class="col-md-3 text-right">日历备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="teach_teachMemo_edit" name="teach.teachMemo" rows="8" class="form-control" placeholder="请输入日历备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#teachEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxTeachModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.teachQueryForm.currentPage.value = currentPage;
    document.teachQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.teachQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.teachQueryForm.currentPage.value = pageValue;
    documentteachQueryForm.submit();
}

/*弹出修改教学日历界面并初始化数据*/
function teachEdit(teachId) {
	$.ajax({
		url :  basePath + "Teach/" + teachId + "/update",
		type : "get",
		dataType: "json",
		success : function (teach, response, status) {
			if (teach) {
				$("#teach_teachId_edit").val(teach.teachId);
				$.ajax({
					url: basePath + "Course/listAll",
					type: "get",
					success: function(courses,response,status) { 
						$("#teach_courseObj_courseNo_edit").empty();
						var html="";
		        		$(courses).each(function(i,course){
		        			html += "<option value='" + course.courseNo + "'>" + course.courseName + "</option>";
		        		});
		        		$("#teach_courseObj_courseNo_edit").html(html);
		        		$("#teach_courseObj_courseNo_edit").val(teach.courseObjPri);
					}
				});
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#teach_teacherObj_teacherNo_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.teacherNo + "'>" + teacher.name + "</option>";
		        		});
		        		$("#teach_teacherObj_teacherNo_edit").html(html);
		        		$("#teach_teacherObj_teacherNo_edit").val(teach.teacherObjPri);
					}
				});
				$("#teach_weekDay_edit").val(teach.weekDay);
				$("#teach_sectionNum_edit").val(teach.sectionNum);
				$("#teach_classRoom_edit").val(teach.classRoom);
				$("#teach_teachMemo_edit").val(teach.teachMemo);
				$('#teachEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除教学日历信息*/
function teachDelete(teachId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Teach/deletes",
			data : {
				teachIds : teachId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#teachQueryForm").submit();
					//location.href= basePath + "Teach/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交教学日历信息表单给服务器端修改*/
function ajaxTeachModify() {
	$.ajax({
		url :  basePath + "Teach/" + $("#teach_teachId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#teachEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#teachQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

})
</script>
</body>
</html>

