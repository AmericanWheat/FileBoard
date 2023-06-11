package kr.human.fileboard.vo;

import lombok.Data;

@Data
public class UploadVO {
/*	CREATE TABLE upload(
			idx NUMBER PRIMARY KEY,
			REF NUMBER NOT NULL,
			ofile varchar2(300) NOT NULL,
			sfile varchar2(300) NOT null
		);
*/

	private int idx;
	private int ref;
	private String ofile;
	private String sfile;

}
