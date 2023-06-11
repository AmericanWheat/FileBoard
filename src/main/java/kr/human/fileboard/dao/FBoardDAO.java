package kr.human.fileboard.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.fileboard.vo.FBoardVO;

public class FBoardDAO {
	private static FBoardDAO instance = new FBoardDAO();
	private FBoardDAO () {}
	public static FBoardDAO getInstance() {
		return instance;
	}

//	1. 전체 개수얻기 
	public int selectCount(SqlSession sqlSession) {
		return sqlSession.selectOne("fboard.selectCount");
	}
		
//	2. 1개얻기
	public FBoardVO selectByIdx(SqlSession sqlSession, int idx) {
		return sqlSession.selectOne("fboard.selectByIdx" , idx);
	}
	
//	3. 1페이지얻기
	public List<FBoardVO> selectList(SqlSession sqlSession, HashMap<String, Integer> map) {
		return sqlSession.selectList("fboard.selectList", map);
	}
	
//	4. 조회수 증가하기
	public void updateReadCount(SqlSession sqlSession , int idx) {
		sqlSession.update("fboard.updateReadCount", idx);
	}

//	5.저장하기
	public void insert(SqlSession sqlSession, FBoardVO fBoardVO) {
		sqlSession.insert("fboard.insert", fBoardVO);
	}
	
//	6. 수정하기
	public void update(SqlSession sqlSession, FBoardVO fBoardVO) {
		sqlSession.update("fboard.update", fBoardVO);
	}
	
//	7. 삭제하기
	public void delete(SqlSession sqlSession, int idx) {
		sqlSession.delete("fboard.delete" , idx);
	}
}
