CREATE SEQUENCE fboard_idx_seq;

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

CREATE sequence upload_idx_seq;

CREATE TABLE upload(
	idx NUMBER PRIMARY KEY,
	REF NUMBER NOT NULL,
	ofile varchar2(300) NOT NULL,
	sfile varchar2(300) NOT null
);