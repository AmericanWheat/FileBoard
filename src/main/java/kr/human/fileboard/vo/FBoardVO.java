package kr.human.fileboard.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FBoardVO {
/*
	CREATE SEQUENCE fboard_seq_idx;

	CREATE TABLE fboard (
		idx NUMBER PRIMARY KEY,
		name varchar2(100) NOT NULL,
		password varchar2(100) NOT NULL,
		subject varchar2(300) NOT NULL,
		content varchar2(2000) NOT NULL,
		readCount NUMBER(4) DEFAULT 0,
		regDate timestamp DEFAULT sysdate,
		ip varchar2(40) NOT null
	);
*/
	private int idx;
	private String name;
	private String password;
	private String subject;
	private String content;
	private int readCount;
	private Date regDate;
	private String ip;

	private List<UploadVO> uploadList;
}
