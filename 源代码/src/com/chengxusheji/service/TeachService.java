package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Course;
import com.chengxusheji.po.Teacher;
import com.chengxusheji.po.Teach;

import com.chengxusheji.mapper.TeachMapper;
@Service
public class TeachService {

	@Resource TeachMapper teachMapper;
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

    /*添加教学日历记录*/
    public void addTeach(Teach teach) throws Exception {
    	teachMapper.addTeach(teach);
    }

    /*按照查询条件分页查询教学日历记录*/
    public ArrayList<Teach> queryTeach(Course courseObj,Teacher teacherObj,String weekDay,String classRoom,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != courseObj &&  courseObj.getCourseNo() != null  && !courseObj.getCourseNo().equals(""))  where += " and t_teach.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null  && !teacherObj.getTeacherNo().equals(""))  where += " and t_teach.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	if(!weekDay.equals("")) where = where + " and t_teach.weekDay like '%" + weekDay + "%'";
    	if(!classRoom.equals("")) where = where + " and t_teach.classRoom like '%" + classRoom + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return teachMapper.queryTeach(where, startIndex, this.rows);
    }
    
    /*按照查询条件分页查询教学日历记录*/
    public ArrayList<Teach> queryTeach(String classNo,Teacher teacherObj,String weekDay,String classRoom,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != classNo &&  !classNo.equals(""))  where += " and t_course.classObj='" + classNo + "'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null  && !teacherObj.getTeacherNo().equals(""))  where += " and t_teach.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	if(!weekDay.equals("")) where = where + " and t_teach.weekDay like '%" + weekDay + "%'";
    	if(!classRoom.equals("")) where = where + " and t_teach.classRoom like '%" + classRoom + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return teachMapper.queryTeach(where, startIndex, this.rows);
    }
    

    /*按照查询条件查询所有记录*/
    public ArrayList<Teach> queryTeach(Course courseObj,Teacher teacherObj,String weekDay,String classRoom) throws Exception  { 
     	String where = "where 1=1";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_teach.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null && !teacherObj.getTeacherNo().equals(""))  where += " and t_teach.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	if(!weekDay.equals("")) where = where + " and t_teach.weekDay like '%" + weekDay + "%'";
    	if(!classRoom.equals("")) where = where + " and t_teach.classRoom like '%" + classRoom + "%'";
    	return teachMapper.queryTeachList(where);
    }

    /*查询所有教学日历记录*/
    public ArrayList<Teach> queryAllTeach()  throws Exception {
        return teachMapper.queryTeachList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Course courseObj,Teacher teacherObj,String weekDay,String classRoom) throws Exception {
     	String where = "where 1=1";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_teach.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null && !teacherObj.getTeacherNo().equals(""))  where += " and t_teach.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	if(!weekDay.equals("")) where = where + " and t_teach.weekDay like '%" + weekDay + "%'";
    	if(!classRoom.equals("")) where = where + " and t_teach.classRoom like '%" + classRoom + "%'";
        recordNumber = teachMapper.queryTeachCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    
    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String classNo,Teacher teacherObj,String weekDay,String classRoom) throws Exception {
     	String where = "where 1=1";
    	if(null != classNo && !classNo.equals(""))  where += " and t_course.classObj='" + classNo + "'";
    	if(null != teacherObj &&  teacherObj.getTeacherNo() != null && !teacherObj.getTeacherNo().equals(""))  where += " and t_teach.teacherObj='" + teacherObj.getTeacherNo() + "'";
    	if(!weekDay.equals("")) where = where + " and t_teach.weekDay like '%" + weekDay + "%'";
    	if(!classRoom.equals("")) where = where + " and t_teach.classRoom like '%" + classRoom + "%'";
        recordNumber = teachMapper.queryTeachCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }


    /*根据主键获取教学日历记录*/
    public Teach getTeach(int teachId) throws Exception  {
        Teach teach = teachMapper.getTeach(teachId);
        return teach;
    }

    /*更新教学日历记录*/
    public void updateTeach(Teach teach) throws Exception {
        teachMapper.updateTeach(teach);
    }

    /*删除一条教学日历记录*/
    public void deleteTeach (int teachId) throws Exception {
        teachMapper.deleteTeach(teachId);
    }

    /*删除多条教学日历信息*/
    public int deleteTeachs (String teachIds) throws Exception {
    	String _teachIds[] = teachIds.split(",");
    	for(String _teachId: _teachIds) {
    		teachMapper.deleteTeach(Integer.parseInt(_teachId));
    	}
    	return _teachIds.length;
    }
}
