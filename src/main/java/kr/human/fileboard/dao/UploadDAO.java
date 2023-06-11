package kr.human.fileboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import kr.human.fileboard.vo.UploadVO;

public class UploadDAO {
	private static UploadDAO instance = new UploadDAO();

	private UploadDAO() {
	}

	public static UploadDAO getInstance() {
		return instance;
	}

//	1. 지정 번호의 첨부 파일 목록
	public List<UploadVO> selectFileList(SqlSession sqlSession, int ref) {
		return sqlSession.selectList("upload.selectFileList", ref);
	}

//	2.저장하기
	public void insert(SqlSession sqlSession, UploadVO uploadVO) {
		sqlSession.insert("upload.insert", uploadVO);
	}

//	3. 해당 글번호 삭제하기
	public void deleteByIdx(SqlSession sqlSession, int idx) {
		sqlSession.delete("upload.deleteByIdx", idx);
	}

//	4. 해당 ref에 해당하는 모든 파일 삭제하기
	public void deleteByRef(SqlSession sqlSession, int ref) {
		sqlSession.delete("upload.deleteByRef", ref);
	}

}
