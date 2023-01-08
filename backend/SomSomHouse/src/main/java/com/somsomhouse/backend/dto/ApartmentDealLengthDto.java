package com.somsomhouse.backend.dto;

public class ApartmentDealLengthDto {
	int deal_no;
	String name;
	int wall_sae_freq;
	
	public int getDeal_no() {
		return deal_no;
	}
	public void setDeal_no(int deal_no) {
		this.deal_no = deal_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getWall_sae_freq() {
		return wall_sae_freq;
	}
	public void setWall_sae_freq(int wall_sae_freq) {
		this.wall_sae_freq = wall_sae_freq;
	}
	public int getGeon_sae_freq() {
		return geon_sae_freq;
	}
	public void setGeon_sae_freq(int geon_sae_freq) {
		this.geon_sae_freq = geon_sae_freq;
	}
	int geon_sae_freq;
}
