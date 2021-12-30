package stay.data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import stay.data.dto.RoomDto;
import stay.data.dto.RoomReserGcomDto;
import stay.data.mapper.RoomMapper;

@Service
public class RoomService {
	@Autowired
	RoomMapper mapper;
	
	public int getRoomCount() {
		return mapper.getRoomCount();
	}
	
	public int getRoomMaxNo() {
		return mapper.getRoomMaxNo();
	}
	
	public void insertRoom(RoomDto roomDto) {
		mapper.insertRoom(roomDto);
	}
	
	public List<RoomReserGcomDto> getAllRoom(int start, int perPage) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("start", start);
		map.put("perPage", perPage);
		
		return mapper.getAllRoom(map);
	}
	
	public RoomDto getRoom(String no) {
		return mapper.getRoom(no);
	}
	
	public RoomReserGcomDto getOneRoom(String no) {
		return mapper.getOneRoom(no);
	}
	
	public void updateRoom(RoomDto roomDto) {
		mapper.updateRoom(roomDto);
	}
	
	public List<RoomDto> getBestRoom() {
		return mapper.getBestRoom();
	}
}