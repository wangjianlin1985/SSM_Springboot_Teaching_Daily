package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Teacher;
import com.chengxusheji.po.Task;

import com.chengxusheji.mapper.TaskMapper;
@Service
public class TaskService {

	@Resource TaskMapper taskMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加教师任务记录*/
    public void addTask(Task task) throws Exception {
    	taskMapper.addTask(task);
    }

    /*按照查询条件分页查询教师任务记录*/
    public ArrayList<Task> queryTask(String title,String pubTime,Teacher teacherObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_task.title like '%" + title + "%'";
    	if(!pubTime.equals("")) where = where + " and t_task.pubTime like '%" + pubTime + "%'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null  && !teacherObj.getTeacherNo().equals(""))  where += " and t_task.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return taskMapper.queryTask(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Task> queryTask(String title,String pubTime,Teacher teacherObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_task.title like '%" + title + "%'";
    	if(!pubTime.equals("")) where = where + " and t_task.pubTime like '%" + pubTime + "%'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null && !teacherObj.getTeacherNo().equals(""))  where += " and t_task.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	return taskMapper.queryTaskList(where);
    }

    /*查询所有教师任务记录*/
    public ArrayList<Task> queryAllTask()  throws Exception {
        return taskMapper.queryTaskList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,String pubTime,Teacher teacherObj) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_task.title like '%" + title + "%'";
    	if(!pubTime.equals("")) where = where + " and t_task.pubTime like '%" + pubTime + "%'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null && !teacherObj.getTeacherNo().equals(""))  where += " and t_task.teacherObj='" + teacherObj.getTeacherNo() + "'";
        recordNumber = taskMapper.queryTaskCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取教师任务记录*/
    public Task getTask(int taskId) throws Exception  {
        Task task = taskMapper.getTask(taskId);
        return task;
    }

    /*更新教师任务记录*/
    public void updateTask(Task task) throws Exception {
        taskMapper.updateTask(task);
    }

    /*删除一条教师任务记录*/
    public void deleteTask (int taskId) throws Exception {
        taskMapper.deleteTask(taskId);
    }

    /*删除多条教师任务信息*/
    public int deleteTasks (String taskIds) throws Exception {
    	String _taskIds[] = taskIds.split(",");
    	for(String _taskId: _taskIds) {
    		taskMapper.deleteTask(Integer.parseInt(_taskId));
    	}
    	return _taskIds.length;
    }
}
