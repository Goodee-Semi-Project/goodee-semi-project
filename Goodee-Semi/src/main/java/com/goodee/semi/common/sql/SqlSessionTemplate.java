package com.goodee.semi.common.sql;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionTemplate {
	public static SqlSession getSqlSession(boolean autoCommit) {
		SqlSession session = null;
		
		try {
			String path = "./mybatis-config.xml";
			InputStream inputStream = Resources.getResourceAsStream(path);
			
			SqlSessionFactoryBuilder sfb = new SqlSessionFactoryBuilder();
			SqlSessionFactory factory = sfb.build(inputStream);
			
			session = factory.openSession(autoCommit);
		} catch (IOException e) { e.printStackTrace(); }
		
		return session;
	}
}