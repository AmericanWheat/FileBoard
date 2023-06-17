package kr.human.fileboard.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.fileboard.dao.FBoardDAO;
import kr.human.fileboard.dao.UploadDAO;
import kr.human.fileboard.mybatis.MybatisApp;
import kr.human.fileboard.vo.FBoardVO;
import kr.human.fileboard.vo.PagingVO;
import kr.human.fileboard.vo.UploadVO;
import lombok.extern.java.Log;

@Log
public class FBoardService {
	private static FBoardService instance = new FBoardService();

	private FBoardService() {
	}

	public static FBoardService getInstance() {
		return instance;
	}

	// 1. 목록 보기
	public PagingVO<FBoardVO> selectList(int currentPage, int sizeOfPage, int sizeOfBlock) {
		log.info("서비스 selectList 인수 : " + currentPage + ", " + sizeOfPage + ", " + sizeOfBlock);
		PagingVO<FBoardVO> pagingVO = null;
		SqlSession sqlSession = null;
		FBoardDAO fBoardDAO = null;
		UploadDAO uploadDAO = null;

		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			fBoardDAO = FBoardDAO.getInstance();
			uploadDAO = UploadDAO.getInstance();
//		---------------------------------------
			int totalCount = fBoardDAO.selectCount(sqlSession);
			pagingVO = new PagingVO<>(totalCount, currentPage, sizeOfPage, sizeOfBlock);
			HashMap<String, Integer> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			List<FBoardVO> list = fBoardDAO.selectList(sqlSession, map);
			if (list != null) {
				for (FBoardVO vo : list) {
					List<UploadVO> fileList = uploadDAO.selectFileList(sqlSession, vo.getIdx());
					vo.setUploadList(fileList);
				}
			}
			pagingVO.setList(list);
//		---------------------------------------

			sqlSession.commit();
		} catch (Exception e) {
			// TODO: handle exception
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
		log.info("서비스 selectList 리턴 : " + pagingVO);
		return pagingVO;

	}

	// 2. 저장 하기
	public void insert(FBoardVO fBoardVO) {
		log.info("서비스 insert 인수 : " + fBoardVO);
		SqlSession sqlSession = null;
		FBoardDAO fBoardDAO = null;
		UploadDAO uploadDAO = null;

		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			fBoardDAO = FBoardDAO.getInstance();
			uploadDAO = UploadDAO.getInstance();

//			----------------------------------------------------
			if (fBoardVO != null) {
				if (fBoardVO.getName() != null && fBoardVO.getName().trim().length() > 0) {
					fBoardDAO.insert(sqlSession, fBoardVO);
					if (fBoardVO.getUploadList() != null && fBoardVO.getUploadList().size() > 0) {
						for (UploadVO vo : fBoardVO.getUploadList()) {
							if (vo != null)
								uploadDAO.insert(sqlSession, vo);
						}
					}
				}
			}
			sqlSession.commit();
//			----------------------------------------------------

		} catch (Exception e) {
			// TODO: handle exception
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
	}

	public FBoardVO selectByIdx(int idx) {
		FBoardVO fBoardVO = null;
		SqlSession sqlSession = null;
		FBoardDAO fBoardDAO = null;
		UploadDAO uploadDAO = null;

		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			fBoardDAO = FBoardDAO.getInstance();
			uploadDAO = UploadDAO.getInstance();

			fBoardVO = fBoardDAO.selectByIdx(sqlSession, idx);
			if (fBoardVO != null) {
				List<UploadVO> fileList = uploadDAO.selectFileList(sqlSession, fBoardVO.getIdx());
				fBoardVO.setUploadList(fileList);
			}

			sqlSession.commit();
		} catch (Exception e) {
			if (sqlSession != null)
				sqlSession.rollback();
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}
		log.info("selectByIdx 리턴값: " + fBoardVO);
		return fBoardVO;
	}

}
