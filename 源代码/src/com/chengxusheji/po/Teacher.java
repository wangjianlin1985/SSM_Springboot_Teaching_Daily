package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Teacher {
    /*教师工号*/
    @NotEmpty(message="教师工号不能为空")
    private String teacherNo;
    public String getTeacherNo(){
        return teacherNo;
    }
    public void setTeacherNo(String teacherNo){
        this.teacherNo = teacherNo;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*所在班级*/
    private ClassInfo classObj;
    public ClassInfo getClassObj() {
        return classObj;
    }
    public void setClassObj(ClassInfo classObj) {
        this.classObj = classObj;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*教师照片*/
    private String teacherPhoto;
    public String getTeacherPhoto() {
        return teacherPhoto;
    }
    public void setTeacherPhoto(String teacherPhoto) {
        this.teacherPhoto = teacherPhoto;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*教师介绍*/
    @NotEmpty(message="教师介绍不能为空")
    private String teacherDesc;
    public String getTeacherDesc() {
        return teacherDesc;
    }
    public void setTeacherDesc(String teacherDesc) {
        this.teacherDesc = teacherDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTeacher=new JSONObject(); 
		jsonTeacher.accumulate("teacherNo", this.getTeacherNo());
		jsonTeacher.accumulate("password", this.getPassword());
		jsonTeacher.accumulate("classObj", this.getClassObj().getClassName());
		jsonTeacher.accumulate("classObjPri", this.getClassObj().getClassNo());
		jsonTeacher.accumulate("name", this.getName());
		jsonTeacher.accumulate("gender", this.getGender());
		jsonTeacher.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonTeacher.accumulate("teacherPhoto", this.getTeacherPhoto());
		jsonTeacher.accumulate("telephone", this.getTelephone());
		jsonTeacher.accumulate("teacherDesc", this.getTeacherDesc());
		return jsonTeacher;
    }}