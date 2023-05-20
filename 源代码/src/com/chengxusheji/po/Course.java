package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Course {
    /*课程编号*/
    @NotEmpty(message="课程编号不能为空")
    private String courseNo;
    public String getCourseNo(){
        return courseNo;
    }
    public void setCourseNo(String courseNo){
        this.courseNo = courseNo;
    }

    /*课程名称*/
    @NotEmpty(message="课程名称不能为空")
    private String courseName;
    public String getCourseName() {
        return courseName;
    }
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    /*课程照片*/
    private String coursePhoto;
    public String getCoursePhoto() {
        return coursePhoto;
    }
    public void setCoursePhoto(String coursePhoto) {
        this.coursePhoto = coursePhoto;
    }

    /*课程大纲*/
    @NotEmpty(message="课程大纲不能为空")
    private String dagang;
    public String getDagang() {
        return dagang;
    }
    public void setDagang(String dagang) {
        this.dagang = dagang;
    }

    /*总课时*/
    @NotNull(message="必须输入总课时")
    private Integer courseHours;
    public Integer getCourseHours() {
        return courseHours;
    }
    public void setCourseHours(Integer courseHours) {
        this.courseHours = courseHours;
    }

    /*课程学分*/
    @NotNull(message="必须输入课程学分")
    private Float courseScore;
    public Float getCourseScore() {
        return courseScore;
    }
    public void setCourseScore(Float courseScore) {
        this.courseScore = courseScore;
    }

    /*上课老师*/
    private Teacher teacherObj;
    public Teacher getTeacherObj() {
        return teacherObj;
    }
    public void setTeacherObj(Teacher teacherObj) {
        this.teacherObj = teacherObj;
    }

    /*上课班级*/
    private ClassInfo classObj;
    public ClassInfo getClassObj() {
        return classObj;
    }
    public void setClassObj(ClassInfo classObj) {
        this.classObj = classObj;
    }

    /*课程备注*/
    private String courseMemo;
    public String getCourseMemo() {
        return courseMemo;
    }
    public void setCourseMemo(String courseMemo) {
        this.courseMemo = courseMemo;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCourse=new JSONObject(); 
		jsonCourse.accumulate("courseNo", this.getCourseNo());
		jsonCourse.accumulate("courseName", this.getCourseName());
		jsonCourse.accumulate("coursePhoto", this.getCoursePhoto());
		jsonCourse.accumulate("dagang", this.getDagang());
		jsonCourse.accumulate("courseHours", this.getCourseHours());
		jsonCourse.accumulate("courseScore", this.getCourseScore());
		jsonCourse.accumulate("teacherObj", this.getTeacherObj().getName());
		jsonCourse.accumulate("teacherObjPri", this.getTeacherObj().getTeacherNo());
		jsonCourse.accumulate("classObj", this.getClassObj().getClassName());
		jsonCourse.accumulate("classObjPri", this.getClassObj().getClassNo());
		jsonCourse.accumulate("courseMemo", this.getCourseMemo());
		jsonCourse.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonCourse;
    }}