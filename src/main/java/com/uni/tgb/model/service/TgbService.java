package com.uni.tgb.model.service;

import static com.uni.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.uni.admin.dto.Category;
import com.uni.common.Attachment;
import com.uni.common.PageInfo;
import com.uni.member.model.dto.Member;
import com.uni.tgb.model.dao.TgbDao;
import com.uni.tgb.model.dto.Tgb;
import com.uni.tgb_board.model.dao.TgbBoard_dao;
import com.uni.tgb_board.model.dto.TgbBoard_dto;

public class TgbService {

	public ArrayList<Tgb> selectList(PageInfo pi) {//현재페이지 or 1페이지 공구 글 목록 조회하는 메소드
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().selectList(conn, pi);
		
		close(conn);
		
		return list;
	}

	public int insertTgb(Tgb t, ArrayList<Attachment> fileList) {
		Connection conn = getConnection();
		int result1 =  new TgbDao().insertTgb(conn, t);//공구 글을 등록하는 메소드
		int result2 = new TgbDao().insertAttachment(conn, fileList);//공구글 등록할 때, 첨부파일 등록하는 메소드
		
		if(result1*result2 > 0) {
			
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1*result2;
	}

	public int getlistCount() {
		Connection conn = getConnection();
		int result = new TgbDao().getlistCount(conn);
		
		close(conn);
		
		
		return result;
	}

	public Tgb selectTgb(int bno) {// 해당 번호의 글을 불러오는 메소드
		Connection conn = getConnection();
		Tgb t = new TgbDao().selectTgb(conn, bno);
		
		close(conn);
		
		return t;
	}

	public ArrayList<Attachment> selectAttachment(int bno) {/// 해당 번호의 글의 첨부파일을 불러오는 메소드
		Connection conn = getConnection();
		
		ArrayList<Attachment> list = new TgbDao().selectAttachment(conn, bno);
		
		close(conn);
		
		return list;
	}

	public Tgb updateFormTgb(int bno) {
		Connection conn = getConnection();
		Tgb t = new TgbDao().selectTgb(conn, bno);
		
		close(conn);
		
		return t;
		
	}
	
	public ArrayList<Attachment> updateFormAttachment(int bno) {
		Connection conn = getConnection();
		
		ArrayList<Attachment> list = new TgbDao().selectAttachment(conn, bno);
		
		close(conn);
		
		return list;
	}

	public int deleteTgb(int bno) {//해당 번호 글을 삭제하는 메소드
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteTgb(conn, bno);
		
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		return result; 
	}
	public int deleteTgbAttachment(int bno) {// 해당번호 글의 첨부파일을 삭제하는 메소드
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteTgbAttachment(conn, bno);
		System.out.println("서비스에서 result : "+result);
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}


	public int updateAttachment(String[] fno) { // 수정할 때 선택된 첨부파일을 먼저 지우는 메소드
		Connection conn = getConnection();
		
		int result = new TgbDao().updateAttachment(conn, fno);
		System.out.println("서비스에서 result : "+result);
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public ArrayList<Tgb> searchTgb(PageInfo pi, String keyword) {//현재 페이지와 키워드를 가지고 검색하는 메소드
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().searchTgb(conn, pi, keyword);
		
		close(conn);
		
		return list;
	}

	public int deleteTgbs(int[] bno) {//권오선
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteTgb(conn, bno);
		
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		return result;
	}

	public int deleteTgbAttachments(int[] bno) {//권오선
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteTgbAttachment(conn, bno);
		
		if(result >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int insertWishList(int userNo, int tgbNo) {//찜하기 
		Connection conn = getConnection();
		
		int result = new TgbDao().insertWishList(conn, userNo, tgbNo);
		
		if(result >0) {
			commit(conn);
			
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int selectWish(int userNo, int bno) {// 글 상세조회할때 찜한 내역 들고 오기
		Connection conn = getConnection();
		
		int result = new TgbDao().selectWish(conn, userNo, bno);
		
		close(conn);
		
		return result;
	}

	public int deleteWishList(int userNo, int tgbNo) {//공구 글 상세 뷰에서 찜내역 삭제
		Connection conn = getConnection();
		
		int result = new TgbDao().deleteWishList(conn, userNo, tgbNo);
		
		if(result >0) {
			commit(conn);
			
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public ArrayList<Tgb> wishList(PageInfo pi, int userNO) {// 마이페이지에서 찜내역 불러오기
		Connection conn = getConnection();
		
		ArrayList<Tgb> list = new TgbDao().wishList(conn,pi, userNO);
		
		close(conn);
		
		return list;
	}

	public int getSearchinglistCount(String keyword) {// 검색된 전체 글 수 가져옴
		Connection conn = getConnection();
		int result = new TgbDao().getSearchinglistCount(conn, keyword);
		
		close(conn);
		
		
		return result;
	}

	public int getWishListlistCount(int userNo) {//찜목록 내역 페이징바 전체글수
		Connection conn = getConnection();
		int result = new TgbDao().getWishListlistCount(conn, userNo);
		
		close(conn);
		
		
		return result;
	}

	public ArrayList<Category> getCategory() {//마이페이지 찜목록 내역에 카테고리 가져오기
		Connection conn = getConnection();
		
		ArrayList<Category> list = new TgbDao().getCategory(conn);
		
		close(conn);
		
		return list;
	}

	public int wishListDelete(int user, String[] arr) {
		Connection conn = getConnection();
		int result = new TgbDao().deleteWishList(conn, user, arr);
		
		close(conn);
		
		
		return result;
	}


}
