package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Teach {
    /*记录id*/
    private Integer teachId;
    public Integer getTeachId(){
        return teachId;
    }
    public void setTeachId(Integer teachId){
        this.teachId = teachId;
    }

    /*课程名称*/
    private Course courseObj;
    public Course getCourseObj() {
        return courseObj;
    }
    public void setCourseObj(Course courseObj) {
        this.courseObj = courseObj;
    }

    /*上课老师*/
    private Teacher teacherObj;
    public Teacher getTeacherObj() {
        return teacherObj;
    }
    public void setTeacherObj(Teacher teacherObj) {
        this.teacherObj = teacherObj;
    }

    /*上课时间*/
    @NotEmpty(message="上课时间不能为空")
    private String weekDay;
    public String getWeekDay() {
        return weekDay;
    }
    public void setWeekDay(String weekDay) {
        this.weekDay = weekDay;
    }

    /*上课节次*/
    @NotEmpty(message="上课节次不能为空")
    private String sectionNum;
    public String getSectionNum() {
        return sectionNum;
    }
    public void setSectionNum(String sectionNum) {
        this.sectionNum = sectionNum;
    }

    /*上课教室*/
    @NotEmpty(message="上课教室不能为空")
    private String classRoom;
    public String getClassRoom() {
        return classRoom;
    }
    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }

    /*日历备注*/
    private String teachMemo;
    public String getTeachMemo() {
        return teachMemo;
    }
    public void setTeachMemo(String teachMemo) {
        this.teachMemo = teachMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTeach=new JSONObject(); 
		jsonTeach.accumulate("teachId", this.getTeachId());
		jsonTeach.accumulate("courseObj", this.getCourseObj().getCourseName());
		jsonTeach.accumulate("courseObjPri", this.getCourseObj().getCourseNo());
		jsonTeach.accumulate("teacherObj", this.getTeacherObj().getName());
		jsonTeach.accumulate("teacherObjPri", this.getTeacherObj().getTeacherNo());
		jsonTeach.accumulate("weekDay", this.getWeekDay());
		jsonTeach.accumulate("sectionNum", this.getSectionNum());
		jsonTeach.accumulate("classRoom", this.getClassRoom());
		jsonTeach.accumulate("teachMemo", this.getTeachMemo());
		return jsonTeach;
    }}