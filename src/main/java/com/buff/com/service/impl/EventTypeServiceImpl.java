package com.buff.com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buff.com.mapper.EventTypeMapper;
import com.buff.com.service.EventTypeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EventTypeServiceImpl implements EventTypeService {

	@Autowired
	EventTypeMapper eventTypeMapper;
	
	/**
	* @methodName  : updateAll
	* @author      : 정기쁨
	* @date        : 2024.10.17
	* @return      : 매일 자정에 현재 날짜와 이벤트 시작일, 종료일을 비교하여 이벤트 타입을 변경
	*/
	@Override
	public void updateAll() {
		
		try {
			// EVT03(예정)로 타입 변경
			this.eventTypeMapper.updateExpected();
			// 테스트 E00013: EVT01 -> EVT03 되면 성공
			
            // EVT04(진행)로 타입 변경
        	this.eventTypeMapper.updateProgress();
        	// 테스트 E00037: EVT03 -> EVT04 되면 성공
        	
        	// EVT05(종료)로 타입 변경
        	this.eventTypeMapper.updateEnd();
        	// 테스트 E00007: EVT04 -> EVT05 되면 성공
        	
        	//System.out.println("이벤트 변경 메소드 실행!");
        	
        } catch (Exception e) {
            log.debug("이벤트 변경 메소드 에러: " + e.getMessage());
        }
	}

}
