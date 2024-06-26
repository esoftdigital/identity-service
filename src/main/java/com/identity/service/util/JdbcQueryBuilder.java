package com.identity.service.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class JdbcQueryBuilder {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public List<Map<String, Object>> getJdbcQueryBuilder(List<Map<String, Object>> result, Object[] inPut, String sql,
			String refCusror) {
		jdbcTemplate.query(sql, new RowMapper<Boolean>() {
			@Override
			public Boolean mapRow(ResultSet rs, int rowNum) throws SQLException {
				rs = (ResultSet) rs.getObject(refCusror);
				while (rs.next()) {
					Map<String, Object> resMap = new HashMap<>();
					for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
						resMap.put(rs.getMetaData().getColumnName(i), rs.getObject(i));
					}
					result.add(resMap);

				}
				return true;
			}
		}, inPut);

		return result;
	}

	public Map<String, String> getJdbcQueryBuilderWithMap(Map<String, String> result, Object[] inPut, String sql,
			String refCusror) {
		Map<String, String> resMap = new HashMap<>();
		jdbcTemplate.query(sql, new RowMapper<Boolean>() {
			@Override
			public Boolean mapRow(ResultSet rs, int rowNum) throws SQLException {
				rs = (ResultSet) rs.getObject(refCusror);
				
				while (rs.next()) {
					
					for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
						resMap.put(rs.getMetaData().getColumnName(i), rs.getObject(i).toString());
					}
				}
				return true;
			}
		}, inPut);

		return resMap;
	}

}
