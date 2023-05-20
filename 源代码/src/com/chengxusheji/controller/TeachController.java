package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.service.TeachService;
import com.chengxusheji.po.Teach;
import com.chengxusheji.service.CourseService;
import com.chengxusheji.po.Course;
import com.chengxusheji.service.TeacherService;
import com.chengxusheji.po.Teacher;

//Teach管理控制层
@Controller
@RequestMapping("/Teach")
public class TeachController extends BaseController {

    /*业务层对象*/
    @Resource TeachService teachService;

    @Resource CourseService courseService;
    @Resource TeacherService teacherService;
    @Resource StudentService studentService;
    
	@InitBinder("courseObj")
	public void initBindercourseObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseObj.");
	}
	@InitBinder("teacherObj")
	public void initBinderteacherObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teacherObj.");
	}
	@InitBinder("teach")
	public void initBinderTeach(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teach.");
	}
	/*跳转到添加Teach视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Teach());
		/*查询所有的Course信息*/
		List<Course> courseList = courseService.queryAllCourse();
		request.setAttribute("courseList", courseList);
		/*查询所有的Teacher信息*/
		List<Teacher> teacherList = teacherService.queryAllTeacher();
		request.setAttribute("teacherList", teacherList);
		return "Teach_add";
	}

	/*客户端ajax方式提交添加教学日历信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Teach teach, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        teachService.addTeach(teach);
        message = "教学日历添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*客户端ajax方式提交添加教学日历信息*/
	@RequestMapping(value = "/teacherAdd", method = RequestMethod.POST)
	public void teacherAdd(Teach teach, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		
		Teacher teacher = new Teacher();
		teacher.setTeacherNo(session.getAttribute("username").toString());
		teach.setTeacherObj(teacher);
		 
        teachService.addTeach(teach);
        message = "教学日历添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询教学日历信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("teacherObj") Teacher teacherObj,String weekDay,String classRoom,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (weekDay == null) weekDay = "";
		if (classRoom == null) classRoom = "";
		if(rows != 0)teachService.setRows(rows);
		List<Teach> teachList = teachService.queryTeach(courseObj, teacherObj, weekDay, classRoom, page);
	    /*计算总的页数和总的记录数*/
	    teachService.queryTotalPageAndRecordNumber(courseObj, teacherObj, weekDay, classRoom);
	    /*获取到总的页码数目*/
	    int totalPage = teachService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = teachService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Teach teach:teachList) {
			JSONObject jsonTeach = teach.getJsonObject();
			jsonArray.put(jsonTeach);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	
	/*ajax方式按照查询条件分页查询教学日历信息*/
	@RequestMapping(value = { "/teacherlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void teacherlist(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("teacherObj") Teacher teacherObj,String weekDay,String classRoom,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if (weekDay == null) weekDay = "";
		if (classRoom == null) classRoom = "";
		if(rows != 0)teachService.setRows(rows);
		
		teacherObj = new Teacher();
		teacherObj.setTeacherNo(session.getAttribute("username").toString());
		
		
		List<Teach> teachList = teachService.queryTeach(courseObj, teacherObj, weekDay, classRoom, page);
	    /*计算总的页数和总的记录数*/
	    teachService.queryTotalPageAndRecordNumber(courseObj, teacherObj, weekDay, classRoom);
	    /*获取到总的页码数目*/
	    int totalPage = teachService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = teachService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Teach teach:teachList) {
			JSONObject jsonTeach = teach.getJsonObject();
			jsonArray.put(jsonTeach);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	

	/*ajax方式按照查询条件分页查询教学日历信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Teach> teachList = teachService.queryAllTeach();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Teach teach:teachList) {
			JSONObject jsonTeach = new JSONObject();
			jsonTeach.accumulate("teachId", teach.getTeachId());
			jsonArray.put(jsonTeach);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询教学日历信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("teacherObj") Teacher teacherObj,String weekDay,String classRoom,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (weekDay == null) weekDay = "";
		if (classRoom == null) classRoom = "";
		List<Teach> teachList = teachService.queryTeach(courseObj, teacherObj, weekDay, classRoom, currentPage);
	    /*计算总的页数和总的记录数*/
	    teachService.queryTotalPageAndRecordNumber(courseObj, teacherObj, weekDay, classRoom);
	    /*获取到总的页码数目*/
	    int totalPage = teachService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = teachService.getRecordNumber();
	    request.setAttribute("teachList",  teachList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("courseObj", courseObj);
	    request.setAttribute("teacherObj", teacherObj);
	    request.setAttribute("weekDay", weekDay);
	    request.setAttribute("classRoom", classRoom);
	    List<Course> courseList = courseService.queryAllCourse();
	    request.setAttribute("courseList", courseList);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "Teach/teach_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询教学日历信息*/
	@RequestMapping(value = { "/stuFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String stuFrontlist(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("teacherObj") Teacher teacherObj,String weekDay,String classRoom,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (weekDay == null) weekDay = "";
		if (classRoom == null) classRoom = "";
		
		String studentNo = session.getAttribute("user_name").toString();
		String classNo = studentService.getStudent(studentNo).getClassObj().getClassNo();
		
		List<Teach> teachList = teachService.queryTeach(classNo, teacherObj, weekDay, classRoom, currentPage);
	    /*计算总的页数和总的记录数*/
	    teachService.queryTotalPageAndRecordNumber(classNo, teacherObj, weekDay, classRoom);
	    /*获取到总的页码数目*/
	    int totalPage = teachService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = teachService.getRecordNumber();
	    request.setAttribute("teachList",  teachList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("courseObj", courseObj);
	    request.setAttribute("teacherObj", teacherObj);
	    request.setAttribute("weekDay", weekDay);
	    request.setAttribute("classRoom", classRoom);
	    List<Course> courseList = courseService.queryAllCourse();
	    request.setAttribute("courseList", courseList);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "Teach/teach_stuFrontquery_result"; 
	}
	

     /*前台查询Teach信息*/
	@RequestMapping(value="/{teachId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer teachId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键teachId获取Teach对象*/
        Teach teach = teachService.getTeach(teachId);

        List<Course> courseList = courseService.queryAllCourse();
        request.setAttribute("courseList", courseList);
        List<Teacher> teacherList = teacherService.queryAllTeacher();
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("teach",  teach);
        return "Teach/teach_frontshow";
	}

	/*ajax方式显示教学日历修改jsp视图页*/
	@RequestMapping(value="/{teachId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer teachId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键teachId获取Teach对象*/
        Teach teach = teachService.getTeach(teachId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonTeach = teach.getJsonObject();
		out.println(jsonTeach.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新教学日历信息*/
	@RequestMapping(value = "/{teachId}/update", method = RequestMethod.POST)
	public void update(@Validated Teach teach, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			teachService.updateTeach(teach);
			message = "教学日历更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "教学日历更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除教学日历信息*/
	@RequestMapping(value="/{teachId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer teachId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  teachService.deleteTeach(teachId);
	            request.setAttribute("message", "教学日历删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "教学日历删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条教学日历记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String teachIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = teachService.deleteTeachs(teachIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出教学日历信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("teacherObj") Teacher teacherObj,String weekDay,String classRoom, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(weekDay == null) weekDay = "";
        if(classRoom == null) classRoom = "";
        List<Teach> teachList = teachService.queryTeach(courseObj,teacherObj,weekDay,classRoom);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Teach信息记录"; 
        String[] headers = { "记录id","课程名称","上课老师","上课时间","上课节次","上课教室"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<teachList.size();i++) {
        	Teach teach = teachList.get(i); 
        	dataset.add(new String[]{teach.getTeachId() + "",teach.getCourseObj().getCourseName(),teach.getTeacherObj().getName(),teach.getWeekDay(),teach.getSectionNum(),teach.getClassRoom()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Teach.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
