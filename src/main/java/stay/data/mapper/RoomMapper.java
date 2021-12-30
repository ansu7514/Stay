package stay.data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import stay.data.dto.RoomDto;
import stay.data.dto.RoomReserGcomDto;

@Mapper
public interface RoomMapper {
	public int getRoomCount();
	public int getRoomMaxNo();
	public void insertRoom(RoomDto roomDto);
	public List<RoomReserGcomDto> getAllRoom(HashMap<String, Integer> map);
	public RoomDto getRoom(String no);
	public RoomReserGcomDto getOneRoom(String no);
	public void updateRoom(RoomDto roomDto);
	public List<RoomDto> getBestRoom();
}