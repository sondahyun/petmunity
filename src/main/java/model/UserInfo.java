package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * ����� ������ ���� �ʿ��� ������ Ŭ����. USERINFO ���̺�� ������
 */
public class UserInfo {
	private int userId;	
	private String loginId;
	private String loginPwd;
	private String userNickname;
	private Date userBirth;
	private String phoneNumber;
	private String gender;
	private String address;
	private String email;
	private String joinGroup;
	//private int petList;
	//private ArrayList<Pet> petList; //ArrayList<Integer> => Array(UserDAO findUser���� getArray�� ����
	///private ArrayList<Pet> petList;
	//private int pet;
	
	public UserInfo() {
	}

	public UserInfo(String loginId, String loginPwd, String userNickname, Date userBirth,
			String phoneNumber, String gender, String address, String email) {
		this.loginId = loginId;
		this.loginPwd = loginPwd;
		this.userNickname = userNickname;
		this.userBirth = userBirth;
		this.phoneNumber = phoneNumber;
		this.gender = gender;
		this.address = address;
		this.email = email;
	}
	
	public UserInfo(int userId, String loginId, String loginPwd, String userNickname, Date userBirth,
			String phoneNumber, String gender, String address, String email) {
		super();
		this.userId = userId;
		this.loginId = loginId;
		this.loginPwd = loginPwd;
		this.userNickname = userNickname;
		this.userBirth = userBirth;
		this.phoneNumber = phoneNumber;
		this.gender = gender;
		this.address = address;
		this.email = email;
	}

	private int status;	// 0=활성, 1=탈퇴(소프트 삭제)
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	public int getUserId() {
		return userId;
	}



	public void setUserId(int userId) {
		this.userId = userId;
	}



	public String getLoginId() {
		return loginId;
	}



	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}



	public String getLoginPwd() {
		return loginPwd;
	}



	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}



	public String getUserNickname() {
		return userNickname;
	}



	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}



	public Date getUserBirth() {
		return userBirth;
	}



	public void setUserBirth(Date userBirth) {
		this.userBirth = userBirth;
	}



	public String getPhoneNumber() {
		return phoneNumber;
	}



	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}



	public String getGender() {
		return gender;
	}



	public void setGender(String gender) {
		this.gender = gender;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getJoinGroup() {
		return joinGroup;
	}

	public void setJoinGroup(String joinGroup) {
		this.joinGroup = joinGroup;
	}

	/* ��й�ȣ �˻� */
	public boolean matchPassword(String password) {
		return util.PasswordUtil.matches(password, this.loginPwd);
	}
	
	public boolean isSameUser(UserInfo user) {
        return this.loginId.equals(user.loginId);
    }

	@Override
	public String toString() {
		return "UserInfo [userId=" + userId + ", loginId=" + loginId + ", loginPwd=" + loginPwd + ", userNickname="
				+ userNickname + ", userBirth=" + userBirth + ", phoneNumber=" + phoneNumber + ", gender=" + gender
				+ ", address=" + address + "email"+email+"]";
	}
	
}
