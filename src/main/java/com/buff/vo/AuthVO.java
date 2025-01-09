package com.buff.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class AuthVO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String mbrId;
	private String auth;
}
