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
import com.chengxusheji.service.TaskService;
import com.chengxusheji.po.Task;
import com.chengxusheji.service.TeacherService;
import com.chengxusheji.po.Teacher;

//Task管理控制层
@Controller
@RequestMapping("/Task")
public class TaskController extends BaseController {

    /*业务层对象*/
    @Resource TaskService taskService;

    @Resource TeacherService teacherService;
	@InitBinder("teacherObj")
	public void initBinderteacherObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teacherObj.");
	}
	@InitBinder("task")
	public void initBinderTask(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("task.");
	}
	/*跳转到添加Task视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Task());
		/*查询所有的Teacher信息*/
		List<Teacher> teacherList = teacherService.queryAllTeacher();
		request.setAttribute("teacherList", teacherList);
		return "Task_add";
	}

	/*客户端ajax方式提交添加教师任务信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Task task, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        taskService.addTask(task);
        message = "教师任务添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询教师任务信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String title,String pubTime,@ModelAttribute("teacherObj") Teacher teacherObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (pubTime == null) pubTime = "";
		if(rows != 0)taskService.setRows(rows);
		List<Task> taskList = taskService.queryTask(title, pubTime, teacherObj, page);
	    /*计算总的页数和总的记录数*/
	    taskService.queryTotalPageAndRecordNumber(title, pubTime, teacherObj);
	    /*获取到总的页码数目*/
	    int totalPage = taskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Task task:taskList) {
			JSONObject jsonTask = task.getJsonObject();
			jsonArray.put(jsonTask);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	
	/*ajax方式按照查询条件分页查询教师任务信息*/
	@RequestMapping(value = { "/teacherlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void teacherlist(String title,String pubTime,@ModelAttribute("teacherObj") Teacher teacherObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (pubTime == null) pubTime = "";
		if(rows != 0)taskService.setRows(rows);
		teacherObj = new Teacher();
		teacherObj.setTeacherNo(session.getAttribute("username").toString());
		
		List<Task> taskList = taskService.queryTask(title, pubTime, teacherObj, page);
	    /*计算总的页数和总的记录数*/
	    taskService.queryTotalPageAndRecordNumber(title, pubTime, teacherObj);
	    /*获取到总的页码数目*/
	    int totalPage = taskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Task task:taskList) {
			JSONObject jsonTask = task.getJsonObject();
			jsonArray.put(jsonTask);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	

	/*ajax方式按照查询条件分页查询教师任务信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Task> taskList = taskService.queryAllTask();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Task task:taskList) {
			JSONObject jsonTask = new JSONObject();
			jsonTask.accumulate("taskId", task.getTaskId());
			jsonTask.accumulate("title", task.getTitle());
			jsonArray.put(jsonTask);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询教师任务信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String title,String pubTime,@ModelAttribute("teacherObj") Teacher teacherObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (pubTime == null) pubTime = "";
		List<Task> taskList = taskService.queryTask(title, pubTime, teacherObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    taskService.queryTotalPageAndRecordNumber(title, pubTime, teacherObj);
	    /*获取到总的页码数目*/
	    int totalPage = taskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskService.getRecordNumber();
	    request.setAttribute("taskList",  taskList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("title", title);
	    request.setAttribute("pubTime", pubTime);
	    request.setAttribute("teacherObj", teacherObj);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "Task/task_frontquery_result"; 
	}

     /*前台查询Task信息*/
	@RequestMapping(value="/{taskId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer taskId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键taskId获取Task对象*/
        Task task = taskService.getTask(taskId);

        List<Teacher> teacherList = teacherService.queryAllTeacher();
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("task",  task);
        return "Task/task_frontshow";
	}

	/*ajax方式显示教师任务修改jsp视图页*/
	@RequestMapping(value="/{taskId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer taskId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键taskId获取Task对象*/
        Task task = taskService.getTask(taskId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonTask = task.getJsonObject();
		out.println(jsonTask.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新教师任务信息*/
	@RequestMapping(value = "/{taskId}/update", method = RequestMethod.POST)
	public void update(@Validated Task task, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			taskService.updateTask(task);
			message = "教师任务更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "教师任务更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除教师任务信息*/
	@RequestMapping(value="/{taskId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer taskId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  taskService.deleteTask(taskId);
	            request.setAttribute("message", "教师任务删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "教师任务删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条教师任务记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String taskIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = taskService.deleteTasks(taskIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出教师任务信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String title,String pubTime,@ModelAttribute("teacherObj") Teacher teacherObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(pubTime == null) pubTime = "";
        List<Task> taskList = taskService.queryTask(title,pubTime,teacherObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Task信息记录"; 
        String[] headers = { "任务id","任务标题","工作量天数","发布时间","接受任务老师"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<taskList.size();i++) {
        	Task task = taskList.get(i); 
        	dataset.add(new String[]{task.getTaskId() + "",task.getTitle(),task.getWorkDays() + "",task.getPubTime(),task.getTeacherObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Task.xls");//filename是下载的xls的名，建议最好用英文 
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
