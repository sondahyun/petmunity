package model;

import java.util.Date;

public class AdoptionAnimal {
	private int petId;
	private String gender;
	private int age;
	private String health;
	private String vaccination;
	private String kind;
	private String filename;
	private int postId;

	public AdoptionAnimal() {
		super();
	}
	
	
	public AdoptionAnimal(String gender, int age, String health, String vaccination, String kind, String filename) {
		super();
		this.gender = gender;
		this.age = age;
		this.health = health;
		this.vaccination = vaccination;
		this.kind = kind;
		this.filename = filename;
	}

	public AdoptionAnimal(String gender, int age, String health, String vaccination, String kind, String filename, int postId) {
		super();
		this.gender = gender;
		this.age = age;
		this.health = health;
		this.vaccination = vaccination;
		this.kind = kind;
		this.filename = filename;
		this.postId = postId;
	}

	public AdoptionAnimal(int petId, String gender, int age, String health, String vaccination, String kind,
			String filename, int postId) {
		super();
		this.petId = petId;
		this.gender = gender;
		this.age = age;
		this.health = health;
		this.vaccination = vaccination;
		this.kind = kind;
		this.filename = filename;
		this.postId = postId;
	}
	
	
	public int getPetId() {
		return petId;
	}
	public void setPetId(int petId) {
		this.petId = petId;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getHealth() {
		return health;
	}
	public void setHealth(String health) {
		this.health = health;
	}
	public String getVaccination() {
		return vaccination;
	}
	public void setVaccination(String vaccination) {
		this.vaccination = vaccination;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}

	@Override
	public String toString() {
		return "AdoptionAnimal [petId=" + petId + ", gender=" + gender + ", age=" + age + ", health=" + health
				+ ", vaccination=" + vaccination + ", kind=" + kind + ", filename=" + filename + ", postId=" + postId
				+ "]";
	}
}
