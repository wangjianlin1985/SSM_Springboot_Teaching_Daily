package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Task {
    /*任务id*/
    private Integer taskId;
    public Integer getTaskId(){
        return taskId;
    }
    public void setTaskId(Integer taskId){
        this.taskId = taskId;
    }

    /*任务标题*/
    @NotEmpty(message="任务标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*任务内容*/
    @NotEmpty(message="任务内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*工作量天数*/
    @NotNull(message="必须输入工作量天数")
    private Float workDays;
    public Float getWorkDays() {
        return workDays;
    }
    public void setWorkDays(Float workDays) {
        this.workDays = workDays;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String pubTime;
    public String getPubTime() {
        return pubTime;
    }
    public void setPubTime(String pubTime) {
        this.pubTime = pubTime;
    }

    /*接受任务老师*/
    private Teacher teacherObj;
    public Teacher getTeacherObj() {
        return teacherObj;
    }
    public void setTeacherObj(Teacher teacherObj) {
        this.teacherObj = teacherObj;
    }

    /*完成进度汇报*/
    @NotEmpty(message="完成进度汇报不能为空")
    private String finishDesc;
    public String getFinishDesc() {
        return finishDesc;
    }
    public void setFinishDesc(String finishDesc) {
        this.finishDesc = finishDesc;
    }

    /*任务备注*/
    private String taskMemo;
    public String getTaskMemo() {
        return taskMemo;
    }
    public void setTaskMemo(String taskMemo) {
        this.taskMemo = taskMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTask=new JSONObject(); 
		jsonTask.accumulate("taskId", this.getTaskId());
		jsonTask.accumulate("title", this.getTitle());
		jsonTask.accumulate("content", this.getContent());
		jsonTask.accumulate("workDays", this.getWorkDays());
		jsonTask.accumulate("pubTime", this.getPubTime().length()>19?this.getPubTime().substring(0,19):this.getPubTime());
		jsonTask.accumulate("teacherObj", this.getTeacherObj().getName());
		jsonTask.accumulate("teacherObjPri", this.getTeacherObj().getTeacherNo());
		jsonTask.accumulate("finishDesc", this.getFinishDesc());
		jsonTask.accumulate("taskMemo", this.getTaskMemo());
		return jsonTask;
    }}