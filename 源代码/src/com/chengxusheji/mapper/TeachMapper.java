package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Teach;

public interface TeachMapper {
	/*添加教学日历信息*/
	public void addTeach(Teach teach) throws Exception;

	/*按照查询条件分页查询教学日历记录*/
	public ArrayList<Teach> queryTeach(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有教学日历记录*/
	public ArrayList<Teach> queryTeachList(@Param("where") String where) throws Exception;

	/*按照查询条件的教学日历记录数*/
	public int queryTeachCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条教学日历记录*/
	public Teach getTeach(int teachId) throws Exception;

	/*更新教学日历记录*/
	public void updateTeach(Teach teach) throws Exception;

	/*删除教学日历记录*/
	public void deleteTeach(int teachId) throws Exception;

}
